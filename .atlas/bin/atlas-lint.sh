#!/usr/bin/env bash
# Lints Atlas task files for structural and formatting drift.
#
# Usage: bash .atlas/bin/atlas-lint.sh [file ...]
#
# With no arguments, lints all three task files in the vault. Warnings go to
# stderr. Always exits 0: this reports, it does not block.
#
# Checks are deliberately deterministic. The linter validates Atlas's file
# contract, but leaves classification, wording, and prioritisation to the
# workflows and the user.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VAULT="${ATLAS_VAULT:-${CLAUDE_PROJECT_DIR:-$(cd "$SCRIPT_DIR/../.." && pwd)}}"

TARGETS=("$@")
if [[ ${#TARGETS[@]} -eq 0 ]]; then
  TARGETS=("$VAULT/Next Actions.md" "$VAULT/Projects.md" "$VAULT/Waiting For.md")
fi

# Cross-file checks always use the canonical task files. This catches a broken
# reference caused by renaming a project, even when the hook only passes
# Projects.md as the edited file.
CROSS_TARGETS=()
CROSS_TARGET_COUNT=0
for target in "$VAULT/Next Actions.md" "$VAULT/Waiting For.md"; do
  if [[ -f "$target" ]]; then
    CROSS_TARGETS+=("$target")
    CROSS_TARGET_COUNT=$((CROSS_TARGET_COUNT + 1))
  fi
done

append_warning() {
  local category="$1"
  local findings="$2"

  if [[ -n "$findings" ]]; then
    WARNINGS+=$'\n['"$category"$']\n'"$findings"$'\n'
  fi
}

lint_inline_fields() {
  local file="$1"

  awk '
    /<!--/ { in_comment = 1 }
    !in_comment {
      line = $0

      # Known Atlas fields require one space after :: and a non-empty value.
      if (line ~ /\[(project|due|for|src|created|completed)::[^ ]/) {
        print FNR ": expected a space after :: | " $0
      }
      if (line ~ /\[(project|due|for|src|created|completed)::  +/) {
        print FNR ": expected exactly one space after :: | " $0
      }
      if (line ~ /\[(project|due|for|src|created|completed)::[[:space:]]*\]/) {
        print FNR ": inline field has no value | " $0
      }

      # Every recognised opening marker needs a closing bracket somewhere
      # after it. This intentionally permits nested Markdown links in src.
      rest = line
      while (match(rest, /\[(project|due|for|src|created|completed)::/)) {
        tail = substr(rest, RSTART)
        if (index(tail, "]") == 0) {
          print FNR ": inline field is not closed | " $0
          break
        }
        rest = substr(rest, RSTART + RLENGTH)
      }
    }
    /-->/ { in_comment = 0 }
  ' "$file"
}

lint_dates() {
  local file="$1"

  awk '
    /<!--/ { in_comment = 1 }
    !in_comment {
      rest = $0
      while (match(rest, /\[(due|created|completed)::[^]]*\]/)) {
        field = substr(rest, RSTART, RLENGTH)
        if (field !~ /^\[(due|created|completed):: [0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]\]$/) {
          print FNR ": expected YYYY-MM-DD | " $0
          break
        }
        rest = substr(rest, RSTART + RLENGTH)
      }
    }
    /-->/ { in_comment = 0 }
  ' "$file"
}

lint_action_lines() {
  local file="$1"

  awk '
    /<!--/ { in_comment = 1 }
    !in_comment && /^- / && $0 !~ /^- \[[ xX]\] / {
      print FNR ": action-list bullet is not a checkbox | " $0
    }
    /-->/ { in_comment = 0 }
  ' "$file"
}

lint_next_actions() {
  local file="$1"

  awk '
    BEGIN {
      allowed["@deep-work"] = 1
      allowed["@computer"] = 1
      allowed["@call"] = 1
      allowed["@meeting"] = 1
      allowed["@errand"] = 1

      required["@deep-work"] = 1
      required["@computer"] = 1
      required["@call"] = 1
      required["@meeting"] = 1
    }
    /<!--/ { in_comment = 1 }
    !in_comment && /^## / {
      context = ""
      if ($0 ~ /^## @/) {
        context = substr($0, 4)
        if (!allowed[context]) {
          print FNR ": unknown context heading " context " | " $0
        }
        if (seen[context]++) {
          print FNR ": duplicate context heading " context " | " $0
        }
      }
      next
    }
    !in_comment && /^- \[[ xX]\] / {
      if (!allowed[context]) {
        print FNR ": action is outside a recognised context | " $0
      }
      if (context == "@meeting" && $0 !~ /\[for:: [^]]+\]/) {
        print FNR ": @meeting action is missing [for:: Full Name] | " $0
      }
    }
    /-->/ { in_comment = 0 }
    END {
      for (context in required) {
        if (!seen[context]) {
          print "missing required context heading ## " context
        }
      }
    }
  ' "$file" | sort
}

lint_projects() {
  local file="$1"

  awk '
    function finish_project() {
      if (project != "" && !has_next_action) {
        print project_line ": project " project " has no non-empty **Next action:** field"
      }
    }
    /<!--/ { in_comment = 1 }
    !in_comment && /^### / {
      finish_project()
      project = substr($0, 5)
      project_line = FNR
      has_next_action = 0
      if (seen_project[project]++) {
        print FNR ": duplicate project heading " project
      }
      next
    }
    !in_comment && project != "" && /^- \*\*Next action:\*\*/ {
      value = $0
      sub(/^- \*\*Next action:\*\*[[:space:]]*/, "", value)
      if (value != "") {
        has_next_action = 1
      }
    }
    /-->/ { in_comment = 0 }
    END { finish_project() }
  ' "$file"
}

lint_waiting_for() {
  local file="$1"

  awk '
    /<!--/ { in_comment = 1 }
    !in_comment && /^- \[ \] / {
      if ($0 !~ /^- \[ \] \*\*[^*]+\*\*:/) {
        print FNR ": active item is missing **Person/team**: | " $0
      }

      lower = tolower($0)
      has_due_field = ($0 ~ /\[due:: [0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]\]/)
      has_follow_up_date = (lower ~ /follow up/ && $0 ~ /[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]/)
      if (!has_due_field && !has_follow_up_date) {
        print FNR ": active item has no follow-up date or [due:: YYYY-MM-DD] | " $0
      }
    }
    /-->/ { in_comment = 0 }
  ' "$file"
}

lint_file() {
  local file="$1"
  local basename
  basename="$(basename "$file")"

  case "$basename" in
    "Next Actions.md"|"Projects.md"|"Waiting For.md") ;;
    *) return 0 ;;
  esac

  [[ -f "$file" ]] || return 0

  WARNINGS=""
  append_warning "inline fields" "$(lint_inline_fields "$file")"
  append_warning "date format" "$(lint_dates "$file")"

  case "$basename" in
    "Next Actions.md")
      append_warning "checkboxes" "$(lint_action_lines "$file")"
      append_warning "contexts" "$(lint_next_actions "$file")"
      ;;
    "Projects.md")
      append_warning "project next actions" "$(lint_projects "$file")"
      ;;
    "Waiting For.md")
      append_warning "checkboxes" "$(lint_action_lines "$file")"
      append_warning "waiting-for structure" "$(lint_waiting_for "$file")"
      ;;
  esac

  if [[ -n "$WARNINGS" ]]; then
    echo "atlas-lint warnings for $file:" >&2
    printf '%s' "$WARNINGS" >&2
  fi
}

lint_project_references() {
  local projects_file="$VAULT/Projects.md"

  [[ -f "$projects_file" ]] || return 0
  [[ $CROSS_TARGET_COUNT -gt 0 ]] || return 0

  awk '
    FNR == 1 { in_comment = 0 }
    /<!--/ { in_comment = 1 }
    FILENAME == ARGV[1] && !in_comment && /^### / {
      projects[substr($0, 5)] = 1
    }
    FILENAME != ARGV[1] && !in_comment {
      rest = $0
      while (match(rest, /\[project:: [^]]+\]/)) {
        field = substr(rest, RSTART, RLENGTH)
        project = field
        sub(/^\[project:: /, "", project)
        sub(/\]$/, "", project)
        if (!projects[project]) {
          print FILENAME ":" FNR ": project reference has no matching heading in Projects.md: " project
        }
        rest = substr(rest, RSTART + RLENGTH)
      }
    }
    /-->/ { in_comment = 0 }
  ' "$projects_file" "${CROSS_TARGETS[@]}"
}

lint_duplicate_actions() {
  [[ $CROSS_TARGET_COUNT -gt 0 ]] || return 0

  awk '
    FNR == 1 { in_comment = 0 }
    /<!--/ { in_comment = 1 }
    !in_comment && /^- \[ \] / {
      key = $0
      sub(/^- \[ \] /, "", key)
      sub(/ \[(project|due|for|src|created|completed)::.*/, "", key)
      gsub(/[[:space:]]+/, " ", key)
      sub(/^[[:space:]]+/, "", key)
      sub(/[[:space:]]+$/, "", key)
      key = tolower(key)

      if (key != "" && first[key] != "") {
        print FILENAME ":" FNR ": duplicates " first[key] " | " $0
      } else if (key != "") {
        first[key] = FILENAME ":" FNR
      }
    }
    /-->/ { in_comment = 0 }
  ' "${CROSS_TARGETS[@]}"
}

for target in "${TARGETS[@]}"; do
  lint_file "$target"
done

CROSS_WARNINGS=""
PROJECT_REFERENCE_WARNINGS="$(lint_project_references)"
if [[ -n "$PROJECT_REFERENCE_WARNINGS" ]]; then
  CROSS_WARNINGS+=$'\n[project references]\n'"$PROJECT_REFERENCE_WARNINGS"$'\n'
fi

DUPLICATE_WARNINGS="$(lint_duplicate_actions)"
if [[ -n "$DUPLICATE_WARNINGS" ]]; then
  CROSS_WARNINGS+=$'\n[duplicate actions]\n'"$DUPLICATE_WARNINGS"$'\n'
fi

if [[ -n "$CROSS_WARNINGS" ]]; then
  echo "atlas-lint cross-file warnings:" >&2
  printf '%s' "$CROSS_WARNINGS" >&2
fi

exit 0

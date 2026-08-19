#!/usr/bin/env bash
# Lints Atlas task files for formatting-convention breaches.
#
# Usage: bash .atlas/bin/atlas-lint.sh [file ...]
#
# With no arguments, lints all three task files in the vault. Warnings go to
# stderr. Always exits 0: this reports, it does not block.
#
# Claude Code runs this automatically after Write and Edit via the
# PostToolUse hook. On any other harness, run it after editing a task file.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VAULT="${ATLAS_VAULT:-${CLAUDE_PROJECT_DIR:-$(cd "$SCRIPT_DIR/../.." && pwd)}}"

TARGETS=("$@")
if [[ ${#TARGETS[@]} -eq 0 ]]; then
  TARGETS=("$VAULT/Next Actions.md" "$VAULT/Projects.md" "$VAULT/Waiting For.md")
fi

lint_file() {
  local file="$1"

  # Only these files carry the inline-field conventions.
  case "$(basename "$file")" in
    "Next Actions.md"|"Projects.md"|"Waiting For.md") ;;
    *) return 0 ;;
  esac

  [[ -f "$file" ]] || return 0

  local warnings=""

  # Catch dates that are not in YYYY-MM-DD format inside inline fields.
  local bad_dates
  bad_dates=$(grep -nE '\[(due|created|completed):: [^]]*\]' "$file" 2>/dev/null \
    | grep -vE '\[(due|created|completed):: [0-9]{4}-[0-9]{2}-[0-9]{2}\]' || true)
  if [[ -n "$bad_dates" ]]; then
    warnings+=$'\n[date format] Found inline date fields not in YYYY-MM-DD:\n'"$bad_dates"
  fi

  # Note: project-link check removed by design. Ad-hoc tasks without a project
  # link are valid in Next Actions.md.

  if [[ -n "$warnings" ]]; then
    echo "atlas-lint warnings for $file:" >&2
    echo "$warnings" >&2
  fi
}

for target in "${TARGETS[@]}"; do
  lint_file "$target"
done

exit 0

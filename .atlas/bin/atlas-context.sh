#!/usr/bin/env bash
# Prints the core Atlas context: today's date, the reference files, the action
# lists, due and overdue items, and the wiki page roster.
#
# Harness-neutral. Claude Code runs this automatically via the SessionStart
# hook. On any other harness, run it once at the start of a session:
#
#   bash .atlas/bin/atlas-context.sh
#
# Vault root resolution order: $1, then $ATLAS_VAULT, then $CLAUDE_PROJECT_DIR,
# then two levels up from this script.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VAULT="${1:-${ATLAS_VAULT:-${CLAUDE_PROJECT_DIR:-$(cd "$SCRIPT_DIR/../.." && pwd)}}}"

TODAY=$(date +%Y-%m-%d)
WEEKDAY=$(date +%A)

read_file() {
  local path="$1"
  if [[ -f "$path" ]]; then
    cat "$path"
  else
    echo "_(file not found: $path)_"
  fi
}

# Compute due-today and overdue items from Next Actions.md.
# Lexicographic comparison is correct for YYYY-MM-DD.
due_items() {
  local file="$VAULT/Next Actions.md"
  [[ -f "$file" ]] || return 0
  while IFS= read -r line; do
    local d
    d=$(echo "$line" | sed -nE 's/.*\[due:: ([0-9]{4}-[0-9]{2}-[0-9]{2})\].*/\1/p')
    if [[ -n "$d" ]]; then
      if [[ "$d" < "$TODAY" || "$d" == "$TODAY" ]]; then
        echo "$line"
      fi
    fi
  done < "$file"
}

DUE=$(due_items)

cat <<EOF
# Auto-loaded session context

**Today:** $TODAY ($WEEKDAY)
**Loaded by:** .atlas/bin/atlas-context.sh

---

## Reference/Personal.md
$(read_file "$VAULT/Reference/Personal.md")

---

## Reference/Goals.md
$(read_file "$VAULT/Reference/Goals.md")

---

## Inbox.md
$(read_file "$VAULT/Inbox.md")

---

## Projects.md
$(read_file "$VAULT/Projects.md")

---

## Next Actions.md
$(read_file "$VAULT/Next Actions.md")

---

## Waiting For.md
$(read_file "$VAULT/Waiting For.md")
EOF

if [[ -n "$DUE" ]]; then
  cat <<EOF

---

## Due today or overdue (from Next Actions.md)
$DUE
EOF
fi

# Wiki page roster. Names only, so the assistant knows what exists without
# loading content. Read the page itself when a topic comes up. Full catalog
# with hooks is in Wiki/index.md.
if [[ -d "$VAULT/Wiki" ]]; then
  ROSTER=$(cd "$VAULT/Wiki" && find . -name '*.md' -not -name 'index.md' -not -name 'log.md' -not -name 'SCHEMA.md' \
    | sed 's|^\./||; s|\.md$||' | sort)
  if [[ -n "$ROSTER" ]]; then
    cat <<EOF

---

## Wiki pages available
Knowledge layer. Read a page before answering from raw notes. Catalog: Wiki/index.md. Rules: Wiki/SCHEMA.md.

$ROSTER
EOF
  fi
fi

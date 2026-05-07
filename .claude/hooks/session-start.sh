#!/usr/bin/env bash
# Auto-loads core GTD context at session start.
# Output goes to stdout and is injected into Claude's context.
set -euo pipefail

VAULT="${CLAUDE_PROJECT_DIR:-$(pwd)}"
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

# Compute due-today and overdue items from Next Actions.md
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
**Loaded by:** SessionStart hook

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

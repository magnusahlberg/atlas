#!/usr/bin/env bash
# Lints task files after a Write or Edit. Non-blocking: prints warnings to
# stderr so Claude sees them and can self-correct on the next turn. Does not
# exit non-zero (would block follow-on work).
set -euo pipefail

VAULT="${CLAUDE_PROJECT_DIR:-$(pwd)}"

# Read the JSON envelope from stdin and pull out the file_path field.
# Avoids requiring jq by using a small python one-liner.
INPUT=$(cat)
FILE_PATH=$(printf '%s' "$INPUT" | python3 -c "
import json, sys
try:
    data = json.load(sys.stdin)
    print(data.get('tool_input', {}).get('file_path', ''))
except Exception:
    print('')
" 2>/dev/null || echo "")

# Only lint specific files
case "$(basename "$FILE_PATH")" in
  "Next Actions.md"|"Projects.md"|"Waiting For.md") ;;
  *) exit 0 ;;
esac

[[ -f "$FILE_PATH" ]] || exit 0

WARNINGS=""

# Catch dates that are not in YYYY-MM-DD format inside inline fields
BAD_DATES=$(grep -nE '\[(due|created|completed):: [^]]*\]' "$FILE_PATH" 2>/dev/null \
  | grep -vE '\[(due|created|completed):: [0-9]{4}-[0-9]{2}-[0-9]{2}\]' || true)
if [[ -n "$BAD_DATES" ]]; then
  WARNINGS+=$'\n[date format] Found inline date fields not in YYYY-MM-DD:\n'"$BAD_DATES"
fi

# Note: project-link check removed by design. Ad-hoc tasks without a project
# link are valid in Next Actions.md.

if [[ -n "$WARNINGS" ]]; then
  echo "post-write-validate.sh warnings for $FILE_PATH:" >&2
  echo "$WARNINGS" >&2
fi

exit 0

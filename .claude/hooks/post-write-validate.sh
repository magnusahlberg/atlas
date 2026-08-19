#!/usr/bin/env bash
# Claude Code PostToolUse hook for Write and Edit. Thin wrapper: pulls the
# edited file path out of the JSON envelope on stdin and hands it to
# .atlas/bin/atlas-lint.sh, which holds the actual checks and is callable
# from any harness.
#
# Non-blocking: the linter prints warnings to stderr and exits 0, so the
# assistant sees them and can self-correct on the next turn.
set -euo pipefail

VAULT="${CLAUDE_PROJECT_DIR:-$(pwd)}"

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

[[ -n "$FILE_PATH" ]] || exit 0

exec bash "$VAULT/.atlas/bin/atlas-lint.sh" "$FILE_PATH"

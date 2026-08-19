#!/usr/bin/env bash
# Claude Code SessionStart hook. Thin wrapper: the logic lives in
# .atlas/bin/atlas-context.sh so other harnesses can call it too.
# Output goes to stdout and is injected into context.
set -euo pipefail

VAULT="${CLAUDE_PROJECT_DIR:-$(pwd)}"
exec bash "$VAULT/.atlas/bin/atlas-context.sh" "$VAULT"

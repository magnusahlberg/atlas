#!/usr/bin/env bash
# Lightweight context injection on every user prompt.
# Keep this fast. Anything heavy belongs in SessionStart.
set -euo pipefail

TODAY=$(date +%Y-%m-%d)
WEEKDAY=$(date +%A)
TIME=$(date +%H:%M)

cat <<EOF
<!-- now: $TODAY $WEEKDAY $TIME (local) -->
EOF

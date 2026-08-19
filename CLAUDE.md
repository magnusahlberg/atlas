# Atlas — Claude Code

The system instructions live in `AGENTS.md`, which is shared across harnesses. Read it and follow it.

@AGENTS.md

## What Claude Code adds

These are handled by the harness, so the bootstrap steps in `AGENTS.md` are already done for you:

- **Core context is auto-loaded.** The `SessionStart` hook runs `.atlas/bin/atlas-context.sh`. Do not call it again unless the context is missing.
- **Today's date arrives on every prompt.** The `UserPromptSubmit` hook injects it as an HTML comment. Trust it over anything you remember from earlier in the session.
- **Task files are linted automatically.** The `PostToolUse` hook runs `.atlas/bin/atlas-lint.sh` after every Write and Edit. Warnings appear on stderr. Act on them on your next turn.
- **Workflows are slash commands.** `/capture`, `/file`, `/daily-plan`, and the rest. Each command file in `.claude/commands/` is a shim that points at `.atlas/workflows/<name>.md` and carries the tool permissions. When a workflow needs changing, edit the file in `.atlas/workflows/`, not the shim.

Details and troubleshooting: `.claude/README.md`.

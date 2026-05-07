# `.claude/` — Atlas config for Claude Code

This directory configures Atlas for Claude Code.

## Layout

```
.claude/
  settings.json          # hook definitions
  hooks/
    session-start.sh     # auto-loads core GTD files at session start
    user-prompt-submit.sh# date stamp on every prompt
    post-write-validate.sh # lints task files after Write/Edit
  commands/
    weekly-review.md     # /weekly-review
    process-inbox.md     # /process-inbox
    scan-loops.md        # /scan-loops
    capture.md           # /capture <text>
    meeting-prep.md      # /meeting-prep <topic>
    daily-plan.md        # /daily-plan
```

## Hooks

| Event | Script | What it does |
|-------|--------|--------------|
| `SessionStart` | `session-start.sh` | Loads Personal.md, Goals.md, Inbox.md, Projects.md, Next Actions.md, Waiting For.md into context. Surfaces due and overdue items. |
| `UserPromptSubmit` | `user-prompt-submit.sh` | Injects current date and time on every prompt. |
| `PostToolUse` (Write\|Edit) | `post-write-validate.sh` | Warns on dates not in YYYY-MM-DD format in task files. |

## Commands

| Command | File |
|---------|------|
| `/setup` | `commands/setup.md` |
| `/capture <text>` | `commands/capture.md` |
| `/process-inbox` | `commands/process-inbox.md` |
| `/daily-plan` | `commands/daily-plan.md` |
| `/weekly-review` | `commands/weekly-review.md` |
| `/scan-loops` | `commands/scan-loops.md` |
| `/meeting-prep <topic>` | `commands/meeting-prep.md` |

## Troubleshooting

**SessionStart hook does nothing.** Run the script manually from the vault root: `bash .claude/hooks/session-start.sh`. Output should show your loaded files. If that fails, check that `$CLAUDE_PROJECT_DIR` is set.

**Date comparisons look wrong.** The hooks use lexicographic comparison on YYYY-MM-DD, which is correct for ISO dates. If ordering looks wrong, the dates are not in YYYY-MM-DD format — the post-write-validate hook will warn on this.

**Hook output is too large.** SessionStart context is capped around 10,000 chars. If your core files exceed that, trim what gets injected in `session-start.sh`.

**Don't want one of the hooks.** Remove its block from `settings.json`.

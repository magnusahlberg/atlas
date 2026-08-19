# `.claude/` — Atlas config for Claude Code

This directory configures Atlas for Claude Code. It holds no workflow logic. The workflows live in `.atlas/workflows/`, shared with every other harness; the files here are thin shims that point at them and declare tool permissions.

## Layout

```
.atlas/
  workflows/             # the workflows themselves, harness-neutral
  bin/
    atlas-context.sh     # loads core GTD context
    atlas-lint.sh        # lints task files
.claude/
  settings.json          # hook definitions
  hooks/
    session-start.sh     # wrapper over atlas-context.sh
    user-prompt-submit.sh# date stamp on every prompt
    post-write-validate.sh # wrapper over atlas-lint.sh
  commands/
    <name>.md            # /<name>, one shim per workflow
```

## Hooks

| Event | Script | What it does |
|-------|--------|--------------|
| `SessionStart` | `session-start.sh` | Runs `.atlas/bin/atlas-context.sh`. Loads Personal.md, Goals.md, Inbox.md, Projects.md, Next Actions.md, Waiting For.md. Surfaces due and overdue items and the wiki roster. |
| `UserPromptSubmit` | `user-prompt-submit.sh` | Injects current date and time on every prompt. |
| `PostToolUse` (Write\|Edit) | `post-write-validate.sh` | Pulls the edited path from the hook payload and runs `.atlas/bin/atlas-lint.sh` on it. Warns about structural and formatting drift in task files. |

## Commands

One shim per workflow, all of the same shape:

```markdown
---
description: <shown in autocomplete>
allowed-tools: <tools this workflow may use>
---

Read `.atlas/workflows/<name>.md` and follow it exactly.

The request is: $ARGUMENTS
```

`/setup`, `/capture`, `/file`, `/process-inbox`, `/focus`, `/daily-plan`, `/weekly-review`, `/scan-loops`, `/meeting-prep`, `/horizons`, `/ingest`, `/ask`, `/lint`.

## Making changes

- **Changing what a workflow does** — edit `.atlas/workflows/<name>.md`. Never the shim.
- **Changing which tools it may use** — edit `allowed-tools` in the shim. Never the workflow body: tool identifiers are harness-specific and belong here.
- **Adding a workflow** — write `.atlas/workflows/<name>.md`, then add a shim.

Keep MCP tool names in `allowed-tools` in their stable form (`mcp__claude_ai_Slack__slack_send_message`). Connection-ID forms (`mcp__<uuid>__slack_send_message`) break when a connection is recreated.

## Troubleshooting

**SessionStart hook does nothing.** Run the script manually from the vault root: `bash .atlas/bin/atlas-context.sh`. Output should show your loaded files. If the wrapper fails but the script works, check that `$CLAUDE_PROJECT_DIR` is set.

**Task-file lint warnings appear.** The linter is non-blocking. It checks checkbox and context structure, inline fields and dates, project next actions and references, Waiting For ownership and follow-up dates, and duplicate actions. Fix the warning or leave it visible for the next review when the right correction needs judgment.

**Date comparisons look wrong.** The scripts use lexicographic comparison on YYYY-MM-DD, which is correct for ISO dates. If ordering looks wrong, the dates are not in YYYY-MM-DD format. The lint hook will warn on this.

**Hook output is too large.** SessionStart context is capped around 10,000 chars. If your core files exceed that, trim what gets injected in `.atlas/bin/atlas-context.sh`.

**Don't want one of the hooks.** Remove its block from `settings.json`. The workflows still work; you just have to run the scripts yourself, as other harnesses do.

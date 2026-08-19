# Contributing to Atlas

Atlas is a personal operating system, so contributions should keep it focused and simple. The goal is a system that works well out of the box for most knowledge workers — not a framework with infinite options.

## What's welcome

- **Bug fixes** — something in a hook, script, or workflow that doesn't work as described
- **Tool adaptations** — making Atlas work with Gmail, Google Calendar, Notion, Linear, etc.
- **Workflow improvements** — better prompts, clearer instructions, more useful output formats
- **Harness support** — entry points for agents other than Claude Code
- **Setup flow improvements** — making `/setup` easier to complete and more useful
- **Documentation** — clearer explanations, better examples

## What to avoid

- Adding complexity for edge cases most people won't hit
- Making the system dependent on specific Obsidian plugins
- Scope creep beyond the core GTD loop (capture → process → review)

## How to contribute

1. Fork the repo
2. Make your changes on a branch
3. Test it (see "Testing a change" below)
4. Open a pull request with a short description of what changed and why

## Two layers: workflow and harness

Atlas separates what a workflow does from how a given agent invokes it.

- **Workflow logic** lives in `.atlas/workflows/<name>.md`. Harness-neutral markdown. No tool identifiers, no `$ARGUMENTS`, no assumption that a hook has run.
- **Harness glue** lives in `.claude/` (and whatever equivalent another agent needs). Shims declare the description and `allowed-tools`, then point at the workflow file. Hooks wrap the scripts in `.atlas/bin/`.

Keep the boundary. A change to what a workflow does belongs in `.atlas/workflows/`. A change to which tools it may call belongs in the shim. The full rules are under "Workflow authoring rules" in `AGENTS.md`.

Two rules that are easy to get wrong:

- **Never name a harness-specific tool in a workflow body.** Write "search my email" and let `Reference/Tools.md` resolve it. MCP tool identifiers differ per harness and go stale.
- **Use stable MCP names in `allowed-tools`.** `mcp__claude_ai_Slack__slack_send_message` is stable. `mcp__<uuid>__slack_send_message` breaks when the connection is recreated.

## Adapting for different tools

The system defaults to Outlook, Teams, and Slack. To adapt for a different stack (Gmail + Google Calendar + Notion, for example):

- `Reference/Tools.md` — the capability map. This is the main one, and it is per-user, not committed
- `.atlas/workflows/scan-loops.md` — update the sources list if the shape of your sources differs
- `.atlas/workflows/setup.md` — update the tool questions in Section 5
- `.claude/commands/*.md` — update `allowed-tools` for the new connectors

Keep the `description` field in each shim's frontmatter accurate — it's what shows in Claude Code's autocomplete.

## File structure

| File | Purpose |
|------|---------|
| `AGENTS.md` | Core instructions — how Atlas behaves, what files exist, workflow rules |
| `CLAUDE.md` | Imports `AGENTS.md`, adds what Claude Code handles automatically |
| `.atlas/workflows/` | The workflows themselves — one file per command, harness-neutral |
| `.atlas/bin/atlas-context.sh` | Loads core GTD context. Any harness can run it |
| `.atlas/bin/atlas-lint.sh` | Lints task files. Any harness can run it |
| `.claude/settings.json` | Hook definitions (which scripts run on which events) |
| `.claude/hooks/` | Thin wrappers over `.atlas/bin/`, plus the prompt date stamp |
| `.claude/commands/` | Slash command shims — one per workflow |
| `.claude/README.md` | How the Claude Code layer is wired, plus troubleshooting |
| `README.md` | User-facing documentation |
| `notes/.gitkeep` | Keeps the notes folder in git without committing personal notes |
| `Wiki/.gitkeep`, `Sources/.gitkeep` | Same, for the optional knowledge layer |

Personal files (inbox, projects, goals, tools, meeting notes) are gitignored and never committed.

## Testing a change

1. Run the affected workflow in Claude Code against a real vault.
2. If you touched a script, run it directly: `bash .atlas/bin/atlas-context.sh`.
3. If you touched a workflow body, sanity-check it on a second agent by asking it to read `AGENTS.md` and then the workflow file. Anything that only works on Claude Code belongs in the shim, not the body.

## Committing your own changes

The `.gitignore` ignores everything by default and unignores only system files, so personal content cannot be committed by accident. To push a change to your fork:

```bash
git add AGENTS.md CLAUDE.md README.md CONTRIBUTING.md .gitignore .atlas/ .claude/
git commit -m "your message"
git push
```

Run `git status --porcelain -uall` first and check nothing personal appears. If you add a new system file at the repo root, it needs an `!/<name>` line in `.gitignore` or git will not see it.

## Philosophy

Atlas should feel like a trusted colleague, not a productivity app. It asks questions, proposes changes, and waits for approval. It doesn't automate decisions. Keep that contract intact in any contribution.

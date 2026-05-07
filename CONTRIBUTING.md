# Contributing to Atlas

Atlas is a personal operating system, so contributions should keep it focused and simple. The goal is a system that works well out of the box for most knowledge workers — not a framework with infinite options.

## What's welcome

- **Bug fixes** — something in a hook or command that doesn't work as described
- **Tool adaptations** — making Atlas work with Gmail, Google Calendar, Notion, Linear, etc.
- **Slash command improvements** — better prompts, clearer instructions, more useful output formats
- **Setup flow improvements** — making `/setup` easier to complete and more useful
- **Documentation** — clearer explanations, better examples

## What to avoid

- Adding complexity for edge cases most people won't hit
- Making the system dependent on specific Obsidian plugins
- Scope creep beyond the core GTD loop (capture → process → review)

## How to contribute

1. Fork the repo
2. Make your changes on a branch
3. Test by running the affected slash commands in Claude Code against a real vault
4. Open a pull request with a short description of what changed and why

## Adapting for different tools

The system defaults to Outlook, Teams, and Slack. To adapt for a different stack (Gmail + Google Calendar + Notion, for example):

- `.claude/commands/scan-loops.md` — update the sources list
- `.claude/commands/setup.md` — update the tool questions in Section 5
- `.claude/commands/daily-plan.md` — update the calendar tool reference

Keep the slash command `description` field in each file's frontmatter accurate — it's what shows in Claude Code's autocomplete.

## File structure

| File | Purpose |
|------|---------|
| `CLAUDE.md` | Core instructions — how Atlas behaves, what files exist, workflow rules |
| `.claude/settings.json` | Hook definitions (which scripts run on which events) |
| `.claude/hooks/` | Shell scripts that run automatically (session start, prompt submit, post-write validation) |
| `.claude/commands/` | Slash command definitions — one file per command |
| `README.md` | User-facing documentation |
| `notes/.gitkeep` | Keeps the notes folder in git without committing personal notes |

Personal files (inbox, projects, goals, meeting notes) are gitignored and never committed.

## Keeping your fork updated

```bash
git add CLAUDE.md README.md .claude/
git commit -m "your message"
git push
```

## Philosophy

Atlas should feel like a trusted colleague, not a productivity app. It asks questions, proposes changes, and waits for approval. It doesn't automate decisions. Keep that contract intact in any contribution.

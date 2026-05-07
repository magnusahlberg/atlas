# Atlas

Most productivity systems fail the same way: the overhead of maintaining them costs more than the clarity they provide. Atlas is different because you don't maintain it — Claude does.

Atlas is a personal operating system built on [GTD](https://gettingthingsdone.com), stored as plain Markdown in [Obsidian](https://obsidian.md), and operated through [Claude Code](https://claude.ai/code). You talk to it in plain language. It captures what you say, scans your email and calendar for things you missed, keeps your lists current, and surfaces what matters — all without you touching a file.

The files are the single source of truth. Atlas is just the interface.

## How it works

- **GTD methodology** — Inbox, Next Actions, Projects, Waiting For, Someday Maybe
- **Obsidian** — plain Markdown with wikilinks and Dataview-compatible inline fields. Your data is portable and readable without any tool.
- **Claude Code** — slash commands and hooks that automate the workflow. `/capture`, `/daily-plan`, `/weekly-review`, `/scan-loops`, and more.

## Requirements

- [Obsidian](https://obsidian.md) (free)
- [Claude Code](https://claude.ai/code) (CLI, desktop app, or VS Code extension)
- Optionally: Outlook, Teams, and Slack connected for open loop scanning

## Setup

1. Clone this repo into a folder on your computer
2. Open the folder in Obsidian as a vault
3. Open the vault root in Claude Code (`claude` from the vault root, or open in Claude Code Desktop)
4. Start a session — the SessionStart hook auto-loads your core GTD files into context
5. Run `/setup` — Claude will ask you questions and write your personal files from the answers

## Slash commands

Type `/` in Claude Code to autocomplete.

| Command | What it does |
|---------|-------------|
| `/setup` | First-run setup and ongoing personalization — role, goals, tools, preferences |
| `/capture <text>` | Append to Inbox.md immediately, no classification |
| `/process-inbox` | Clarify and route all Inbox.md items |
| `/daily-plan` | Today's calendar, due items, top priorities, and follow-ups |
| `/weekly-review` | Full weekly review: inbox, lists, goals, open loop scan |
| `/scan-loops` | Scan email, calendar, Teams, Slack, meeting notes for missed captures |
| `/meeting-prep <topic>` | Pull prior notes, related projects, people, and open items |

## How the files connect

```
Goals.md
  └── Projects.md (each project links to a goal)
        └── Next Actions.md (each action links to a project)
        └── Waiting For.md (each blocked item links to a project)
```

Claude can trace any action back to the goal it serves. When you ask "what should I prioritize," it uses this chain plus due dates to give a real answer.

## Tips

**Be lazy with capture.** Dump raw thoughts. Don't pre-format. Claude does the organizing.

**Process regularly.** An inbox that grows unchecked becomes noise. Process at least twice a week.

**Use context tags.** @deep-work, @computer, @call, @meeting tags in Next Actions let you batch work by mode. "What can I do @computer right now?" gets a useful answer.

**Keep projects honest.** Every project needs a next action. If it's been sitting without movement, define the next step or move it to Someday Maybe. Claude flags this during reviews.

**Scan loops before it's urgent.** `/scan-loops` takes two minutes and often surfaces things you forgot about.

## What Claude has access to

- All files in this vault (read and write)
- Outlook email (search and read)
- Outlook calendar (search and read)
- Teams messages (search and read)
- Slack (search and read)
- Web search
- File creation (documents, spreadsheets, presentations)

Claude does not send emails, accept invites, or post messages without explicit permission.

## Files in this repo

| File | Purpose |
|------|---------|
| `CLAUDE.md` | Instructions that define how Claude operates this system |
| `.claude/` | Hooks and slash commands |
| `README.md` | This file |

**Not in this repo** (created on first run, or personal to you):
- `Inbox.md`, `Projects.md`, `Next Actions.md`, etc. — your working GTD files
- `Reference/Personal.md` — your role, team, communication preferences
- `Reference/Goals.md` — your strategic and operational goals
- `notes/` — your meeting notes

## Personalizing

Sections in `CLAUDE.md` to review and adapt:

- **Open loop scanning** — references a shared Slack canvas. Replace the canvas ID with your own or remove it.
- **Tool access** — assumes Outlook, Teams, and Slack. Adjust for your tools.
- **Formatting conventions** — timezone defaults to UTC. `/setup` will configure your local timezone in `Reference/Personal.md`.

## Keeping it updated

```
git add CLAUDE.md README.md .claude/
git commit -m "your message"
git push
```

Personal data (notes, inbox, projects, goals) is gitignored and will never be committed.

## License

MIT — use it, fork it, adapt it.

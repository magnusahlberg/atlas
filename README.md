# Atlas

Most productivity systems fail the same way: the overhead of maintaining them costs more than the clarity they provide. Atlas is different because you don't maintain it — Claude does.

Atlas is a personal operating system that captures your commitments, scans your email and calendar for things you missed, keeps your task lists current, and surfaces what matters next. You talk to it in plain language. It does the filing.

It's built on [GTD](https://gettingthingsdone.com) (a popular method for managing work and commitments), stores everything as plain text files you own, and runs through [Claude Code](https://claude.ai/code) or any other AI coding agent.

## What you need

- [Claude Code](https://claude.ai/code) — the AI that operates the system. Other agents work too, with fewer conveniences. See [Other AI agents](#other-ai-agents).
- [Obsidian](https://obsidian.md) — a free app for viewing and navigating your files (optional but recommended)
- Optionally: Outlook, Teams, or Slack connected so Atlas can scan for things you've missed

## Getting started

1. Create a new empty folder on your computer
2. Open that folder in Claude Code
3. Paste the prompt below and press Enter — Atlas will install itself and walk you through setup

```
Set up Atlas in this folder. Check if git is available — if yes, run:
  git init
  git remote add origin https://github.com/magnusahlberg/atlas
  git fetch origin main
  git reset --hard origin/main
If git is not available, download and extract
https://github.com/magnusahlberg/atlas/archive/refs/heads/main.zip
(GitHub ZIPs extract into a subfolder — move the contents up into
this folder). Once the files are in place, read AGENTS.md, then
read and follow .atlas/workflows/setup.md to personalise the system.
```

Setup takes about five minutes and only needs to happen once.

## Daily use

Type `/` in Claude Code to see all available commands.

| Command | What it does |
|---------|-------------|
| `/setup` | First-time setup, or update your profile and goals |
| `/capture` | Quickly save a thought, task, or idea without stopping to organise it |
| `/file` | File one thing straight to the right list, with a link back to the email or message it came from |
| `/process-inbox` | Sort everything you've captured into the right place |
| `/daily-plan` | See today's meetings, what's due, and your top priorities |
| `/weekly-review` | Full weekly check-in: clear the inbox, review your lists, scan for missed items |
| `/scan-loops` | Search your email, calendar, and messages for things that should be tracked but aren't |
| `/meeting-prep` | Get a briefing before a meeting — prior notes, open items, relevant projects |
| `/ingest` | Fold a meeting note or document into your knowledge wiki |
| `/ask` | Ask a question and get an answer from the wiki, with sources |
| `/lint` | Health-check the wiki: contradictions, stale pages, gaps |

You can also just talk to Atlas naturally: "what should I focus on this afternoon?", "capture that I need to follow up with Sarah", "am I on track with my goals?"

## Other AI agents

Nothing important is Claude-specific. The workflows are plain markdown in `.atlas/workflows/`, one file per command, and the shared scripts are in `.atlas/bin/`. Instructions live in `AGENTS.md`, the emerging convention that most coding agents read.

To use Atlas with another agent, point it at the folder and ask it to read `AGENTS.md`. To run a workflow, ask for it by name ("run the weekly review workflow") or point at the file.

What you lose outside Claude Code is convenience, not capability:

| | Claude Code | Other agents |
|---|---|---|
| Your lists loaded at session start | Automatic | Agent runs `.atlas/bin/atlas-context.sh` |
| Today's date always correct | Automatic | Agent checks the system clock |
| Task files checked after every edit | Automatic | Agent runs `.atlas/bin/atlas-lint.sh` |
| Workflows as `/commands` | Yes | Ask by name |
| Email, calendar, and chat access | Connectors | Depends on what you have connected |

`AGENTS.md` tells the agent to do the first three itself, so it works either way.

## How your information is organised

Atlas keeps five lists:

- **Inbox** — everything you capture, unfiltered. Processed regularly.
- **Next Actions** — concrete things to do, grouped by context (at your desk, on a call, in a meeting, deep focus)
- **Projects** — anything that takes more than one step to complete
- **Waiting For** — things you've delegated or are blocked on
- **Someday Maybe** — ideas you want to keep but aren't acting on yet

Everything connects back to your goals. When you ask "what should I prioritise?", Atlas uses that chain to give you a real answer.

## Getting things out of your inbox

An email arrives. It needs doing, or it needs raising with someone. You want it off your screen without losing it.

`/file` handles that in one step:

```
/file the enterprise plan proposal from Anna, need a decision this month
/file ask Sam about the migration cutover window
/file https://yourteam.slack.com/archives/C04.../p1754...
```

Atlas finds the email or message, works out where it belongs, and writes the task with a link straight back to the original. Then it tags the email as filed. You can archive it whenever you like: the link in your task list still opens it.

Three things make this work:

**The task stands on its own.** It is written so you can act on it without reopening the email. The link is there for detail, not for reminding you what the thing was.

**Nothing gets proposed to you twice.** Once `/file` has tagged an email, `/scan-loops` leaves it alone, even if it is still sitting in your inbox.

**Things to raise with people are still your tasks.** "Ask Sam about the cutover window" is your job, not Sam's. It goes under `@meeting` tagged with Sam's name, and it shows up when you run `/meeting-prep` for your next conversation with them. Work that Sam actually owns goes in Waiting For instead.

Use `/capture` when you do not want to think about it yet, and `/file` when you already know where it goes.

## The knowledge layer (optional)

The five lists track what needs doing. They do not track what you know.

Once you have accumulated meeting notes, add a `Wiki/` folder. Atlas maintains it for you: one page per person, vendor, system, initiative, or topic, each synthesising what your notes say and citing them. Add a note, run `/ingest`, and every affected page updates. Ask a question, run `/ask`, and you get an answer from the wiki instead of a re-read of six months of notes.

The rules live in `Wiki/SCHEMA.md`, which you can edit. The structure is documented in `AGENTS.md`.

Two boundaries make it work:

- **Raw notes are never edited.** `notes/` and `Sources/` are the record. The wiki is derived from them and can be rebuilt.
- **Actions never go in the wiki.** If it has a checkbox or a due date, it belongs in your lists.

Run `/lint` monthly to catch contradictions, stale pages, and sources that were never ingested.

## What Atlas can access

Atlas only reads and writes files in your vault, plus any tools you connect during setup.

| Tool | What Atlas can do |
|------|------------------|
| Your vault files | Read and write |
| Email | Search, read, and tag as filed (never deletes or moves) |
| Calendar | Search and read |
| Teams / Slack | Search and read |
| Web | Search |

Atlas will never send an email, accept a meeting invite, or post a message on your behalf without asking you first.

## Tips

**Be lazy with capture.** Don't organise as you go — just say it. Atlas sorts it later.

**Use `/file` for anything with a source.** Emails and messages are the things most likely to get lost, and the things where you most often need to see the original later.

**Run `/weekly-review` once a week.** It's the heartbeat of the system. Everything else flows from it.

**Use `/scan-loops` before things fall through the cracks.** It takes two minutes and usually finds something.

## For contributors and developers

See [CONTRIBUTING.md](CONTRIBUTING.md) for how to adapt Atlas for different tools (Gmail, Google Calendar, Notion, etc.), how to contribute, and technical details about the file structure.

## License

MIT — use it, fork it, adapt it.

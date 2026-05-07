# Atlas

Most productivity systems fail the same way: the overhead of maintaining them costs more than the clarity they provide. Atlas is different because you don't maintain it — Claude does.

Atlas is a personal operating system that captures your commitments, scans your email and calendar for things you missed, keeps your task lists current, and surfaces what matters next. You talk to it in plain language. It does the filing.

It's built on [GTD](https://gettingthingsdone.com) (a popular method for managing work and commitments), stores everything as plain text files you own, and runs through [Claude Code](https://claude.ai/code).

## What you need

- [Obsidian](https://obsidian.md) — a free app for viewing and navigating your files
- [Claude Code](https://claude.ai/code) — the AI that operates the system
- Optionally: Outlook, Teams, or Slack connected so Atlas can scan for things you've missed

## Getting started

**1. Get the files**

Download or clone this repository into a folder on your computer.

> Not sure how? Click the green **Code** button on this page, then **Download ZIP**. Unzip it somewhere you'll remember.

**2. Open the folder in Obsidian**

In Obsidian, choose "Open folder as vault" and select the folder you just downloaded. This gives you a clean view of your files as they grow.

**3. Open the same folder in Claude Code**

Open Claude Code and point it at the same folder. Your files will load automatically when the session starts.

**4. Run `/setup`**

Type `/setup` and press Enter. Atlas will ask you a series of questions — your role, your goals, your tools, your preferences — and write your personal files from your answers. This takes about five minutes and only needs to happen once.

After that, you're ready to use it.

## Daily use

Type `/` in Claude Code to see all available commands.

| Command | What it does |
|---------|-------------|
| `/setup` | First-time setup, or update your profile and goals |
| `/capture` | Quickly save a thought, task, or idea without stopping to organise it |
| `/process-inbox` | Sort everything you've captured into the right place |
| `/daily-plan` | See today's meetings, what's due, and your top priorities |
| `/weekly-review` | Full weekly check-in: clear the inbox, review your lists, scan for missed items |
| `/scan-loops` | Search your email, calendar, and messages for things that should be tracked but aren't |
| `/meeting-prep` | Get a briefing before a meeting — prior notes, open items, relevant projects |

You can also just talk to Atlas naturally: "what should I focus on this afternoon?", "capture that I need to follow up with Sarah", "am I on track with my goals?"

## How your information is organised

Atlas keeps five lists:

- **Inbox** — everything you capture, unfiltered. Processed regularly.
- **Next Actions** — concrete things to do, grouped by context (at your desk, on a call, in a meeting, deep focus)
- **Projects** — anything that takes more than one step to complete
- **Waiting For** — things you've delegated or are blocked on
- **Someday Maybe** — ideas you want to keep but aren't acting on yet

Everything connects back to your goals. When you ask "what should I prioritise?", Atlas uses that chain to give you a real answer.

## What Atlas can access

Atlas only reads and writes files in your vault, plus any tools you connect during setup.

| Tool | What Atlas can do |
|------|------------------|
| Your vault files | Read and write |
| Email | Search and read |
| Calendar | Search and read |
| Teams / Slack | Search and read |
| Web | Search |

Atlas will never send an email, accept a meeting invite, or post a message on your behalf without asking you first.

## Tips

**Be lazy with capture.** Don't organise as you go — just say it. Atlas sorts it later.

**Run `/weekly-review` once a week.** It's the heartbeat of the system. Everything else flows from it.

**Use `/scan-loops` before things fall through the cracks.** It takes two minutes and usually finds something.

## For contributors and developers

See [CONTRIBUTING.md](CONTRIBUTING.md) for how to adapt Atlas for different tools (Gmail, Google Calendar, Notion, etc.), how to contribute, and technical details about the file structure.

## License

MIT — use it, fork it, adapt it.

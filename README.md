# Atlas

Most productivity systems fail the same way: the overhead of maintaining them costs more than the clarity they provide. Atlas is different because you don't maintain it — Claude does.

Atlas is a personal operating system that captures your commitments, scans your email and calendar for things you missed, keeps your task lists current, and surfaces what matters next. You talk to it in plain language. It does the filing.

It stores everything as plain text files you own, and runs through [Claude Code](https://claude.ai/code) or any other AI coding agent. If you've never kept a system like this before, the next section is the whole idea in two minutes.

## Never used a system like this?

Then start here. You don't need to have read anything first.

Right now your commitments are probably spread across your head, your inbox, a notes app, and a low background hum of "am I forgetting something?". That works until the week it doesn't.

The method Atlas uses is called [GTD](https://gettingthingsdone.com), for Getting Things Done. Skip the book. The whole thing reduces to four moves:

1. **Get it out of your head.** Anything you're holding onto goes into one list, straight away, unsorted. Your memory is for thinking with, not for storage.
2. **Decide what each thing actually is.** Later, in one pass: is this a task, a project, something someone else owes you, or something you're never realistically going to do?
3. **Keep the lists trustworthy.** A list you don't trust is a list you start ignoring, and then you're back to carrying it all in your head. So you look over everything on a regular rhythm.
4. **Work from the lists, not from your inbox.** When you have twenty minutes, you look at what genuinely fits twenty minutes.

Almost everyone manages 1 and 4. Almost everyone eventually fails at 2 and 3. The sorting and the reviewing are tedious, and the week you fall behind is the week the system quietly stops being true.

Steps 2 and 3 are the parts Atlas does. You capture and you decide; it files, sorts, chases, and tells you when something has gone stale.

## The five lists

Everything Atlas keeps lives in one of five plain-text files. That's the whole data model:

| List | What goes in it |
|------|-----------------|
| **Inbox** | Everything you capture, unsorted. A holding pen, emptied regularly. Nothing lives here permanently. |
| **Next Actions** | Concrete single steps you could actually start. Grouped by where you'd do them: at your desk, on a call, in a meeting, or in deep focus. |
| **Projects** | Anything needing more than one step. Each one points at its next action, so a project can't stall silently. |
| **Waiting For** | Things you're blocked on or have delegated. This is the list that stops people quietly dropping what you asked them for. |
| **Someday Maybe** | Ideas worth keeping but not acting on. Reviewed monthly, guilt-free. |

Two distinctions do most of the work, and both are worth getting right early.

**A project is not a task.** "Sort out the office move" isn't something you can sit down and do. "Email the landlord about access dates" is. If an item makes you feel vaguely tired rather than ready to start, it's a project wearing a task's clothes, and it needs a real next action underneath it.

**Your job and their job are different lists.** If you're waiting on someone, it goes in Waiting For and Atlas reminds you to chase. If you need to raise something with them, that's still your task — it goes in Next Actions under `@meeting`, tagged with their name, and surfaces when you next meet.

Above the lists sit your goals, written during setup. Every task can trace back to one. That chain is what lets Atlas answer "what should I prioritise?" with something better than "the oldest thing".

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

Setup takes about five minutes and only happens once. It's a conversation, not a form: Atlas asks about your role, the people you work with, how you like to be written to, and what you're trying to achieve this year. Answer roughly — you can change any of it later by running `/setup` again. Questions that don't apply to you, say so and it moves on.

## Your first week

Setup writes your profile and goals. The habit is what makes the system real, and it takes about a week to form. Four commands are enough to start.

**Day one, right after setup: empty your head.** Set a timer for fifteen minutes and tell Atlas everything you're carrying. Don't organise it, don't filter it, don't stop to decide whether it matters. Half sentences are fine.

```
/capture book the dentist
/capture that thing with the Q3 numbers I keep not looking at
/capture ask Priya whether we're still doing the offsite
```

Thirty to fifty items is normal. Feeling slightly unwell at the length of the list is also normal, and is rather the point: all of it was in your head a minute ago.

**Day two: sort it.**

```
/process-inbox
```

Atlas walks the list one item at a time, proposes where each thing belongs, and you say yes or correct it. The first pass takes twenty minutes or so. After that it's five. Plenty of items turn out not to matter and get deleted, which is a legitimate and underrated outcome.

**Every morning after that:**

```
/daily-plan
```

Meetings, what's due, what to focus on, and who's waiting on you.

**End of week one:**

```
/weekly-review
```

This is the one that matters. It walks your lists, catches projects with no next action, flags what's going stale, and checks you're still pointed at your goals. Skip it and the system decays within a fortnight. Put it in your calendar now — Friday afternoon works well.

Everything else can wait until the basics feel automatic. When they do, add `/file` and `/scan-loops`: those are the two that stop things falling through the cracks between reviews.

**Two things worth knowing early.** Nothing here has to be tidy. The lists are working documents, and Atlas proposes fixes rather than expecting you to keep them pristine. And if a bad week means you fall behind, you haven't broken anything — run `/weekly-review` and carry on. Recovering is the normal state of a system like this, not a failure of it.

## All the commands

The handful in the last section cover most days. Here's everything, for when you want more. Type `/` in Claude Code to see the list at any time.

| Command | What it does |
|---------|-------------|
| `/setup` | First-time setup, or update your profile and goals |
| `/capture` | Quickly save a thought, task, or idea without stopping to organise it |
| `/file` | File one thing straight to the right list, with a link back to the email or message it came from |
| `/process-inbox` | Sort everything you've captured into the right place |
| `/daily-plan` | See today's meetings, what's due, and your top priorities |
| `/focus` | "I have an hour" — get the best 3-5 things to do in the time you actually have |
| `/weekly-review` | Full weekly check-in: clear the inbox, review your lists, scan for missed items |
| `/scan-loops` | Search your email, calendar, and messages for things that should be tracked but aren't |
| `/meeting-prep` | Get a briefing before a meeting — prior notes, open items, relevant projects |
| `/horizons` | Monthly scan: five questions that surface what's coming before anyone asks |
| `/ingest` | Fold a meeting note or document into your knowledge wiki |
| `/ask` | Ask a question and get an answer from the wiki, with sources |
| `/lint` | Health-check the wiki: contradictions, stale pages, gaps |

You can also just talk to Atlas naturally: "what should I focus on this afternoon?", "capture that I need to follow up with Sarah", "am I on track with my goals?"

`/horizons` is the one command that needs a file you create yourself: `Reference/Strategic-Agenda.md`, your own agenda for a transformation or focus area you are driving. `/horizons` populates its Radar; `/daily-plan` reads it to flag pushes that have gone quiet. Skip it if you are not carrying that kind of remit.

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

Atlas will never send an email, accept a meeting invite, or post a message to anyone else on your behalf without asking you first. The one message it sends unprompted is a direct message to *you*: `/daily-plan` delivers your plan to your own chat so it is on your phone. Drop step 6 of `.atlas/workflows/daily-plan.md` if you would rather it did not.

## Tips

**Be lazy with capture.** Don't organise as you go — just say it, mid-sentence, badly. Atlas sorts it later. The moment capture feels like effort, you stop doing it, and then nothing else works.

**Use `/file` for anything with a source.** Emails and messages get lost more than anything else, and are what you most often need to reopen later.

**Protect the weekly review.** It's the heartbeat. Everything else flows from it, and it's the first thing people drop.

**Use `/scan-loops` when you feel behind.** Two minutes, and it usually finds something you'd forgotten you owed someone.

**Write the next action, not the topic.** "Budget" is not an action. "Draft the Q3 budget outline" is. Atlas will push you on this during `/process-inbox`; it's worth letting it.

## For contributors and developers

See [CONTRIBUTING.md](CONTRIBUTING.md) for how to adapt Atlas for different tools (Gmail, Google Calendar, Notion, etc.), how to contribute, and technical details about the file structure.

## License

MIT — use it, fork it, adapt it.

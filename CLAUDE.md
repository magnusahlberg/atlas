# Atlas — Personal Operating System

## System overview

This folder is a GTD-based personal operating system, formatted for Obsidian and operated through Claude Code. Core files handle workflow; the Reference folder holds stable context; the notes folder holds meeting notes.

The `.claude/` directory provides hooks and slash commands that automate the workflow. A `SessionStart` hook auto-loads core files into context at the start of every session. Use `/weekly-review`, `/process-inbox`, `/scan-loops`, `/capture`, `/meeting-prep`, and `/daily-plan` to run the workflows below.

To set up: populate `Reference/Personal.md` with your role, team, communication preferences, and working style. Populate `Reference/Goals.md` with your strategic and operational goals. The rest follows from there.

## Files

- **Inbox.md** -- Capture bucket. Append anything here without filtering. Process during clarify step.
- **Projects.md** -- Active multi-step outcomes with status, owner, goal link, and pointer to next action.
- **Next Actions.md** -- Concrete next steps grouped by context (@deep-work, @call, @meeting, @computer). This is the working list.
- **Waiting For.md** -- Items delegated or blocked, with who/what/follow-up date.
- **Someday Maybe.md** -- Parked ideas. Review monthly.
- **Archive.md** -- Completed projects and actions.
- **Reference/Personal.md** -- Role, team, communication prefs, working style, development goals. Rarely changes. Use this to calibrate tone and context in everything you produce.
- **Reference/Goals.md** -- Strategic and operational goals with status. Use as the filter for what matters. Every task and decision should connect back to something here.
- **notes/** -- Meeting notes by date and topic (e.g., `2026-04-14-customer-meeting.md`).

## First run

On the first conversation, check whether the following files exist. Create any that are missing with minimal placeholder content:

- `Inbox.md` — empty list with a single comment: `<!-- Capture everything here. Process later. -->`
- `Projects.md` — empty list with a header and instructions comment
- `Next Actions.md` — scaffold with four context headings: @deep-work, @call, @meeting, @computer
- `Waiting For.md` — empty list with a header
- `Someday Maybe.md` — empty list with a header
- `Archive.md` — empty file with a header
- `notes/` — create the folder if it doesn't exist (place a `.gitkeep` file inside)

After creating missing files, tell the user which were created and prompt them to run `/setup` to personalize the system before continuing.

## How to work

1. Core files are auto-loaded at session start via the SessionStart hook. Don't summarize unless asked.
2. Follow the communication preferences in Reference/Personal.md. Short sentences. No filler. No em dashes. Get to the point.
3. When prioritizing: (a) items with upcoming due dates, (b) alignment with goals in Reference/Goals.md, (c) items others are waiting on the user for.
4. Don't be precious about these files. They're working documents. Suggest structural improvements if something isn't working.

## Workflows

The slash commands are the source of truth for each workflow. This is a quick reference:

- **Capture**: when anything actionable surfaces in conversation, append it to Inbox.md immediately. Don't classify.
- **Process inbox**: `/process-inbox` — sort each inbox item into the right list, or delete it.
- **Weekly review**: `/weekly-review` — review all lists and goals, then scan for open loops.
- **Open loop scan**: `/scan-loops` — search email, calendar, Teams, Slack, and recent notes for things not yet captured.
- **Daily plan**: `/daily-plan` — today's calendar, priorities, and follow-ups.
- **Meeting prep**: `/meeting-prep <topic>`.

## Updating files

- **Inbox.md**: Append freely during conversation. No approval needed.
- **Next Actions.md / Waiting For.md / Projects.md**: Propose changes first. Edit after the user approves.
- **Reference/Goals.md**: Only update when the user explicitly asks or a goal status clearly changed. Propose before editing.
- **Reference/Personal.md**: Only update when the user provides new information about their role, team, or preferences. Ask before editing.
- **Archive.md**: Move completed items here when marking done. No approval needed.
- **Meeting notes**: Never modify unless asked.

## Formatting conventions

- Use `[project:: Name]` and `[due:: YYYY-MM-DD]` inline fields for Dataview compatibility.
- Use `[[wikilinks]]` to connect actions to projects to goals.
- Use context tags as headings in Next Actions: @deep-work, @call, @meeting, @computer.
- Use `- [ ]` checkboxes for all actionable items.
- Dates are always YYYY-MM-DD.
- Frontmatter in YAML where relevant.
- Times are always in local time. Use the timezone configured in `Reference/Personal.md`. When reading times from calendar or email tools (which return UTC), convert to local time before recording.

## Meeting notes

The `notes/` subfolder contains meeting notes as .md files, named by date and topic (e.g., `2026-04-14-governance-forum.md`). Don't read these by default.

Pull meeting notes selectively when:

- The user is prepping for a meeting. Check for previous notes on the same recurring meeting.
- Scanning for open loops. Check the last 7 days of notes for uncommitted action items.
- The user references a specific past conversation or decision. Search by date or topic.

## Additional files

The user may add other reference documents to this folder over time (org charts, 4DX templates, governance docs). Use them as context when relevant but don't modify unless asked.

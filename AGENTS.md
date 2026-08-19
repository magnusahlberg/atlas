# Atlas — Personal Operating System

## System overview

This folder is a GTD-based personal operating system, formatted for Obsidian and operated through an AI coding agent. Core files handle workflow; the Reference folder holds stable context; the notes folder holds meeting notes; the Wiki folder holds an LLM-maintained knowledge layer built on top of both.

Two layers, kept apart on purpose:

- **The action layer.** Inbox, Next Actions, Waiting For, Projects, Someday Maybe, Archive. What needs doing.
- **The knowledge layer.** `Wiki/`. What is true, what was decided, and why. Never holds actions.

To set up: populate `Reference/Personal.md` with your role, team, communication preferences, and working style. Populate `Reference/Goals.md` with your strategic and operational goals. Populate `Reference/Tools.md` with what Atlas can reach. The rest follows from there.

## Harness setup

Atlas is harness-neutral. The workflows live as plain markdown in `.atlas/workflows/`, and the shared scripts live in `.atlas/bin/`. Anything harness-specific is a thin shim over those.

**Bootstrap.** At the start of a session, load the core context:

```
bash .atlas/bin/atlas-context.sh
```

That prints today's date, `Reference/Personal.md`, `Reference/Goals.md`, the four action lists, due and overdue items, and the wiki page roster. Run it once, at the start. Do not re-run it every turn. On Claude Code this is automatic via the SessionStart hook, so if that context is already present, skip the call.

**Workflows.** Each file in `.atlas/workflows/` is one workflow. Read the file and follow it. Where a workflow says "run the `ingest` workflow", that means read `.atlas/workflows/ingest.md` and follow it. On harnesses with slash commands, each workflow is also exposed as `/<name>`.

**After editing a task file**, lint it:

```
bash .atlas/bin/atlas-lint.sh "Next Actions.md"
```

Warnings go to stderr. It never blocks. On Claude Code this runs automatically after every Write and Edit.

**Dates.** If you do not already know today's date, get it with `date +%Y-%m-%d`. Never guess it, and never carry a date over from earlier in a long session without rechecking.

**Harness-specific config:**

| Harness | Instructions | Workflow entry points | Automation |
|---|---|---|---|
| Claude Code | `CLAUDE.md` imports this file | `.claude/commands/*.md` shims | Hooks in `.claude/settings.json` |
| Codex and others | `AGENTS.md` (this file) | Read `.atlas/workflows/*.md` directly | None. Run the scripts above manually |

When editing a workflow, edit the file in `.atlas/workflows/`. The shims carry no logic, only the pointer, the argument, and the tool permissions.

## Files

- **Inbox.md** -- Capture bucket. Append anything here without filtering. Process during clarify step.
- **Projects.md** -- Active multi-step outcomes with status, owner, goal link, and pointer to next action.
- **Next Actions.md** -- Concrete next steps grouped by context (@deep-work, @call, @meeting, @computer). This is the working list.
- **Waiting For.md** -- Items delegated or blocked, with who/what/follow-up date.
- **Someday Maybe.md** -- Parked ideas. Review monthly.
- **Archive.md** -- Completed projects and actions.
- **Reference/Personal.md** -- Role, team, communication prefs, working style, development goals. Rarely changes. Use this to calibrate tone and context in everything you produce.
- **Reference/Goals.md** -- Strategic and operational goals with status. Use as the filter for what matters. Every task and decision should connect back to something here.
- **Reference/Tools.md** -- What Atlas can reach, by capability. Read before scanning any external source. If a capability is missing, skip that source and say so.
- **Reference/Strategic-Agenda.md** -- Optional. The user's proactive agenda for a key transformation or strategic focus area (e.g. AI transformation, digital strategy, org change). If present, reviewed during the `weekly-review` and `daily-plan` workflows to surface what should be pushed and to whom. See structure below.
- **notes/** -- Meeting notes by date and topic (e.g., `2026-04-14-customer-meeting.md`). Raw source. Never edited by the assistant.
- **Sources/** -- Optional. Other raw source material: pasted documents, exports, decks, drafts. Anything that is a source rather than a note. Raw source. Never edited by the assistant.
- **Wiki/** -- Optional. The knowledge layer. LLM-maintained markdown pages synthesising the raw sources. See the Wiki section below.
- **.atlas/workflows/** -- The workflows themselves. Harness-neutral markdown.
- **.atlas/bin/** -- Shared scripts: context loader and task-file linter.

## First run

On the first conversation, check whether the following files exist. Create any that are missing with minimal placeholder content:

- `Inbox.md` — empty list with a single comment: `<!-- Capture everything here. Process later. -->`
- `Projects.md` — empty list with a header and instructions comment
- `Next Actions.md` — scaffold with four context headings: @deep-work, @call, @meeting, @computer
- `Waiting For.md` — empty list with a header
- `Someday Maybe.md` — empty list with a header
- `Archive.md` — empty file with a header
- `notes/` — create the folder if it doesn't exist (place a `.gitkeep` file inside)

Do not create `Wiki/` or `Sources/` on first run. They are optional and only worth adding once there are enough raw sources to synthesise. Offer them when the user has accumulated meeting notes and starts asking questions that mean re-reading old ones.

After creating missing files, tell the user which were created and prompt them to run the `setup` workflow to personalize the system before continuing.

## How to work

1. Load core context once per session via the bootstrap above. Don't summarize it unless asked.
2. Follow the communication preferences in Reference/Personal.md. Short sentences. No filler. No em dashes. Get to the point.
3. When prioritizing: (a) items with upcoming due dates, (b) alignment with goals in Reference/Goals.md, (c) items others are waiting on the user for.
4. Don't be precious about these files. They're working documents. Suggest structural improvements if something isn't working.

## Workflows

The files in `.atlas/workflows/` are the source of truth for each workflow. This is a quick reference:

- **capture**: when anything actionable surfaces in conversation, append it to Inbox.md immediately. Don't classify.
- **file**: the single-item fast path. Decide the destination now, write the line with a source link, tag the source as filed. For things that surface between reviews. `capture` defers the decision; `file` makes it.
- **process-inbox**: sort each inbox item into the right list, or delete it.
- **weekly-review**: review all lists and goals, then scan for open loops.
- **scan-loops**: search mail, calendar, chat, and recent notes for things not yet captured.
- **daily-plan**: today's calendar, priorities, and follow-ups.
- **meeting-prep**: prep for a named meeting.
- **horizons**: monthly practice. Five forcing questions to surface what's emerging before anyone asks. Outputs to the Radar in `Reference/Strategic-Agenda.md`.
- **ingest**: fold a source into the wiki. Run after meetings and during the weekly review.
- **ask**: answer a question from the wiki, with citations.
- **lint**: health-check the wiki. Monthly.
- **setup**: interactive personalisation. Writes `Reference/Personal.md`, `Goals.md`, and `Tools.md`.
- **focus**: pick the best 3-5 actions for a given time window.

## Updating files

- **Inbox.md**: Append freely during conversation. No approval needed.
- **Next Actions.md / Waiting For.md / Projects.md**: Propose changes first. Edit after the user approves. One exception: the `file` workflow writes directly, because the user described the item in the same breath as the command. Show the written line so it can be corrected.
- **Reference/Goals.md**: Only update when the user explicitly asks or a goal status clearly changed. Propose before editing.
- **Reference/Personal.md**: Only update when the user provides new information about their role, team, or preferences. Ask before editing.
- **Reference/Tools.md**: Only update when a connection is added or removed. Propose before editing.
- **Reference/Strategic-Agenda.md**: Propose changes first. Edit after approval. If the file does not exist and the user describes a strategic focus area they want to track proactively, offer to create it.
- **Archive.md**: Move completed items here when marking done. No approval needed.
- **Meeting notes**: Never modify unless asked.
- **Sources/**: Never modify. Raw source material.
- **Wiki/**: Edit freely via the `ingest` and `lint` workflows. No approval needed for updates. Ask before deleting or merging pages.

## Formatting conventions

- Use `[project:: Name]`, `[due:: YYYY-MM-DD]`, `[for:: Full Name]`, and `[src:: ...]` inline fields for Dataview compatibility.
- Use `[[wikilinks]]` to connect actions to projects to goals.
- Use context tags as headings in Next Actions: @deep-work, @call, @meeting, @computer.
- `[for:: Full Name]` marks the person an `@meeting` item needs. The item is still the user's action; the person is the context. Work the other person owns goes in Waiting For instead.
- `[src:: [label](url)]` or `[src:: [[wikilink]]]` points back to where an item came from. Always pair it with enough plain text (sender or channel, plus a date) to find the source by search if the link rots. Never drop a `[src::]` when moving an item between lists.
- Emails turned into actions get the mail category `Atlas/Filed`. Add the category; never move the message, since a folder move can invalidate the stored link. The `scan-loops` workflow skips tagged messages.
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

## The wiki (knowledge layer)

Optional. Any user can add it. The pattern: instead of re-reading raw notes every time a question comes up, the LLM incrementally maintains a persistent, interlinked set of markdown pages that compile what is known and keep it current. Raw sources stay immutable. The wiki is derived and disposable, which is what makes it safe to write without asking each time.

Three layers, and the boundaries between them matter more than the contents:

| Layer | Where | Who writes | Authority |
|---|---|---|---|
| Raw sources | `notes/`, `Sources/` | Human | The record of what was said |
| Wiki | `Wiki/` | The assistant | Derived. Wrong sometimes. Cite sources. |
| Ground truth | `Reference/` | Human | Wins over the wiki on any conflict |

The action layer (`Inbox.md`, `Next Actions.md`, `Waiting For.md`, `Projects.md`) is separate again. **Actions never go in the wiki.** If it has a checkbox or a due date, it belongs in GTD. A wiki page may link to an action; it must not track one.

**To set it up**, create `Wiki/SCHEMA.md`. That file configures everything and the three wiki workflows read it at runtime. Recommended structure:

- **What the wiki is** — one paragraph, so the intent survives.
- **The three layers** — which folders are raw, derived, and ground truth.
- **The knowledge vs action boundary** — the rule above, stated explicitly.
- **Page types** — one folder per type. A useful default set: `People/`, `Vendors/`, `Systems/`, `Initiatives/`, `Topics/`. Adapt to the role.
- **Page format** — frontmatter (`type`, `title`, `status`, `updated`) plus sections: what it is, **Current state** (rewritten on ingest), **History** (appended, newest first, every line carrying a source link), **Open questions**, **Links**.
- **Naming** — filename is the title, no dates in wiki filenames, aliases in frontmatter.
- **Ingest rules** — read sources in full, rewrite Current state, append History, flag contradictions inline rather than overwriting, send actions to Inbox, log every run.
- **Query rules** — answer from the wiki first, cite pages, note gaps when falling back to raw sources.
- **Lint checks** — contradictions, stale pages, orphans, missing links, un-ingested sources, boundary violations, placeholder rot, misfiled sources, broken links, index drift.

Two support files: `Wiki/index.md` catalogs every page by category with a one-line hook, plus a "mentioned, no page yet" list. `Wiki/log.md` records ingests, gaps found, and lint runs, newest first.

**Cadence.** `ingest` after meetings and during `weekly-review`. `ask` whenever a question would otherwise mean re-reading notes. `lint` monthly.

**The failure mode to watch.** Pages that become empty templates nobody maintains. If a page type is not being updated by real use, delete it rather than let it rot.

## Workflow authoring rules

Workflows are shared project files — they should work for any leader using this system, regardless of role, industry, org, or harness. Follow these rules:

**What never belongs in a workflow:**
- Personal information: names, email addresses, chat user IDs, usernames, org-specific identifiers
- Hard-coded organizational context: company names, team structures, role-specific assumptions
- Harness-specific tool identifiers (e.g. an `mcp__…` tool name). These differ per harness and go stale. Name the capability instead, and let `Reference/Tools.md` resolve it
- Harness-specific tokens like `$ARGUMENTS`. The workflow body refers to "the request"; the shim injects it
- Assumptions that a hook has already run. State what context is needed and read it if missing

**What belongs in a workflow:**
- Workflow logic that applies to any leader (review, prioritize, push, capture)
- References to convention files that any user can create (e.g. `Reference/Strategic-Agenda.md`)
- Conditional behavior: check whether an optional file or capability exists before using it — never assume

**How to implement personal workflows generically:**
- Define a convention file with a documented structure (see `Reference/Strategic-Agenda.md` below)
- The workflow reads the file at runtime and adapts — the user provides the content, the workflow provides the process
- New optional files belong in `Reference/` and should be documented in the Files section above

**Structure for `Reference/Strategic-Agenda.md`:**
Any user with a major strategic responsibility can create this file. Recommended sections:
- **Vision** — one paragraph on what success looks like in 2-3 years
- **Initiative backlog** — what the user believes should happen, independent of what's been asked, with audience and status
- **Active pushes** — items currently in flight, with owner, due date, and status
- **Key messages** — 3-5 things the user wants stakeholders to understand
- **Communication log** — what has been pushed, to whom, and when
- **Radar** — signals being watched, each tagged `watching / emerging / confirmed`. Confirmed signals graduate to the initiative backlog. Populated and reviewed via the `horizons` workflow.

## Additional files

The user may add other reference documents to this folder over time (org charts, 4DX templates, governance docs). Use them as context when relevant but don't modify unless asked.

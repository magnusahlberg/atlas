---
description: Run the weekly review checklist. Process inbox, scan lists, refresh goals.
allowed-tools: Read, Edit, Write, Glob, Grep, Bash
---

Run the weekly review interactively. For each step, show me the relevant content, propose changes, and wait for my approval before editing files (per the rules in CLAUDE.md).

Steps:

1. **Empty and process Inbox.md.** For each item, walk me through the clarify decision: actionable / not / 2-min / multi-step / waiting on someone. Propose where each item should go.

2. **Review Next Actions.md.** Group by context tag. For each item, ask whether it is still the right next step. Flag stale items (untouched > 2 weeks based on file mtime if available, or by my judgement).

3. **Review Waiting For.md.** Surface anything overdue or without a follow-up date. Propose follow-ups.

4. **Review Projects.md.** For each active project, confirm it has a defined next action and that the next action is captured in `Next Actions.md`. Flag stalled projects.

5. **Review Someday Maybe.md.** Ask if any items should be activated.

6. **Review Reference/Goals.md.** Check for status changes. Propose updates only with my explicit approval (per CLAUDE.md rule).

7. **Open-loop scan.** Run `/scan-loops` to catch missed captures from email, calendar, Teams, Slack, meeting notes, and any shared canvas configured in `Reference/Personal.md`.

At the end, summarize: what was processed, what was deferred, what needs my attention this week.

Format: short sentences, no filler, no em dashes. Follow the formatting conventions in CLAUDE.md (YYYY-MM-DD dates, inline fields, wikilinks, context tags).

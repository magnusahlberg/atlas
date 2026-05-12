---
description: Run the weekly review checklist. Process inbox, scan lists, refresh goals.
allowed-tools: Read, Edit, Write, Glob, Grep, Bash
---

Run the weekly review interactively. For each step, show me the relevant content, propose changes, and wait for my approval before editing files (per the rules in CLAUDE.md).

Steps:

1. **Scan for open loops.** Run `/scan-loops` to pull items from email, calendar, Teams, Slack, meeting notes, and any shared canvas configured in `Reference/Personal.md`. Also review the past 2 weeks of calendar for missed commitments or follow-ups that didn't surface elsewhere. Append findings to `Inbox.md` after my approval. Do not process yet.

2. **Mind sweep.** Ask me: "What's on your mind that isn't captured anywhere yet?" Wait for my response. Append everything I say to `Inbox.md` without filtering or classifying.

3. **Process Inbox.md.** Now that the inbox is complete (existing items + newly scanned), walk me through each item: actionable / not / 2-min / multi-step / waiting on someone. Propose where each item should go. After processing, Inbox.md should be empty or contain only items I explicitly chose to defer.

4. **Review Next Actions.md.** Group by context tag. For each item, ask whether it is still the right next step. Flag stale items (untouched > 2 weeks).

5. **Review Waiting For.md.** Surface anything overdue or without a follow-up date. Propose follow-ups.

6. **Review Projects.md.** For each active project, confirm it has a defined next action captured in `Next Actions.md`. Flag stalled projects.

7. **Review Someday Maybe.md.** Ask if any items should be activated.

8. **Review Reference/Goals.md.** Check for status changes. Propose updates only with my explicit approval (per CLAUDE.md rule).

At the end, summarize: what was processed, what was deferred, what needs my attention this week.

Format: short sentences, no filler, no em dashes. Follow the formatting conventions in CLAUDE.md (YYYY-MM-DD dates, inline fields, wikilinks, context tags).

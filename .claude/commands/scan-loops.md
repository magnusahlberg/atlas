---
description: Scan email, calendar, Teams, Slack, and recent notes for open loops not in the system.
allowed-tools: Read, Grep, Glob, Bash
---

Search connected tools for things that should be tracked but aren't yet. Sources to scan, in order:

1. **Outlook email** (past 7 days): unanswered questions, action items, commitments I made.
2. **Outlook calendar** (next 14 days): meetings needing prep or follow-up.
3. **Teams**: recent messages needing a response.
4. **Slack**: recent messages needing a response.
5. **Shared canvas** (if configured in `Reference/Personal.md`): open agenda items and outstanding actions not yet captured.
6. **Recent meeting notes** in `notes/` (last 7 days): uncommitted action items.

For each potential open loop, cross-reference against `Inbox.md`, `Next Actions.md`, `Waiting For.md`, and `Projects.md` so I do not duplicate.

Present findings as a list of proposed `Inbox.md` entries. Wait for my approval. After approval, append to `Inbox.md` and offer to run `/process-inbox` to clarify them.

Format proposed entries with source tag, e.g. `[outlook] Reply to Mattias about Q2 budget` so I can trace where each came from during clarify.

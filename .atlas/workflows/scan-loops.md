# scan-loops

Scan mail, calendar, chat, and recent notes for open loops not in the system.

---

Search connected tools for things that should be tracked but aren't yet.

**First, check what is reachable.** Read `Reference/Tools.md` to see which of the sources below have a tool wired up in this environment. Scan the ones that do. For the ones that do not, skip them and say so in the output rather than guessing at their contents.

Sources to scan, in order:

1. **Mail inbox** (past 7 days): unanswered questions, action items, commitments others are waiting on me for.
2. **Mail sent items** (past 14 days): emails where I made a commitment, asked a question, or delegated something with no visible follow-up — these are potential Waiting For items.
3. **Calendar** (next 14 days): meetings needing prep or follow-up.
4. **Chat, inbound** (past 7 days): recent messages needing a response. Covers every messaging tool listed in `Reference/Tools.md`.
5. **Chat, outbound** (past 14 days): messages where I committed to something, asked a question, or delegated — potential Waiting For or Next Action items.
6. **Shared canvas or standing agenda doc** (if configured in `Reference/Personal.md`): open agenda items and outstanding actions not yet captured.
7. **Recent meeting notes** in `notes/` (last 7 days): uncommitted action items.

**Skip what is already filed.** Ignore any email carrying the category `Atlas/Filed`. That tag means the `file` workflow already turned it into an action, so proposing it again is a duplicate. The message may still be sitting in the inbox unread; the tag is the signal, not the folder.

For each remaining potential open loop, cross-reference against `Inbox.md`, `Next Actions.md`, `Waiting For.md`, and `Projects.md` so I do not duplicate. Check `[src::]` links too: if a task already points at the source, it is captured.

**Knowledge pass.** If `Wiki/SCHEMA.md` exists, do a second pass over the same sources for durable context rather than actions: decisions taken, status changes, new entities, things that contradict what a wiki page currently says. Report these separately from the open loops, tagged `[wiki]`, and offer to fold them in with the `ingest` workflow after I approve the action items. Do not edit wiki pages during the scan itself.

Present findings as a list of proposed entries. Tag each by destination: `[inbox]`, `[waiting-for]`, or `[next-action]`, plus source tag, e.g. `[inbox][mail] Reply to Anna about the Q2 budget`. Wait for approval. After approval, update the relevant files.

Format proposed entries with source tag so I can trace where each came from during clarify. Number them so I can respond by number.

---
description: Prep for an upcoming meeting. Pulls prior notes, related projects, people, and open items.
allowed-tools: Read, Grep, Glob, Bash
---

Prep me for the meeting described by `$ARGUMENTS`. If `$ARGUMENTS` is empty, ask which meeting.

Steps:

1. **Find prior notes** on the same recurring meeting in `notes/`. Search filenames and content for the topic. Read the most recent 2-3.

2. **Identify carry-over actions** from those prior notes. Cross-reference against `Next Actions.md` and `Waiting For.md`. Surface anything I committed to that has not been followed up.

3. **Find related Projects** in `Projects.md`. Surface their current status and next actions.

4. **Find related People** in `Team/`. Pull context on who will be there and any recent interactions noted in their files.

5. **Surface open Inbox items** that mention the meeting or its participants.

Output a tight prep brief:
- Topline: meeting purpose, who is there.
- Carry-over: my open commitments from last time.
- Status: where related projects stand.
- People notes: anything to be aware of.
- Talking points: what I should raise (suggest 3-5).
- Risks: anything stalled or at risk that this meeting could unblock.

Short sentences. No filler. No em dashes.

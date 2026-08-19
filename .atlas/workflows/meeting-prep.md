# meeting-prep

Prep for an upcoming meeting. Pulls prior notes, related projects, people, and open items.

---

Prep me for the meeting described in the request. If the request is empty, ask which meeting.

Steps:

0. **Start from the wiki.** If `Wiki/index.md` exists, read it and open the pages for the people, vendors, systems, initiatives, and topics this meeting touches. Those pages carry the synthesised history and the open questions, so they are the fastest route to context. Use raw notes to fill gaps, not as the starting point. If the wiki has nothing on the topic, say so, and note it as a gap for the next ingest.

1. **Find prior notes** on the same recurring meeting in `notes/`. Search filenames and content for the topic. Read the most recent 2-3.

2. **Identify carry-over actions** from those prior notes. Cross-reference against `Next Actions.md` and `Waiting For.md`. Surface anything I committed to that has not been followed up.

2a. **Pull the agenda for each attendee.** Search `Next Actions.md` for items tagged `[for:: <Name>]`, plus `@meeting` items naming them. These are things I have been saving for exactly this conversation, so they are the backbone of the talking points. Include any `[src::]` link so I can open the original in one click if the detail matters.

3. **Find related Projects** in `Projects.md`. Surface their current status and next actions.

4. **Find related People** in `Wiki/People/`. Pull context on who will be there, what they own, and the open questions on their pages.

5. **Surface open Inbox items** that mention the meeting or its participants.

Output a tight prep brief:
- Topline: meeting purpose, who is there.
- Carry-over: my open commitments from last time.
- Status: where related projects stand.
- People notes: anything to be aware of.
- Talking points: what I should raise (suggest 3-5).
- Risks: anything stalled or at risk that this meeting could unblock.

Short sentences. No filler. No em dashes.

6. **Draft a MoM (minutes of meeting) capture file.** Create it in `notes/`, named the same way as prior notes on this meeting (e.g. `YYYY-MM-DD <topic>.md`, matching the convention already used for this recurring meeting if one exists). Pre-fill it with the talking points from the brief as headings, each with an empty bullet underneath for capture during the meeting. Match the loose structure of this meeting's prior notes files if they exist (e.g. an `Action till mig:` / `Note till <name>:` tail, or whatever sections that meeting typically uses). This is a draft for the user to fill in live or after; it becomes a raw source once written; do not edit it again after creation unless asked. Tell the user the file was created and where.

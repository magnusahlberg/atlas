# focus

Pick the best 3-5 actions for a specific time window.

---

Surface the best use of the available time window. Not a full plan — just the right 3-5 actions for this specific slot.

**Step 1: Establish the real window.**

Parse the time argument if the request has one (e.g. `1h` = 60 min, `30m` = 30 min, `2h` = 120 min). Default to 60 minutes if none given.

If a calendar tool is available per `Reference/Tools.md`, check for the next meeting starting from now. If a meeting starts within the window, trim the available time accordingly. If the window is now materially shorter than requested, note it (e.g. "You have 40 minutes before your next meeting"). If no calendar tool is available, take the requested window at face value and say you did not check the calendar.

**Step 2: Pull candidates from Next Actions.md.**

Read `Next Actions.md`. Collect all unchecked items. For each, note:
- Due date if present (`[due:: YYYY-MM-DD]`)
- Context tag (`@deep-work`, `@computer`, `@call`, `@meeting`, `@errand`)

**Step 3: Rank by priority.**

Apply this order:
1. **Overdue or due today** — surface first, regardless of context.
2. **Context fit** — match context to the available time. Deep work needs 45+ min uninterrupted. Computer tasks fit in 15–30 min. Calls depend on who. Prefer context-appropriate tasks for the window.
3. **Impact** — prefer tasks others are waiting on me for (look for names in Next Actions items, or cross-reference `Waiting For.md` for follow-ups I own). Prefer items linked to active projects.

Discard: errand-context items if I am clearly at my desk, meeting-context items if there's no meeting imminent, anything that obviously needs more time than the window allows.

**Step 4: Output.**

Lead with a single sentence stating the actual window available.

Then list 3–5 actions. For each:
- The action text as written
- One short phrase on why it tops the list right now (overdue, others waiting, quick win)

No hedging ("if this is already done…"), no headers, no filler, no reasoning summary. Commit to the picks. If a meeting interrupts mid-window, that's fine — the list still stands.

If fewer than 3 good matches exist, say so and suggest what to do with the remaining time (e.g. "only 2 actions fit this window — use the rest to process inbox").

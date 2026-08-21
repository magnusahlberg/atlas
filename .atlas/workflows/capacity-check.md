# capacity-check

Check whether upcoming deadlines actually have open calendar time behind them. Surfaces items at risk before they're overdue, not after.

---

Look ahead over the next 14 days (or the window given in the request) and check whether commitments and calendar reality line up. Read `Reference/Tools.md` first. If no calendar tool is reachable, skip the calendar steps and say so rather than inventing a schedule.

**Step 1: Collect commitments with deadlines.**

Pull every item with a `[due:: YYYY-MM-DD]` in the window from `Next Actions.md` and `Projects.md`. For each, note its context tag (`@deep-work`, `@call`, `@meeting`, `@computer`) and due date. Projects without a due date but with a due next action inherit that date.

**Step 2: Map open calendar time.**

Search the calendar for the same window. Identify open gaps of 45+ minutes (deep-work capacity) and 15–30 minute gaps (computer-task capacity), per day. Convert to local time per `Reference/Personal.md`. Note total open deep-work hours and open computer-task slots between now and each deadline.

**Step 3: Match commitments to capacity.**

For each due item, check whether enough open time of the right kind exists between now and its due date to plausibly complete it:
- `@deep-work` items need at least one open 45+ minute gap before the deadline.
- `@computer` items need at least one open 15+ minute gap before the deadline.
- `@call` and `@meeting` items depend on someone else's time, not open gaps — skip the capacity check for these but still flag if the due date has no matching meeting on the calendar at all.

Flag an item **at risk** if no matching gap exists before its due date, or if multiple deep-work items compete for the same handful of gaps (more due items than available slots of the needed length).

**Step 4: Output.**

List at-risk items first, grouped by due date, nearest first. For each:
- The item and its due date
- Why it's at risk (no open slot, or contention with N other items for the same slots)

Then, for each at-risk item, propose one or two specific open calendar slots that could become an `@deep-work` hold, with date and time. Do not create any calendar event without explicit approval — propose and wait.

If everything due in the window has adequate capacity behind it, say so in one line and stop. Do not manufacture risk where none exists.

No filler, no em dashes, short sentences. Number proposed items so I can approve by number (e.g. "1 and 3, yes").

**Step 5: On approval.**

For any slot I approve, create the calendar hold via the calendar write capability in `Reference/Tools.md`. Use a title that references the action (e.g. "Deep work: <action text>"). Do not touch `Next Actions.md` or `Projects.md` — the item itself doesn't change, only the calendar.

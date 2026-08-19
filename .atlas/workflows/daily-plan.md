# daily-plan

Build today's plan. Surfaces meetings, due items, top priorities, and prep needed.

---

Build my plan for today. Read `Reference/Tools.md` for which calendar and messaging tools are available. If no calendar tool is reachable, skip the calendar steps and say so rather than inventing a schedule.

1. **Today's calendar.** List meetings in chronological order. For any meeting that needs prep, flag it and offer to run the `meeting-prep` workflow for it.

2. **Due today or overdue.** Pull items from `Next Actions.md` with `[due:: <today or earlier>]`. Session context may have already surfaced these; reconcile rather than duplicate.

3. **Top 3 priorities.** Based on `Reference/Goals.md` (strategic and operational), `Projects.md`, and what I have committed to, propose three things to focus on today. Prefer deep-work items in the morning.

3b. **Strategic agenda check.** If `Reference/Strategic-Agenda.md` exists, read it. Surface any active items with due dates this week or in Minor Deviation. If a backlog item has had no push in over 2 weeks, flag it as a candidate for today.

4. **Waiting For follow-ups.** Anything in `Waiting For.md` overdue for follow-up. Suggest who to nudge.

5. **Buffer.** Where are the gaps in my calendar where deep work can actually happen? Note the length of each gap.

5b. **Suggested actions for the day.** Using the gaps identified in step 5, surface the best 3–5 actions from `Next Actions.md` to fill them. Apply this ranking:
   1. Overdue or due today — surface first.
   2. Context fit — match the action's context tag to the gap length. Deep work (`@deep-work`) needs 45+ min uninterrupted. Computer tasks (`@computer`) fit 15–30 min. Skip `@meeting` and `@errand` items unless a meeting or errand is imminent.
   3. Impact — prefer tasks others are waiting on, or items linked to active projects with near-term due dates.
   For each suggestion, note the action and one short phrase on why it fits today.

Output as a single tight brief I can scan in 30 seconds. Bullet only where it adds clarity. No filler. Use the timezone configured in `Reference/Personal.md` when converting UTC times from calendar tools.

6. **Send it to me.** After presenting the plan, send the full plan to me as a direct message on the messaging tool marked in `Reference/Tools.md` as the one to use for self-DMs. Look me up by the email address in `Reference/Personal.md`. Confirm once sent. If no messaging tool is available, skip this step silently.

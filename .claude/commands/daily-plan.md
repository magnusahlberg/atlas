---
description: Build today's plan. Surfaces meetings, due items, top priorities, and prep needed.
allowed-tools: Read, Grep, Glob, Bash, mcp__c76d0e0f-4a0a-45c4-ad8a-087bd39eb6a5__slack_search_users, mcp__c76d0e0f-4a0a-45c4-ad8a-087bd39eb6a5__slack_send_message
---

Build my plan for today.

1. **Today's calendar.** List meetings in chronological order. For any meeting that needs prep, flag it and offer to run `/meeting-prep` for it.

2. **Due today or overdue.** Pull items from `Next Actions.md` with `[due:: <today or earlier>]`. The SessionStart hook may have already surfaced these; reconcile rather than duplicate.

3. **Top 3 priorities.** Based on `Reference/Goals.md` (strategic and operational), `Projects.md`, and what I have committed to, propose three things to focus on today. Prefer deep-work items in the morning.

4. **Waiting For follow-ups.** Anything in `Waiting For.md` overdue for follow-up. Suggest who to nudge.

5. **Buffer.** Where are the gaps in my calendar where deep work can actually happen?

Output as a single tight brief I can scan in 30 seconds. Bullet only where it adds clarity. No filler. Use the timezone configured in `Reference/Personal.md` when converting UTC times from calendar tools.

6. **Send to Slack.** After presenting the plan, read the user's email from `Reference/Personal.md`, look them up via `slack_search_users`, and send the full plan as a DM via `slack_send_message`. Confirm once sent.

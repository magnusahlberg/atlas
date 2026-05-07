---
description: Interactive setup — tell Atlas about yourself so it can work the way you do.
allowed-tools: Read, Edit, Write
---

Set up or update this system. Work through each section conversationally — one at a time. Where content already exists in `Reference/Personal.md` or `Reference/Goals.md`, read it first, show the current value, and ask whether to keep or update it.

Do not ask all questions at once. Complete one section, confirm the output, then move to the next.

---

## Section 1: Role and organization

Ask:
- What is your job title and company?
- What team or function do you lead?
- Who do you report to?
- Who are your key stakeholders or owners?

## Section 2: Team

Ask:
- Who are your direct reports? (name and role for each)
- Who are your key cross-functional colleagues you work with regularly?

## Section 3: Communication preferences

Ask:
- What language do you primarily work in?
- How do you like responses — concise and direct, or more detailed?
- Any phrases, styles, or habits to avoid in writing?
- Anything else that matters to you in how Claude communicates with you?

## Section 4: Working style

Ask:
- How do you prefer to work with an AI assistant? (e.g. iterate on drafts, get options, think out loud)
- Any frameworks or methods you rely on day-to-day?
- What does good look like when you're working well?

## Section 5: Connected tools

Ask:
- Which email client do you use? (Outlook, Gmail, other)
- Which calendar? (Outlook, Google Calendar, other)
- Which messaging tools? (Teams, Slack, both, other)

## Section 6: Timezone

Ask:
- What is your timezone? Give both the standard and daylight saving abbreviations if applicable (e.g. CET/CEST, EST/EDT, PST/PDT).

## Section 7: Shared agenda canvas (optional)

Ask:
- Do you have a shared canvas or standing agenda doc with your manager — for example a Slack canvas you both maintain?
- If yes: what is the canvas ID and who is it with?
- If no: skip this step.

## Section 8: Goals

Ask:
- What are your 2-3 strategic goals for this year — the big outcomes you are accountable for?
- What are your current operational goals — active projects, ongoing responsibilities, or near-term priorities? (3-5 is ideal)

---

## After all sections are complete

1. **Write `Reference/Personal.md`** with sections: Role, Team, Communication preferences, Working style, Connected tools, Timezone, Shared canvas. Use the information collected above. Write in plain prose, not bullet dumps — this file is read by Atlas at the start of every session to calibrate tone and context. Include:
   - **Timezone**: the abbreviations and UTC offsets (e.g. "CET (UTC+1) / CEST (UTC+2)")
   - **Shared canvas**: if configured, include the person's name, Slack canvas ID, and link. If not, omit the section.

2. **Write `Reference/Goals.md`** with sections: Strategic goals and Operational goals. For each goal, include a brief description and a status (Active / On hold / Complete).

3. **Summarize** what was written and what to do next (e.g. run `/daily-plan` to get started).

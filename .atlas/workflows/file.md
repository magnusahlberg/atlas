# file

File one thing, right now, with its source. The fast path between reviews.

---

File the request into the right list immediately, with a link back to where it came from.

This is the single-item fast path. It exists for things that surface between reviews: an email, a message, a hallway conversation. The `capture` workflow defers the decision. The `process-inbox` workflow decides in bulk. This decides one item now, while the context is still in my head.

**Speed is the point.** Do not scan. Do not read the wiki, the notes folder, or the mailbox at large. If the core lists are not already in context, read them. Ask at most one question, and only if the destination is genuinely ambiguous.

If the request is empty, ask what to file.

## 1. Resolve the source

If the input references a source, turn it into a link. One lookup maximum. Check `Reference/Tools.md` for which lookups are available here.

- **A pasted URL** (chat permalink, ticket, document): use it as-is.
- **An email**, referenced by sender, subject, or description: run one email search. Take the message's web link from the result. Keep its ID for step 4.
- **A meeting or note** already in the vault: use a `[[wikilink]]`.
- **Nothing resolvable, or no search tool available**: proceed with no `[src::]`. Do not go looking.

If a search returns several plausible matches, list them in one line each and ask which. If it returns nothing, proceed without a source rather than searching again with different terms.

## 2. Pick the destination

| The work is | Destination |
|---|---|
| Mine, single step | `Next Actions.md` under `@computer`, `@deep-work`, `@call`, or `@errand` |
| Mine, but needs another person present | `Next Actions.md` under `@meeting`, with `[for:: Name]` |
| Theirs, and I am waiting on them | `Waiting For.md`, with who and a follow-up date |
| More than one step | `Projects.md`, plus its first next action |
| Not actionable, but worth keeping | `Someday Maybe.md`, or offer the `ingest` workflow if it is durable knowledge |

`@meeting` items are still mine to do. The doer is me; the person is the context. Write them as `With <Name> — <the ask>`.

If the destination is not clear after one question, fall back to capture: append to `Inbox.md` with the source link attached, and say so. The fast path must never block.

## 3. Write the line

Write it directly. Do not propose first. This is the one exception to the approval rule for `Next Actions.md` and `Waiting For.md`, because I just described the item myself. Show me the line afterwards so I can correct it in my next message.

Include, in this order:

- The ask, phrased so it is actionable **without reopening the source**
- Enough plain text to find the source again if the link dies: sender or channel, and a date
- `[for:: Full Name]` on `@meeting` items
- `[project:: Name]` if it belongs to an active project
- `[due:: YYYY-MM-DD]` only if there is a real deadline
- `[src:: [label](url)]` or `[src:: [[wikilink]]]`

```
- [ ] Respond to the enterprise plan proposal (Anna, 2026-08-06) [src:: [mail](https://outlook.office365.com/owa/?ItemID=...)]
- [ ] With Anna — agree the migration cutover window [for:: Anna Example] [project:: Platform migration] [src:: [slack](https://example.slack.com/archives/...)]
```

## 4. Mark the source as filed

If the source was an email and the mail tool supports categories or labels, add the category `Atlas/Filed` to the message. Add the category only. **Do not move the message.** A folder move can change the item ID and break the stored link; a category does not.

This is the handshake that stops the `scan-loops` workflow proposing the same email again next week.

Archiving stays manual. The point of the `[src::]` link is that the message is now safe to archive whenever I want, from my mail client, without losing anything.

If the source was a chat message or anything else with no equivalent tagging, skip this step silently.

## 5. Confirm

One line per item filed. Nothing else. No summary, no next-step suggestions.

```
Atlas: Filed to @meeting — With Anna — agree the migration cutover window [tagged in mail]
```

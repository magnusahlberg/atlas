# ask

Answer a question from the wiki, with citations. Files durable answers back as wiki pages.

---

Answer the question in the request.

If the request is empty, ask what I want to know.

## How to answer

1. Read `Wiki/index.md` to find the relevant pages.
2. Read those pages. Follow their links one hop where it helps.
3. Answer from the wiki. Cite the pages you used.
4. Only fall back to raw sources in `notes/` and `Sources/` when the wiki is thin or silent on the question. If you do, say so explicitly in the answer, and note the gap in `Wiki/log.md` so the next ingest closes it.
5. If the wiki contradicts itself on the question, say that rather than picking a side. Show both claims and their sources.

## Output

- The answer first. Direct. Short sentences. No em dashes. No preamble.
- Then **Sources**: the wiki pages used, and any raw sources you had to reach for.
- Then **Confidence**, but only when it is not high. Say what would raise it.

## After answering

If the answer required real synthesis across three or more pages, and the question is one I am likely to ask again, offer to file it as a `topic` page per `Wiki/SCHEMA.md`. Do not file it without asking.

Append a one-line entry to `Wiki/log.md` for any query that revealed a wiki gap. Skip the log for questions the wiki answered cleanly.

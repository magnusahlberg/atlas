# ingest

Read a source and fold it into the wiki. Updates affected pages, adds cross-links, flags contradictions.

---

Ingest what the request names into the wiki.

The request may be a file path, a folder, a date range, a topic, or empty.

## Resolve what to ingest

- **A path**: ingest that file or every markdown file in that folder.
- **A date or range**: ingest matching files in `notes/`.
- **A topic**: search `notes/` and `Sources/` for matching files, list them, confirm before proceeding.
- **Empty**: find sources not yet referenced by any wiki page, newest first. List them and ask which to ingest. Offer "all" as an option.

## Before starting

1. Read `Wiki/SCHEMA.md`. It defines page types, format, the knowledge-vs-action boundary, and the ingest rules. Follow it exactly.
2. If `Wiki/SCHEMA.md` does not exist, say so and stop. Point me at the schema structure documented in `AGENTS.md`.
3. Read `Wiki/index.md` so you know which pages already exist.

## Per source

1. Read the source in full.
2. List the entities and threads it touches. Match them against existing wiki pages by name and by alias.
3. Decide which pages to update, which to create, and which entities to park as "mentioned, no page yet".
4. Write the updates. Rewrite **Current state**. Append to **History** with a source link. Add cross-links both ways.
5. Where the source contradicts an existing page, flag it inline per the schema rather than overwriting.
6. Where the source contradicts `Reference/`, do not touch `Reference/`. Report the conflict to me.
7. Extract anything actionable and append it to `Inbox.md`. Do not put actions in wiki pages.

## After

1. Update `Wiki/index.md` for any page created or retired.
2. Append one entry to `Wiki/log.md`: date, what was ingested, pages touched, contradictions flagged, actions captured.

## Report back

Short. No filler. No em dashes.

- Sources ingested.
- Pages created.
- Pages updated, with a phrase on what changed in each.
- Contradictions flagged.
- Actions sent to Inbox.
- Anything you deliberately did not capture, and why.

For a large backfill, work in batches and report per batch rather than at the end.

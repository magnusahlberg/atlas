# lint

Health-check the wiki. Contradictions, stale pages, orphans, missing links, un-ingested sources.

---

Lint the wiki. Scope: whatever the request names (a folder, a page type, or a page), otherwise everything under `Wiki/`.

Read `Wiki/SCHEMA.md` first. It defines the checks. Run every check it lists:

1. **Contradictions** between pages, and between pages and `Reference/`.
2. **Stale pages**: `status: active` with no history entry in 90 days.
3. **Orphans**: pages nothing links to.
4. **Missing links**: an entity named in prose that has its own page but no wikilink.
5. **Un-ingested sources**: files in `notes/` or `Sources/` no wiki page references.
6. **Boundary violations**: checkboxes or due dates in wiki pages. These belong in GTD files.
7. **Placeholder rot**: empty template sections.
8. **Misfiled sources**: non-meeting documents sitting in `notes/`.
9. **Broken wikilinks**: links to pages that do not exist.
10. **Index drift**: pages missing from `Wiki/index.md`, or index entries pointing at pages that are gone.

## Output

Group findings by check. Most consequential first. For each finding: the page, the problem in one line, and the fix.

Separate what you can fix mechanically from what needs my judgment.

- **Fix without asking**: broken links with an obvious target, index drift, placeholder rot, missing cross-links, `updated` fields that lag the last real edit.
- **Propose and wait**: contradictions, page merges, page retirements, moving misfiled sources, anything that deletes content.

## After

Append one entry to `Wiki/log.md`: date, scope, counts per check, what you fixed, what is still open.

Short sentences. No filler. No em dashes.

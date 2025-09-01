# Taskmap — Book 3 (The Castle of Glass Arguments)

**Scope:** Track granular tasks for Book 3.
**Status:** Pass-3 COMPLETE; Pass-4 (repro zips + polish) IN PROGRESS.

---

## CONTEXT

- All pages P01–P32 verified via `tests/page_stub_check.py`, `_scripts/lint_pages.ps1`, and `_scripts/make_zips.ps1`.
- Deterministic 7‑line contract enforced (no tabs, 4-space indents).
- Initial clean zips exist; full Pass-4 signoff still needs release bookkeeping (notes + hash record).

## PIPELINE PASSES

- Pass-1 Structure (DONE)
- Pass-2 Narrative alignment (DONE)
- Pass-3 Deterministic stubs & schema (DONE)
- Pass-4 Reproducible zips + light polish (IN PROGRESS)
  - Core requirements: two-zip rotation refreshed, SHA256 logged, roadmap + release notes updated.
  - Optional micro‑polish: tighten illustration phrasing; trim any line >160 chars (goal ≤150 where natural); micro cadence edits without breaking contract.

## ACTIVE TASKS

- [x] P01–P32 stub check green
- [x] Lint green
- [x] Clean zips rotated (initial)
- [ ] Confirm two most recent ZIP hashes appended to `fluff_inventory.md`
- [ ] Release notes entry (Book 3 Pass-3→4) with build tag + primary ZIP SHA
- [ ] Roadmaps snapshot updated with “Pass-4 IN PROGRESS” (main roadmap already shows Pass-3 complete)
- [ ] Final polish sweep (illustration line length, spacing, trailing blanks)
- [ ] Regenerate zips post-polish & verify hashes stable
- [ ] Mark Pass-4 COMPLETE (then consider optional Art v0 later)

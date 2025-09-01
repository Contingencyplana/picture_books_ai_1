# Taskmap — Book 3 (The Castle of Glass Arguments)

**Scope:** Track granular tasks for Book 3.
**Status:** Pass-3 COMPLETE; Pass-4 OPTIONAL/TBD.

---

## CONTEXT

- All pages P01–P32 verified via `tests/page_stub_check.py`, `_scripts/lint_pages.ps1`, and `_scripts/make_zips.ps1`.
- Deterministic 7‑line contract enforced (no tabs, 4-space indents).
- P01–P32 contract-clean; lint/stub/build green; zips confirmed (two-zip rotation).

## PIPELINE PASSES

- Pass-1 Structure (DONE)
- Pass-2 Narrative alignment (DONE)
- Pass-3 Deterministic stubs & schema (DONE)
- Pass-4 Reproducible zips + light polish (OPTIONAL/TBD)
  - If undertaken: refresh two-zip rotation, log SHA256, update roadmap + release notes.
  - Micro‑polish scope (optional): tighten illustration phrasing; trim any line >160 chars; cadence edits (maintain contract).

## OPTIONAL TASKS (Pass-4 Candidate)

- [ ] If Pass-4 scheduled: confirm two most recent ZIP hashes appended to `fluff_inventory.md`
- [ ] If Pass-4 scheduled: release notes entry with build tag + primary ZIP SHA
- [ ] If Pass-4 scheduled: final polish sweep (illustration length, spacing, trailing blanks)
- [ ] If Pass-4 scheduled: regenerate zips post-polish & verify hashes stable
- [ ] If Pass-4 executed: mark Pass-4 COMPLETE (then consider optional Art v0 later)

# Grand Plan — Picture Books Publishing House AI

> **Single source of truth** for *why*, scope, gates, and milestones. Keep this concise and update as milestones shift.

**North Star**
We will build a Picture Book Publishing House AI—and a public library/website of picture books—that both **chronicles** and **embodies** the journey of creating it, told as a heavily disguised saga suitable for children.

## Scope (what we keep adding)
- **Picture Books** (32-page micro-beats)
- **Treasuries of Fairytales** (thematic groupings of finished books)
- **VS Code workspaces** (only when settings/tasks materially differ)

These continue until the capabilities in `skillset.md` are in place.

## Narrative principle: Chronicle & embody
Each shipped artifact does double duty: progresses the system **and** tells the story of that progress in child-friendly allegory.

## Release gates (don’t skip)
- **Book** ✅
  - 32 micro-beats complete + per-page illustration prompt
  - `./_scripts/morning_check.ps1` passes (pytest + ghost scan)
  - Clean ZIP via `./_scripts/make_zips.ps1` (guard + snapshot)
- **Treasury** ✅
  - ≥ 2 finished books sharing theme/audience
  - Table of contents + shared style notes (`art/STYLE_NOTES.md`)
- **Workspace** ✅
  - Documented reason (settings/tasks/extensions) beyond convenience

## Operating cadence
- Morning: `./_scripts/morning_check.ps1`
- Build: `./_scripts/make_zips.ps1` (auto-updates `docs/fluff_inventory.md`)
- Commits: small, labeled, clear intent

## Milestones
- **M1:** First treasury with 2 finished books + style notes
- **M2:** Schema discipline for `ai_player.json` + page linter enforced
- **M3:** CI gate on push (schema + linter + tests)
- **M4:** Public UI stub for browsing treasuries & books

## Anti-goals (for now)
- Image rendering pipeline
- PDF/EPUB exporters
- Complex game mechanics beyond page-level beats

---

> See `skillset.md` for *what skills are needed and who owns them*.

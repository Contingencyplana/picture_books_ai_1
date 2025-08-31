<!-- a0_1_the_witch_who_broke_riddles/taskmaps/README.md -->

# Taskmaps — The Witch Who Broke Riddles (Book 2)

This folder holds the planning “source of truth” for Book 2.

## Files
- `main_taskmap.md` — high-level pass gates and links.
- `code_tasks.md` — 32 page tasks (CT-01..CT-32), one per page.
- `milestones.md` — pagestanza tracker (pages in groups of four) and release checklist.

## How we link pages → tasks
- Pages use **only** the `// Code Task:` line (Book-1 convention).
- No separate “Code Task ID” line is used (tests stay green without it).

## Update cadence
1. Draft pages per pagestanza (4 pages).
2. Tick boxes in `milestones.md`.
3. Run checks:
   - `pwsh -NoProfile -ExecutionPolicy Bypass ./_scripts/lint_pages.ps1 -BookPath a0_1_the_witch_who_broke_riddles`
   - `python tests/page_stub_check.py`
   - `pwsh -NoProfile -ExecutionPolicy Bypass ./_scripts/make_zips.ps1`
4. Record a build snapshot in `fluff_inventory.md` for release builds.

## Safety
- Follow Valiant Citadel: age-appropriate language, zero “gotcha,” invite collaboration.

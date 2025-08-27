# Phases & Stages — Picture Books AI (Workspace 1)

**Purpose:** A short, living plan for the next few steps. Keep it tight and real.

## Now (working set)
- [x] Template + copier + linter + schema in place
- [ ] Seed Book 1 (`a0_0_the_loop_that_wanted_to_close`) pages 01–04 with real text/code/art prompts
- [ ] Run linter on Book 1 and update `taskmaps/milestones.md`
- [ ] Add Book 1 to `a0_0_treasury_of_fairytales/toc.md`

## Phase 0 — Bootstrapping (Done)
- Repo identity: README + workflow + settings.json
- Templates: picture_book_template with 32 page stubs, taskmaps, placeholders
- Automation: `_scripts/new_book.ps1` copier, `_scripts/lint_pages.ps1` linter
- Schema: `_schemas/ai_player.schema.json`
- Stanza convention standardized: books grouped as a0_0–a3_3; treasuries grouped as a0_0–a3_3

## Phase 1 — First Publishable Slice (this week)
- Fill pages 01–08 for Book 1 (3-part page contract: story, `// Code Task:`, `[Illustration: ...]`)
- Complete `ai_player.json` for Book 1 (must validate)
- Lint until clean; check off `taskmaps/milestones.md`
- Export quick PDF draft to `a0_0_treasury_of_fairytales/exports/` (placeholder is fine)

**Definition of Done (book):**
- 32 pages present, linter clean
- `ai_player.json` valid against schema
- `taskmaps/milestones.md` shows 100% complete
- README has 1-line hook + 2-3 sentence synopsis

## Phase 2 — Treasury Spine (next)
- `a0_0_treasury_of_fairytales/toc.md` lists ~16 books with IDs/titles/status
- Use `new_book.ps1` to scaffold 2 more books (IDs only; content later)
- Roadmap draft: `a0_0_treasury_of_fairytales/roadmaps/main_roadmap.md`

## Phase 3 — Art Pass v0 (optional)
- Create a 1-page “style sheet” (`art/STYLE_NOTES.md`) with motifs/palettes
- Ensure each page has a concrete illustration prompt

## Phase 4 — Automation v0 (optional)
- Add GitHub Action to run schema + linter on push (CI green = go)

## Parking Lot
- Treasury template
- Public site UI
- Export pipeline (PDF/EPUB/images)

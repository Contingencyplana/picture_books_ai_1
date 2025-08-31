# Skillset — Picture Books Publishing House AI

**Purpose:** What skills this workspace needs, and who/what owns them.

## Storycraft
- Metaphorical micro-beats (32 pages/book) — **Owner:** Mark (vision), GPT-5 (draft assist)
- Rhythm & readability for ages 5–8 — **Owner:** Mark
- Heavily disguised narrative (allegory) — **Owner:** Mark, GPT-5

## Visuals
- Illustration prompts per page — **Owner:** GPT-5 (draft), Mark (approve)
- Art direction sheet (motifs, palettes) — **Owner:** Mark → `art/STYLE_NOTES.md`
- (Later) Image generation & layout — **Owner:** Tooling TBD

## Engineering & Automation
- Template cloning (`_scripts/new_book.ps1`) — **Owner:** Copilot Pro
- Linting (`_scripts/lint_pages.ps1`) — **Owner:** Copilot Pro
- Schema discipline (`_schemas/ai_player.schema.json`) — **Owner:** GPT-5 (spec), Copilot Pro (enforce)
- (Later) CI (schema + linter on push) — **Owner:** GPT-5 (spec), Copilot Pro (impl.)
- Executable stubs on pages — **Owner:** Copilot Pro (impl.), Mark (approve)

## Structure & Ops
- Organize pages → books (AI players) — **Owner:** Copilot Pro (scaffold), Mark (content)
- Organize books → treasuries — **Owner:** Mark (ToC/roadmap)
- Organize treasuries → workspaces — **Owner:** Mark
- (Later) Azure resource grouping — **Owner:** Mark (plan)

## Product & UX (Later)
- Public UI for online treasuries — **Owner:** GPT-5 (spec), Copilot Pro (impl.)
- Gamified Kickstarter framing — **Owner:** Mark (vision), GPT-5 (copy)

## Cross-cutting Quality Bars
- Every page has: story line 1, story line 2, `// Code Task: …`, `[Illustration: …]`
- `ai_player.json` must validate; pages must lint clean
- Safe for children (safety rating “G”, gentle tone)
- Safety pass per book: language/tone check & prompt suitability

---

# Skills Status Roll-Up

_Use: keep this section short and living. Move bullets between lists as status changes._

## 1) Skills We Currently Have ✅
- 32-page metaphorical micro-beats (Storycraft)
- Rhythm/readability for ages 5–8 (Storycraft)
- Allegorical disguise patterns (Storycraft)
- Per-page illustration prompts drafted & reviewed (Visuals)
- Release guardrails: ghost scan + stub checks + clean zips (Eng/Automation)
  - `_scripts/make_zips.ps1` (ghost guard + snapshot)
  - `_scripts/morning_check.ps1` (pytest + ghost scan)
  - `tests/test_guard_no_root_books.py` (root ghost blocker)
  - `tests/page_stub_check.py` (stub contract)

## 2) Skills In Progress 🛠️
- Art direction system (motifs/palettes) → `art/STYLE_NOTES.md`
- Schema discipline for `ai_player.json` (spec + validation)
- Linting for pages (`_scripts/lint_pages.ps1`) and wiring into checks
- Scaffolding ergonomics (tasks, scripts) for new books/treasuries

## 3) Skills Not Yet In Place / Backlog 🧭
- Image generation & layout pipeline
- CI on push (schema + linter + tests)
- Public UI for online treasuries
- Gamified Kickstarter framing
- Azure resource grouping

## Out of Scope (for now)
- PDF/EPUB exporters
- Game mechanics beyond page-level beats

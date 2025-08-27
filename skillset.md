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
- Schema discipline (`_schemas/ai_player.schema.json`) — **Owner:** GPT-5 (spec), Copilot (enforce)
- (Later) CI (schema + linter on push) — **Owner:** GPT-5 spec, Copilot impl.
- Executable stubs on pages — **Owner:** Copilot (impl), Mark (approve)

## Structure & Ops
- Organize pages → books (AI players) — **Owner:** Copilot (scaffold), Mark (content)
- Organize books → treasuries — **Owner:** Mark (toc/roadmap)
- Organize treasuries → workspaces — **Owner:** Mark
- (Later) Azure resource grouping — **Owner:** Mark (plan)

## Product & UX (Later)
- Public UI for online treasuries — **Owner:** GPT-5 (spec), Copilot (impl.)
- Gamified Kickstarter framing — **Owner:** Mark (vision), GPT-5 (copy)

## Cross-cutting Quality Bars
- Every page has: story line 1, story line 2, `// Code Task: …`, `[Illustration: …]`
- `ai_player.json` must validate; pages must lint clean
- Safe for children (safety rating “G”, gentle tone)
- Safety pass per book: language/tone check & prompt suitability

## Out of Scope (for now)
- Image rendering pipeline
- PDF/EPUB exporters
- Game mechanics beyond page-level beats

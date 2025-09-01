# glossary.md

Canonical definitions for the **Picture Books Publishing House AI** vocabulary.

> Keep entries concise. Link related terms with **bold** cross-refs. Alphabetical order.

---

### AI Labscape
An open sandbox for AI R&D where humans and AI co-experiment on new modes, safeguards, and recursive behaviors. Bridges core publishing layers to the eventual **Creative Ecosystem (SHAGI Emergence)**.

### AI Player
The persona/agent of a picture book, defined by `ai_player.json` and expressed through its pages and code stubs. Every **Book** is simultaneously an **AI Player** and a **Minigame** (see **Deep Triad**).

### Build Passes (P1–P5)
The minimal cadence for moving a book from scaffold → publishable slice:

- **Pass-1 — Scaffold**: structure + lintable files.
- **Pass-2 — Narrative**: story lines stable.
- **Pass-3 — Code/Schema**: executable stubs + schema alignment; contract enforced.
- **Pass-4 — Validation/Play**: cadence polish, lint + stub check, reproducible builds (**two-zip policy**).
- **Pass-5 — Art v0.x (optional)**: palette, STYLE_NOTES, ALT_TEXT_GUIDE.

*Optional future extensions (not yet enforced):*
- **Pass-6 — Export**: generate PDF/EPUB/web previews.
- **Pass-7 — Gameplay**: map page code to interactive minigame nodes.

### Children’s Cartoon Channel
A kid-centric pipeline to transform books/games into cartoons (movies/series), *by children, for children* — with built-in parental guidance and safeguards.

### Deep Triad
The core identity model: **Book = AI Player = Minigame**. The triad is present from page one (not layered later). See also **Human & AI Players**.

### deterministic stub
A minimal, predictable Python stub that matches the Code Task exactly (no randomness; 4-space indents; fenced in `[python]`).

### Doctor Lucid
Consent-first steward bot. Proposes changes, never pushes without explicit approval. Enforces safety, clarity, and contract adherence.

### Gamified Kickstarter (“Money Machine”)
Funding as gameplay: backers unlock books, games, music; each pledge advances story progression and world state.

### Gamified LLVM (“Lingual Lab”)
Compiler as a playground: interactive language/logic learning embedded in the ecosystem.

### Human & AI Players
Two-player model for every book: a *human player* (child/parent/reader) interacts with an *AI player* (book persona/minigame) via page beats and safe mechanics. Governed by **Valiant Citadel**.

### Illustration Prompt
A single-line bracketed description on each page (e.g., `[Illustration: …]`) providing a drawable, concrete visual.

### Lucid Armada
Opt-in standards program. Drafts conventions/RFCs and pushes them upstream once battle-tested in Sagas.

### Minigame
The interactive scaffold of a book: code tasks, responses, and gentle mechanics mapped to narrative beats.

### Mirrorstanza
A **design lens inside a Treasury**: the four Roadstanzas (Q1–Q4) are planned to **mirror or echo** one another thematically or mechanically. Not a separate deliverable or count unit—just a patterning device used in planning and review to keep the quartet-of-quartets cohesive.

### page contract (7-line)
Fixed per-page structure:
1. H1 title
2. 1–2 story lines
3. `// Code Task:` line
4. `[python]` deterministic stub (4-space indents, no tabs)
5. `[Illustration: …]` (≤160 chars)
6. UTF-8 with LF line endings
7. One blank line after H1
Enforced by `lint_pages.ps1` and validated by `tests/page_stub_check.py`.

### Pagestanza
A group of four consecutive pages that form a micro-arc. Used for drafting rhythm and commit batching.

### Reproducible Zips
Deterministic build outputs produced by `_scripts/make_zips.ps1`, verified with SHA256, with a rotation policy of **latest + one timestamped**.

### revisit triggers (seed layers)
When to expand `layers_of_logic_and_narrative.md`:
- Minor: Books 1–4 reach Pass-4.
- Major: Volume 1 (Books 1–16) holds a uniform Pass-3 baseline.
- Early: a new layer pattern repeats across 2+ books.

### Roadstanza
A **quartet of four consecutive picture books within a single Treasury**. It’s the planning/delivery unit we ship to at least Pass 4 (minimum). Example: **Roadstanza 0 — Foundations** spans Books 1–4 of the Treasury.

### Saga
Our term for a focused VS Code workspace that scopes one effort (e.g., a single picture book, a lab module, or a doc sweep). A saga bundles tasks, tests, and docs so progress stays contained and reproducible.

### Sagas (VS Code workspaces)
Plural usage; lightweight, consent-first collaboration units. We prefer “Sagas” over “projects” to emphasize narrative flow and bounded scope.

### Stub Checker
Python harness (`tests/page_stub_check.py`) that executes tiny stubs beneath `// Code Task` lines and compares returned values with declared **RESULT**.

### Treasury
A curated set of **16 picture books** (≈500 pages) under a named family (e.g., *Treasury of Fairytales*). Structurally: **4 Roadstanzas × 4 books each**. Each Treasury has its own roadmaps and taskmaps.

### two-zip policy
Keep exactly two clean artifacts in `dist/`: `…_latest.zip` and the most recent timestamped archive. Verify SHA256 each build.

### Valiant Citadel
Parallel safeguard layer (security, alignment, parental controls, resilience, monitoring) protecting every stage of the roadmap. See **Parallel Safeguard** note in README.

---

## Contributing to this Glossary

- Prefer short, precise definitions.
- Cross-link with **bold** term names when helpful.
- If a term is both an acronym and a concept, add it to **acronyms.md** and **glossary.md**.
- Keep examples minimal and non-speculative.

**Last updated:** 2025-09-01

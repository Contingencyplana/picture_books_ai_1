# glossary.md

Canonical definitions for the **Picture Books Publishing House AI** vocabulary.

> Keep entries concise. Link related terms with **bold** cross-refs. Alphabetical order.

---

### AI Player
The persona/agent of a picture book, defined by `ai_player.json` and expressed through its pages and code stubs. Every **Book** is simultaneously an **AI Player** and a **Minigame** (see **Deep Triad**).

### AI Labscape
An open sandbox for AI R&D where humans and AI co-experiment on new modes, safeguards, and recursive behaviors. Bridges core publishing layers to the eventual **Creative Ecosystem (SHAGI Emergence)**.

### Build Passes
A minimal cadence for moving a book from scaffold → publishable slice:
1. **Pass 1 — Scaffold**
2. **Pass 2 — Narrative**
3. **Pass 3 — Code (Executable Stubs)**
4. **Pass 4 — Validation / Play** (lint + stub check + zip policy + checksums)

### Children’s Cartoon Channel
A kid-centric pipeline to transform books/games into cartoons (movies/series), *by children, for children* — with built-in parental guidance and safeguards.

### Deep Triad
The core identity model: **Book = AI Player = Minigame**. The triad is present from page one (not layered later). See also **Human & AI Players**.

### Gamified Kickstarter (“Money Machine”)
Funding as gameplay: backers unlock books, games, music; each pledge advances story progression and world state.

### Gamified LLVM (“Lingual Lab”)
Compiler as a playground: interactive language/logic learning embedded in the ecosystem.

### Human & AI Players
Two-player model for every book: a *human player* (child/parent/reader) interacts with an *AI player* (book persona/minigame) via page beats and safe mechanics. Governed by **Valiant Citadel**.

### Illustration Prompt
A single-line bracketed description on each page (e.g., `[Illustration: …]`) providing a drawable, concrete visual.

### Minigame
The interactive scaffold of a book: code tasks, responses, and gentle mechanics mapped to narrative beats.

### Page Contract
Strict per-page shape and regex rules (title, story lines, `// Code Task`, `[Illustration: …]`). Enforced by `lint_pages.ps1` and validated by the stub checker.

### Pagestanza
A group of four consecutive pages that form a micro-arc. Used for drafting rhythm and commit batching.

### Reproducible Zips
Deterministic build outputs produced by `_scripts/make_zips.ps1`, verified with SHA256, with a rotation policy of **latest + one timestamped**.

### Roadstanza
Series-level planning segment (e.g., **Roadstanza 0 — Foundations**) that records treasury-wide milestones and direction.

### Stub Checker
Python harness (`tests/page_stub_check.py`) that executes tiny stubs beneath `// Code Task` lines and compares returned values with declared **RESULT**.

### Treasury
A curated set of ~16 picture books (~500 pages total) under a named family (e.g., *Treasury of Fairytales*). Each treasury has roadmaps and taskmaps.

### Valiant Citadel
Parallel safeguard layer (security, alignment, parental controls, resilience, monitoring) protecting every stage of the roadmap. See **Parallel Safeguard** note in README.

---

## Contributing to this Glossary

- Prefer short, precise definitions.
- Cross-link with **bold** term names when helpful.
- If a term is both an acronym and a concept, add it to **acronyms.md** and **glossary.md**.
- Keep examples minimal and non-speculative.


# Phases & Stages — Picture Books AI (Workspace 1) · v0.3

**Purpose:** A short, living plan for the next steps. Keep it tight and real.

---

## Canonical mapping
- **Phase = Mirrorstanza** → one meta-arc spanning 4 Treasuries (volumes).
- **Subphase = Treasury** → one family (≈16 books).
- **Stage = Roadstanza** → a planning slice inside a Treasury spanning 4 Books.
- **Substage = Book** → one 32-page picture book (**Book = AI Player = Minigame**).

### Invariants (keep these true)
- Each Treasury has **16 Books** = **4 Roadstanzas × 4 Books**.
- A **Roadstanza** always refers to **4 consecutive books** in the same Treasury.
- A **Mirrorstanza** groups **4 Treasuries** (e.g., ToF vols: `a0_`, `a1_`, `a2_`, `a3_`).
- Pass gates: **P1** Scaffold · **P2** Narrative · **P3** Schema · **P4** Repro Zips ( **P5** Art v0 optional).

---

## Snapshot (right now)
- ✅ Tooling: template + copier + linter + schema + reproducible build (two-zip policy) in place.
- ✅ **Book 2** (`a0_1_the_witch_who_broke_riddles`) v0.1: P1–P5 green; CHANGELOG + export stub added.
- ⏳ **Book 1** (`a0_0_the_loop_that_wanted_to_close`): draft a publishable slice (P01–P08), align page tags (`// Code Task:` only).

---

## Subphase 0.0 — Treasury of Fairytales (Vol. `a0_`)

### Stage 0.0.0 — Roadstanza 0 (Books `a0_0`..`a0_3`)
*Plan one stage ahead; keep the next stage a light outline until this one exits.*

| Book ID | Title                           | Function its code performs (ecosystem role)                                                                 | Status         |
|--------:|---------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------|----------------|
| a0_0    | The Loop That Wanted to Close   | Establish the **page contract + stub harness**; golden path for `// Code Task` execution and reproducible builds.                                | P1→P2 target   |
| a0_1    | The Witch Who Broke Riddles     | Demonstrate **rule-repair** & kinder constraints; **CT mapping** + Art v0 patterns (STYLE_NOTES, ALT_TEXT_GUIDE); accessibility cues.           | **P1–P5 ✅** v0.1 |
| a0_2    | The Castle of Glass Arguments   | Teach **fragile vs. resilient reasoning**; safe disagreement patterns; constraints that improve clarity without “gotcha.”                        | P0→P1 target   |
| a0_3    | *(TBD)*                         | Complement the arc (e.g., **bridges of kind questions**): invite inquiry mechanics; reinforce inclusive play + safety.                           | P0 (reserve)   |

**Drift checks**
- Page contract intact (header; 1–2 story lines; `// Code Task: …`; `[Illustration: … ≤160]`).
- Only **`// Code Task:`** tags in pages (no extra “ID” lines).
- `ai_player.json` validates `_schemas/ai_player.schema.json`.
- Build keeps **latest + one timestamped**; no-change rebuild hashes match.
- Release builds append a **Build snapshot** line to `fluff_inventory.md`.

**Exit criteria for Stage 0.0.0**
- `a0_0..a0_3` reach **P4** (repro zips), with ≥1 book at **P5 Art v0**.
- `a0_0_treasury_of_fairytales/toc.md` lists all 16 `a0_*` books (TBD titles allowed); grouped by Roadstanza.
- Glossary entries for **Mirrorstanza** and **Roadstanza** align with this mapping.

---

### Stage 0.0.1 — Roadstanza 1 (`a0_4`..`a0_7`) — outline only
- Seed tentative titles, one-line “function its code performs”, and pass targets.
- Promote to *active* only after Stage 0.0.0 exit review.

---

## Now (working set)
- [ ] **Book 1 — publishable slice:** micro-prompts + illustration cues for **P01–P08** (1–2 lines/page; keep 7-line template).
- [ ] **Treasury spine:** create/update `a0_0_treasury_of_fairytales/toc.md` listing ~16 books with ID, title, status (P1–P5), grouped by Roadstanza.
- [ ] **CI stub (recommended):** minimal GitHub Action to run page linter + stub check on push/PR.
- [ ] **Build snapshot habit:** append one-liner to `fluff_inventory.md` after “release” builds.

---

## Definition of Done (per book)
- 32 pages present; page contract linter clean.
- `ai_player.json` valid against schema.
- Stubs/checks pass; reproducible zips; two-zip policy enforced; SHA256 logged.
- Taskmaps updated; CHANGELOG entry for the cut.

---

## Parking Lot
- Export pipeline (PDF/EPUB/web)
- Public site UI
- Cartoon channel prototype (kid-safe pipeline)

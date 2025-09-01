# Roadstanza 0 — Foundations (Stage 0.0.0) · v0.2

**Scope:** Four picture books inside **Treasury of Fairytales · Vol. a0** (a0_0..a0_3).
**Why:** Plan one stage ahead (4 books) so we can stay flexible.

## Canonical mapping (for reference)
- **Phase = Mirrorstanza** → 4 treasuries (meta-arc). *(Not what this file manages.)*
- **Subphase = Treasury** → one family (≈16 books).
- **Stage = Roadstanza** → **4 consecutive books in one treasury**. ← *This file*
- **Substage = Book** → one 32-page picture book (Book = AI Player = Minigame).

## Invariants
- Each Treasury = **16 books = 4 roadstanzas × 4 books**.
- This roadstanza covers **a0_0..a0_3** only.
- Pass gates: **P1 Scaffold · P2 Narrative · P3 Schema · P4 Repro Zips · (P5 Art v0 optional)**.

---

## Books in Roadstanza 0 (a0_0..a0_3)

| Book ID | Title                                  | Function its code performs (ecosystem role) | Status                              |
|---------|----------------------------------------|---------------------------------------------|-------------------------------------|
| a0_0    | The Loop That Wanted to Close          | Establish the **page contract + stub harness**; golden path for `// Code Task` execution and reproducible builds.                 | P1–P4 ✅                                    |
| a0_1    | The Witch Who Broke Riddles            | Demonstrate **rule-repair** & kinder constraints; **CT mapping**; Art v0 patterns (STYLE_NOTES, ALT_TEXT_GUIDE); accessibility cues. | P1–P5 ✅ (v0.1)                             |
| a0_2    | The Castle of Glass Arguments          | Teach **fragile vs. resilient reasoning**; safe disagreement patterns; constraints that improve clarity without “gotcha”.             | P3 ✅ (stubs P01–P32 contract-complete, lint/stub/build checks green); P4 in progress |
| a0_3    | *(TBD)*                                | Complement the arc (e.g., **bridges of kind questions**): inquiry mechanics; inclusive play + safety.                           | P0 (reserve)                                |

### Drift checks (keep these true)
- Page contract intact (header; 1–2 story lines; `// Code Task: …`; `[Illustration: … ≤160]`).
- Only **`// Code Task:`** in pages (no extra “ID” lines).
- `ai_player.json` validates `_schemas/ai_player.schema.json`.
- Build rotation: **latest + one timestamped**; no-change rebuild hashes match.
- Release builds append **Build snapshot** line to `fluff_inventory.md`.

### Exit criteria for Roadstanza 0
- a0_0..a0_3 reach **P4** (repro zips), with ≥1 book at **P5 Art v0**.
- `a0_0_treasury_of_fairytales/toc.md` lists all **16** a0 books (TBD titles allowed).
- Glossary entries (**Mirrorstanza**, **Roadstanza**) match this mapping.

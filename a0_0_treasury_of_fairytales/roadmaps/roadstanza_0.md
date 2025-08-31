# Roadstanza 0 — Foundations (Picture Books 1–4)

**Purpose:** Establish a stable baseline by delivering the first **quartet** of picture books in the Treasury, with a reliable build pipeline and safety conventions.

---

## 📚 Composition (this roadstanza)
- **Book 1 — a0_0 _The Loop That Wanted to Close_**
- **Book 2 — a0_1 _The Witch Who Broke Riddles_** ← current focus
- **Book 3 — a0_2 (placeholder)**
- **Book 4 — a0_3 (placeholder)**

> One roadstanza = **4 books** shipped to Pass 4 (minimum), with optional higher passes as stretch goals.

---

## ✅ Exit Criteria (for this roadstanza)
- Each of the four books reaches:
  - **Pass 1:** Scaffold (32 pages, README, taskmaps)
  - **Pass 2:** Narrative (stubs ↔ code tasks aligned)
  - **Pass 3:** Schema-valid JSON (`ai_player.json`)
  - **Pass 4:** Reproducible zips (two-file policy)
- Build health proven (hash stability, rotation, logs).
- Safety (Valiant Citadel) consistently applied.

---

## 📈 Status by Book

### Book 1 — a0_0 _The Loop That Wanted to Close_
- [x] **P1 Scaffold**
- [x] **P2 Narrative**
- [x] **P3 Schema-valid JSON**
- [x] **P4 Reproducible zips**
- (Opt) P5 Art v0 — _TBD_
- (Opt) P6 Export — _TBD_
- (Opt) P7 Gameplay — _TBD_

### Book 2 — a0_1 _The Witch Who Broke Riddles_ (current)
- [x] **P1 Scaffold**
- [x] **P2 Narrative** (pages use `// Code Task:` only)
- [x] **P3 Schema-valid JSON**
- [x] **P4 Reproducible zips**
- [x] **P5 Art v0** (`art/STYLE_NOTES.md`, `art/ALT_TEXT_GUIDE.md`)
- (Opt) P6 Export — _Next_
- (Opt) P7 Gameplay — _Later_

### Book 3 — a0_2 (placeholder)
- [ ] **P1 Scaffold**
- [ ] **P2 Narrative**
- [ ] **P3 Schema-valid JSON**
- [ ] **P4 Reproducible zips**

### Book 4 — a0_3 (placeholder)
- [ ] **P1 Scaffold**
- [ ] **P2 Narrative**
- [ ] **P3 Schema-valid JSON**
- [ ] **P4 Reproducible zips**

---

## 🔭 Immediate Next Steps
1. **Export Pass (P6) for Book 2:** generate PDF/EPUB/web preview (pipeline TBD).
2. **Scaffold Book 3 (P1):** create folder, 32 pages, README, taskmaps; keep lints green.
3. Keep build snapshots up-to-date in `fluff_inventory.md` after release builds.

---

## 🧱 Why this roadstanza matters
- Proves the **quartet cadence** (4-books per roadstanza).
- Locks a reproducible build habit (hashes, two-zip rotation).
- Sets consistent safety and formatting norms for subsequent stanzas.

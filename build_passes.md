# Build Passes — Picture Books (AI Players)

**Purpose:** A minimal, repeatable cadence for growing each picture book from empty scaffold → publishable slice.

---

## 📚 Core Passes (Minimum 4)

**Pass 1 — Scaffold**
- Create folder and 32 pages (`page01.md` … `page32.md`) via `_scripts/new_book.ps1` or template.
- Add `README.md`, `ai_player.json` (validates), and `taskmaps/` stubs.
- Linter should pass for presence/structure.

**Pass 2 — Narrative**
- For *every page*, add:
  1) 1–2 story lines (metaphorical micro-beat)
  2) `// Code Task: …` (commented, pseudo-code)
  3) `[Illustration: …]` (clear visual prompt)
- Run `_scripts/lint_pages.ps1` and update `taskmaps/milestones.md`.

**Pass 3 — Code (Executable Stubs)**
- Keep the `// Code Task:` comment (for clarity).
- Add a tiny real code stub *beneath* the comment (language TBD; Python recommended later).

```python
// Code Task: attempt_close(loop) → RESULT: "Fragmented"
def attempt_close(loop):
return "Fragmented"
```

- (Optional now) add a micro-test or validation note.

**Pass 4 — Validation / Play**
- Pages lint clean; `ai_player.json` validates against `_schemas/ai_player.schema.json`.
- If stubs exist, confirm they execute (basic harness later).
- Mark page checkboxes done in `taskmaps/milestones.md`.

---

## 🎨 Optional Passes

**Pass 5 — Art Pass v0**
- Tighten illustration prompts; draft `art/STYLE_NOTES.md` (motifs, palettes).

**Pass 6 — Export Pass**
- Generate PDF/EPUB/web preview (pipeline TBD).
- Place outputs in `a0_0_treasury_of_fairytales/exports/`.

**Pass 7 — Gameplay Pass (Later)**
- Map page code to interactive minigame nodes (design TBD).

---

## ✅ Per-Book Checklist

- [ ] **P1 Scaffold:** 32 pages present; linter runs.
- [ ] **P2 Narrative:** Each page has story + `// Code Task:` + `[Illustration: …]`.
- [ ] **P3 Code:** Executable stubs exist (where applicable).
- [ ] **P4 Validation:** Linter + schema green; milestones updated.
- [ ] (Opt) **P5 Art:** STYLE_NOTES; prompts consistent.
- [ ] (Opt) **P6 Export:** Preview generated to `exports/`.

---

## 🧱 Page Contract (reminder)
Each `pageNN.md` follows the 3-part format:

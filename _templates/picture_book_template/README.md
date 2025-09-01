# {{BOOK_TITLE}}

*A very different fairytale in 32 tiny steps.*

**Synopsis (replace):** 2–3 sentences on premise, main character, emotional arc, and what changes.

---

## Build Passes

- **Pass-1 Structure:** 32 page files present; 7-line contract placeholders.
- **Pass-2 Narrative Alignment:** Replace placeholder lines with coherent beats.
- **Pass-3 Code/Schema:** Deterministic Code Task semantics + stub refinement.
- **Pass-4 (Optional Polish):** Light phrasing tighten + reproducible build check.

## 7-Line Page Contract

1. `# Page NN` (H1) then one blank line.
2. Story line 1 (≤ ~80 chars target, soft limit).
3. Story line 2 (optional or second line / may be blank early Pass-1).
4. `// Code Task: func_name() → RESULT: "Stub."` (deterministic placeholder)
5. `[python]` tag (no fenced block here for simplicity).
6. Stub `def func_name():` returning `"Stub."` exactly (single return line; 4 spaces indent; no tabs; no docstring).
7. `[Illustration: …]` ≤160 chars (placeholder allowed).

All files UTF-8 + LF. No trailing spaces. Maintain deterministic stub until Pass-3 changes its semantics (then update Code Task line + return string together).

---

## Using This Template

See `COPYING_INSTRUCTIONS.md` for copy + rename steps. After copying:

1. Replace placeholders in `README.md`, `ai_player.json`, and all pages.
2. Choose a function prefix (e.g. `loop_pNN`); keep consistent.
3. Pass-1 keeps narrative minimal; avoid polishing early.

---

## Progress Notes (Optional Section)

Record decisions, motif shifts, or refactors here.


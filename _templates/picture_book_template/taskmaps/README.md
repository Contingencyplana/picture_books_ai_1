# Taskmaps — {{BOOK_TITLE}}

**Status:** Pass-1 STRUCTURE (template) • **Pages:** 32
**Purpose:** Coordinate per-page evolution across build passes while mirroring code reality.

---

## PASSES

- Pass-1 Structure: 32 page files; deterministic stub placeholders.
- Pass-2 Narrative: Replace placeholder lines with coherent beats.
- Pass-3 Code/Schema: Refine Code Task semantics; keep stubs deterministic.
- Pass-4 (Optional) Polish: Light phrasing tighten + reproducible build check.

## 7-LINE CONTRACT (RECAP)

1. H1 `# Page NN` + blank line.
2. Story line 1.
3. Story line 2 or blank.
4. `// Code Task: func_name() → RESULT: "Stub."`
5. `[python]`
6. Stub def returning "Stub." exactly.
7. Illustration line (≤160 chars).

## NOTES

- Keep placeholders minimal in Pass-1; avoid polishing early.
- Update Code Task + return string together if semantics change in Pass-3.
- No tabs; UTF-8 LF.

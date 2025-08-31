# Build Passes — Picture Books (AI Players)

**Purpose:** A minimal, repeatable cadence for growing each picture book from empty scaffold → publishable slice.

---

## 📚 Core Passes (Minimum 4)

**Pass 1 — Scaffold**
- Create folder and 32 pages (`page01.md` … `page32.md`) via `_scripts/new_book.ps1` or template.
- Add `README.md`, `ai_player.json` (validates), and stubs under `taskmaps/`.
- Linter should pass for presence/structure.

**Pass 2 — Narrative**
- For *every page*, add:
  1) 1–2 story lines (present-tense micro-beats)
  2) `// Code Task: …` (commented, pseudo-code per Page Contract)
  3) `[Illustration: …]` (clear visual prompt)
- If using a tasks file, mirror **Book 1**:
  - `taskmaps/code_tasks.md` with headings **`## CT-XX — <title>`** (two-digit IDs, CT-01..CT-32).
  - In each page, keep **exactly one** task tag and keep casing consistent.
    - Preferred (Book-1 compatible): use only the existing `// Code Task:` line.
    - Add a separate `// Code Task ID: a0_1-CT-XX` line **only if your checker requires it**—and don’t mix conventions within a book.

**Pass 3 — Code (Executable Stubs)**
- Keep the `// Code Task:` comment (for clarity).
- Add a tiny real code stub *beneath* the comment (language TBD; Python recommended later).
- (Optional) add a micro-test or validation note.

```python
# Example (when stubbing begins)
# // Code Task: attempt_close(loop) → RESULT: "Fragmented"
def attempt_close(loop):
    return "Fragmented"
```

## Pass 4 — Validation / Play
- Run `python tests/page_stub_check.py` → all stubs must execute and match their `// Code Task` expectations.
- Run `pwsh _scripts/lint_pages.ps1 -BookPath <book>` → all pages must pass lint (titles, tasks, illustrations).
- Ensure `ai_player.json` exists at the book root and validates against `_schemas/ai_player.schema.json`.
  - Must define: `id`, `title`, `path`, `pages` (**32** for picture books).
  - Optional: `principles` (tone, theme, rules).
  - Include the schema pointer used by your tooling (e.g., `$schema` or `schema_version`) and pass validation before completing Pass 4.
- **Reproducible zips**
  - Run `pwsh _scripts/make_zips.ps1` **twice with no changes**.
  - Expect: **“Hash check: latest matches previous (reproducible/no content change).”**
  - If it differs: ensure inputs are deterministically ordered before zipping and remove any timestamps from file contents.
- **Zip rotation policy** (script-enforced): keep exactly 2 files in `dist/`:
  - `<project>_clean_latest.zip`
  - The most recent timestamped archive
- **Build snapshot** (release builds): append a one-liner to `fluff_inventory.md`:
  - `Latest ZIP: <name> • SHA256: <hash> • When: <local time>`
- Mark page checkboxes complete in `taskmaps/milestones.md`.

---

## 🤖 AI Player JSON
Each book must contain an `ai_player.json` at its root, validating against `_schemas/ai_player.schema.json` and defining:
- **id**: unique string, e.g. `"a0_1_the_witch_who_broke_riddles"`
- **title**: human-readable book title
- **path**: relative folder path
- **pages**: `32` (picture books are always 32 pages)
- **principles** (optional): tone, theme, rules
- **$schema** or **schema_version**: whichever your validator expects

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
- [ ] **P4 Validation:** Linter + schema green; **reproducible hash** verified; zip policy enforced; **Build snapshot** recorded.
- [ ] (Opt) **P5 Art:** STYLE_NOTES; prompts consistent.
- [ ] (Opt) **P6 Export:** Preview generated to `exports/`.

---

## 🧱 Page Contract (reminder)
Each `pageNN.md` must follow this exact shape:

```markdownlint
# Page NN

<Story line 1>
<Story line 2>

// Code Task line
[Illustration: …]
```

### Rules (strict):
1. **Header:** `# Page NN` where `NN` is zero-padded (01–32) and matches the filename (`pageNN.md`).
2. **Story lines:** 1–2 lines, present-tense, ≤ 120 chars each; no trailing spaces.
3. **Code Task line:**
   - Starts with `// Code Task:`
   - Format: `// Code Task: function_name(arg1, arg2) → RESULT: "Short result sentence."`
   - `function_name` is `snake_case`; arguments optional; use the unicode arrow `→` (ASCII `->` allowed but linter may warn).
   - The RESULT string is quoted, ends with a period, ≤ 100 chars.
   - **Linkage:** If your checker requires a separate ID tag, include exactly one extra line *immediately after* the Code Task line:
     `// Code Task ID: a0_1-CT-XX` (keep casing identical across all pages). Use one convention consistently per book.
4. **Illustration line:**
   - Format: `[Illustration: <concise visual prompt>]`
   - Keep ≤ 160 chars; present specific, drawable elements; avoid camera jargon unless needed.
5. **Spacing:** Preserve the template’s line spacing (the 7-line shape). Ensure file ends with a newline.
6. **Typography:** Curly quotes OK; en/em dashes OK. Prefer consistent punctuation across the book.
7. **Do not** add extra headings, links, or code blocks inside the pages at this stage.

### Lint expectations (regex-level):
- Header (01–32, zero-padded):
  `^#\s*Page\s*(0[1-9]|[12]\d|3[0-2])$`
- Code Task (accepts `→` or `->`):
  `^//\s*Code Task:\s*[a-z0-9_]+\(.*\)\s*(?:→|->)\s*RESULT:\s*\".+\"\.$`
- Illustration (3–160 chars):
  `^\[Illustration:\s*.{3,160}\]$`
- (If using a separate ID tag) Code Task ID:
  `^//\s*Code Task ID:\s*[a-z0-9_-]+-CT-\d{2}\s*$`

### Naming & location:
- Filenames: `page01.md` … `page32.md` inside the book folder
  `a0_0_treasury_of_fairytales/a0_1_the_witch_who_broke_riddles/`
- Do **not** prefix page files with stanza codes (`a0_0_…`). Keep those only for folders.

---

## 🔁 Working Rhythm (per pagestanza = 4 pages)

1. Draft pages `pageNN`–`pageNN+3`.
2. Commit:
   - **Commit A (pages):**
     `docs(bookX): add Pages NN–NN+3 to '<Book Title>'`
     (Bullet the four Code Tasks in the body.)
   - **Commit B (planning):**
     `docs(bookX): update taskmap & milestones for Pagestanza X (Pages NN–NN+3)`
3. Update `taskmaps/main_taskmap.md` and `taskmaps/milestones.md` (group by pagestanza).
4. Run `./_scripts/make_zips.ps1` and verify:
   - Two zips kept
   - Hash report printed
   - (If release) add a one-line Build snapshot to `fluff_inventory.md`.

---

## 🧪 Formatting Notes (Windows)

- Git CRLF warnings are normal in this repo; we target LF in Git.
- `.ps1` scripts may remain CRLF (safe on Windows).
- You may add a root `.gitattributes` to normalize line endings and silence noisy diffs later:

```gitattributes
* text=auto eol=lf
*.ps1 text eol=crlf
```

to silence future diffs.

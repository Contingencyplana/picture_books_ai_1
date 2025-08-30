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
  1) 1–2 story lines (present-tense micro-beats)
  2) `// Code Task: …` (commented, pseudo-code per Page Contract)
  3) `[Illustration: …]` (clear visual prompt)
- If using a tasks file, mirror **Book 1**:
  - `taskmaps/code_tasks.md` with headings **`## CT-XX — <title>`** (02-digit IDs).
  - In each page, add **exactly one** task tag and keep casing consistent.
    - Preferred (Book 1 compatible): keep the existing `// Code Task:` line format and, if needed by your checker, add *one* ID tag line (`// Code Task ID: a0_1-CT-XX`). Use one approach consistently across the book.

**Pass 3 — Code (Executable Stubs)**
- Keep the `// Code Task:` comment (for clarity).
- Add a tiny real code stub *beneath* the comment (language TBD; Python recommended later).
- (Optional now) add a micro-test or validation note.

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
  - Must define: `id`, `title`, `path`, `pages` (1–32), and optional `principles` (tone, theme, rules).
  - Validation must succeed before Pass 4 is considered complete.
- **Reproducible zips:**
  - Run `pwsh _scripts/make_zips.ps1` **twice with no changes**.
  - Expect the script to report: **“Hash check: latest matches previous (reproducible/no content change).”**
  - If it differs, sort the inputs before zipping and remove timestamped content from inputs.
- Zip rotation policy (script-enforced): exactly 2 files kept in `dist/`:
  - `<project>_clean_latest.zip`
  - The most recent timestamped archive
- **Build snapshot:** After a release build, append a one-line snapshot to `fluff_inventory.md`:
  - `Latest ZIP: <name> • SHA256: <hash> • When: <local time>`
- Mark page checkboxes complete in `taskmaps/milestones.md`.

---

## 🤖 AI Player JSON
Each book must contain an `ai_player.json` file at its root. It validates
against `_schemas/ai_player.schema.json` and defines:
- **id**: unique string, e.g. `"a0_0_the_loop_that_wanted_to_close"`
- **title**: human-readable book title
- **path**: relative folder path
- **pages**: number of pages (always 32 for picture books)
- **principles**: optional (tone, theme, rules)
- **$schema**: reference to `_schemas/ai_player.schema.json`

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
- [ ] **P4 Validation:** Linter + schema green; zip policy enforced; checksums reviewed.
- [ ] (Opt) **P5 Art:** STYLE_NOTES; prompts consistent.
- [ ] (Opt) **P6 Export:** Preview generated to `exports/`.

---

## 🧱 Page Contract (reminder)

Each `pageNN.md` must follow this exact shape:

```markdownlint
Page NN

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
   - `function_name` is `snake_case`; arguments optional; use the unicode arrow `→` (ASCII `->` permitted, but linter will warn).
   - The RESULT string is quoted, ends with a period, ≤ 100 chars.
   - **Linkage:** If your checker requires a separate ID tag, include exactly one extra line right after the Code Task line:
     `// Code Task ID: a0_1-CT-XX` (keep casing identical across all pages). Use one convention consistently per book.
4. **Illustration line:**
   - Format: `[Illustration: <concise visual prompt>]`
   - Keep ≤ 160 chars; present specific, drawable elements; no camera jargon unless needed.
5. **Spacing:** Preserve the template’s line spacing. Ensure file ends with a newline.
6. **Typography:** Curly quotes OK; en/em dashes OK. Prefer consistent punctuation across the book.
7. **Do not** add extra headings, links, or code blocks inside the pages at this stage.

### Lint expectations (regex-level):
- Header: `^#\s*Page\s*0?\d{1,2}\s*$`
- Code Task: `^//\s*Code Task:\s*[a-z0-9_]+\(.*\)\s*→\s*RESULT:\s*\".+\"\.$`
- Illustration: `^\[Illustration:\s*.{3,}\]$`
- (If using a separate ID tag) Code Task ID: `^//\s*Code Task ID:\s*[a-z0-9_-]+-CT-\d{2}\s*$`

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
- You may add a root `.gitattributes` to normalize line endings and silence noisy diffs later.

```markdownlint
*.md text eol=lf
```

to silence future diffs.

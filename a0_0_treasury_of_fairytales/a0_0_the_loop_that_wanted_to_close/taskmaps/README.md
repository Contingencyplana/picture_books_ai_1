# Taskmaps — Book 1: *The Loop That Wanted to Close*

**Purpose:** Track narrative beats, code subtasks, and milestones for this AI Player.
Book 1 serves as the **foundational metaphor** for the Treasury of Fairytales series.

---

## 📖 Synopsis (WIP)
A child discovers a silver loop that longs to close but resists easy answers.
Through patience, kindness, and recursive attempts, the child learns that loops
only close when treated with care.

---

## 🧭 Guidance
- Each page = **micro-beat**: story line(s) + code task + illustration prompt.
- Track progress in `main_taskmap.md` and `milestones.md`.
- Update synopsis here as the book evolves.

---

## ✅ Current Status
- **Pass 1 — Scaffold:** complete (32 pages + stubs present).
- **Pass 2 — Narrative:** complete (story lines, code tasks, illustrations).
- **Pass 3 — Code:** pseudo-code stubs documented.
- **Pass 4 — Validation / Play:** ✅ done
  - Lint + stub checker clean.
  - `ai_player.json` present, schema-valid.
  - Zip pipeline enforces *latest + one timestamp*, with checksums.
- Next passes (optional): Art, Export, Gameplay.

---

## 📂 Key Files
- `ai_player.json` → defines this AI Player (id, title, path, pages, principles).
- `taskmaps/main_taskmap.md` → sequential map of pages.
- `taskmaps/milestones.md` → pagestanza + pass tracking.
- Zips in `/dist/` → reproducible builds (`_clean_latest.zip` + one timestamped).

---

## 🔮 Next Steps
- Draft **STYLE_NOTES.md** for illustration motifs (Pass 5).
- Add export pipeline for previews (Pass 6).
- Link page stubs to interactive node logic (Pass 7).

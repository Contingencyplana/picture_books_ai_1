# Workspace Overview — Picture Books Publishing House AI

**Purpose:** Provide a birds-eye view of this workspace (`picture_books_ai_1`), its structure, and how to navigate it.
This file orients new contributors before diving into individual treasuries, books, or overarching docs.

---

## 🗂 Repository Layout

```text
picture_books_ai_1/
│ README.md                # Main entry point — purpose + scaling roadmap
│ build_passes.md          # Core build cadence
│ phases_and_stages.md     # Long-term arc of growth
│ deep_triad.md            # Book = AI player = minigame
│ human_and_ai_players.md  # Human ↔ AI dynamics
│ acronyms.md              # Common abbreviations
│ glossary.md              # Key vocabulary
│
├─ docs/                   # Overarching documentation
│   └─ _index.md           # Documentation index ("map of maps")
│
├─ a0_0_treasury_of_fairytales/   # First treasury (~16 picture books)
│   ├─ roadmaps/           # Treasury-level planning (main roadmap, milestones, stanzas)
│   ├─ a0_0_the_loop_that_wanted_to_close/
│   │   ├─ README.md
│   │   ├─ ai_player.json
│   │   ├─ page01.md … page32.md
│   │   └─ taskmaps/       # Book-level planning (main_taskmap, milestones, README)
│   └─ a0_1_the_witch_who_broke_riddles/  # Next picture book (scaffolding soon)
│
├─ _schemas/               # JSON schemas (ai_player, etc.)
├─ _scripts/               # PowerShell automation (lint, validate, zip, new_book)
├─ tests/                  # Python harness (stub checks, contracts)
└─ dist/                   # Build outputs (clean zips, reproducible builds)
```

---

## 📖 Navigation Tips

- **Overarching docs** → `docs/_index.md`
- **Philosophy** → `deep_triad.md`, `human_and_ai_players.md`
- **Planning** → `roadmaps/` (treasury), `taskmaps/` (book)
- **Build pipeline** → `_scripts/` + `dist/`
- **Schema validation** → `_schemas/` + `tests/`

---

## ✅ Status

- **Book 1 (*The Loop That Wanted to Close*)** complete through **Pass 4 (Validation / Play)**
- **Zips reproducible**: latest + timestamped kept in `dist/`
- **Next step:** Begin scaffolding Book 2 (*The Witch Who Broke Riddles*)

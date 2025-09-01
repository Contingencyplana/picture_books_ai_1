# Six Space Types

**Purpose:** Define the six distinct “spaces” that structure the Picture Books Publishing House AI repository.
This taxonomy prevents overlap, avoids drift, and makes clear where each kind of work belongs.

---

## 1. Vision spaces
High-level intent and philosophy. These hold the *why* of the project — long-range goals, guiding metaphors, and narrative ethos.
Examples: `grand_plan.md`, `rhyme_and_reason.md`.

## 2. Overarching spaces
Cross-book truths and rules of the whole treasury. These are single sources of truth for passes, stanzas, and terminology.
Examples: `glossary.md`, `build_passes.md`, `phases_and_stages.md`.

## 3. Regimenting spaces
Rules and enforcers. They define what “neat, tidy, orderly” means and enforce it via scripts, hooks, and policies.
Examples: `.gitattributes`, `.git/hooks/`, `_scripts/lint_pages.ps1`, `regimenting_spaces.md`.

## 4. Fluffy spaces
Transient or non-essential clutter pruned during clean builds.
Examples: `.git/`, `.venv/`, `__pycache__/`, ghost folders, logs.
These never ship in clean zips.

## 5. Planning spaces
Where intent is broken down into actionable steps. Taskmaps, milestones, and roadmaps live here — book-specific or treasury-wide.
Examples: `taskmaps/`, `roadmaps/`.

## 6. Building spaces
The working heart of the repo. These contain the actual deliverables: picture book pages, stubs, AI player JSON, and scripts.
Examples: `pageNN.md`, `ai_player.json`, `_scripts/`.

---

## Future Candidates
As the project evolves, two more space types may be promoted:
- **Archival/History spaces** (hash logs, build snapshots, rotation records).
- **Play/Interaction spaces** (test harnesses, playable inner/outer game logic).

For now, six space types are sufficient and complete.

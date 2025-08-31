# Lingual Lab — Trinity Contract & MVP

**Status:** Draft v0.1
**Owner:** Contingencyplana
**Cross-refs:** §9 *Grand Plan* (Gamified LLVM), §11.1 *Doctor Lucid*, §12.1 *Lucid Armada*

## Purpose

Design a playground where every shipped thing is **three things at once**: a **language**, an **AI**, and a **game**—and make it fun, safe, and opt-in.

## The Trinity Contract

An artifact may ship only if it is:

- **Programmable** — it’s a language (grammar, semantics, tooling).
- **Personified** — it’s an AI (can explain itself, propose PRs/RFCs).
- **Playable** — it’s a game (goals, scoring, progression, multiplayer loops).

**Pass criteria**
- Conformance tests pass (Programmable).
- Coach explanations + PRs are useful and mergeable (Personified).
- A mission/campaign using the artifact is winnable + replayable (Playable).

## Architecture (minimum pieces)

### Core (LLVM/MLIR)
- Metacompiler templates (grammar → AST → IR → codegen/interp).
- Deterministic runtime + snapshot/replay (fairness & anti-cheat).
- WASM backend for browser play; native builds for tournaments.

### AI Layer (“Coach/Companion”)
- Tools: edit files, run tests, open PRs, explain diffs, propose RFCs.
- Reward/fitness: compile success, test coverage, perf, *player fun* votes.
- Guardrails: **propose, never push** (Doctor Lucid rules).

### Game Layer (Godot/Unity or WebGL+WASM)
- Mission templates:
  - **Make it Run** (pass conformance).
  - **Make it Fast** (optimize under budget).
  - **Make it Nice** (lint/encoding/portability challenges).
  - **Make it Teach** (Coach explains mistakes in-level).
- Co-op/versus; lockstep networking; signed replays.

### Multiplayer & Economy
- Matchmaking by mission type/skill.
- Replays = *deltas + seeds* (tiny, reviewable).
- Seasonal ladders: *Least Loony League* (format/encoding), *Optimizer Cup* (IR), *Portability Trials* (WASM/native).

### Governance & Safety
- **Doctor Lucid** CI/App for opt-in, reversible PRs (see §11.1).
- **Lucid Armada** for standards/RFC pathways (see §12.1).
- Allow-lists, rate limits, auto-revert on red CI, license checks.

## MVP Roadmap

### M1 — “SpriteTalk” (tiny grid-sprite language)
- Grammar → AST → bytecode interpreter (or MLIR dialect).
- 10 conformance tests; 1 level solvable only by editing the language.
- Coach can: explain parse errors, propose a one-rule fix, generate a unit test.

**Exit**: green tests; playable level w/ deterministic replay.

### M2 — “Co-op Compiler”
- Two players co-author a feature; Coach proposes tests/refactors.
- Lockstep multiplayer; replay export.
- Doctor Lucid runs: MD022, LF/UTF-8, CP1252→UTF-8, reproducible-zip guard.

**Exit**: PRs from Coach merged; replays validate determinism.

### M3 — “Languages-as-Mods”
- Pack language (grammar + passes + runtime) as a mod.
- Each mod ships with a Coach profile + 3-mission mini-campaign.
- Storefront lists languages by **Trinity Score** (P/P/P).

**Exit**: install/run a mod from catalog; finish its campaign.

### M4 — “RFC Arena”
- Players/AI submit language improvements as RFCs.
- Auto-eval: conformance, perf, portability, *teaching quality* rubric.
- Merge by vote + green CI; banner: *“Proposed by Doctor Lucid — approve to merge.”*

**Exit**: first accepted RFC improves a live mod.

## Repository Scaffold (proposed)

```text
lingual-lab/
├─ core/                # MLIR/LLVM scaffolding, IR, passes
├─ runtime/             # deterministic VM + snapshot/replay
├─ game/                # Godot or WebGL+WASM shell
├─ mods/
│  └─ spritetalk/       # M1 reference language
├─ bots/
│  └─ doctor-lucid/     # CI action/app; proposes, never pushes
├─ rfc-arena/           # proposal specs + auto-eval harness
└─ docs/
   ├─ DESIGN.md
   └─ REPLAYS.md
```

## Success Metrics

- **Fun:** D1/D7 mission retention; boss-level retry rate.
- **Language Quality:** tests, perf vs baseline, portability, lint cleanliness.
- **AI Helpfulness:** % Coach PRs merged; explanation upvotes.
- **Safety:** zero auto-push; all diffs revertible; consent logs intact.

## Naming & Flavor

- First language: **SpriteTalk**, **Pebble**, or **Glow**.
- Season: **Less Loony Labyrinths** (inside Lucid Armada).
- Bot: **Doctor Lucid — Proposes fixes. Never pushes.**

## Risks & Mitigations

- **Scope creep** → Trinity gate per milestone; RFC Arena for big changes.
- **Cheating/nondeterminism** → lockstep + signed replays; snapshot diffs.
- **Governance friction** → Lucid Armada RFCs; standards committees early.
- **Consent & compliance** → opt-in App; allow-lists; license/export review.

## Next Steps (actionable)

- Scaffold `lingual-lab/` monorepo (tree above).
- Implement SpriteTalk grammar + interpreter + 10 tests.
- Build one level that *requires* a language change to win.
- Wire Doctor Lucid locally: MD022, UTF-8/LF, CP1252 repair, repro-zip.
- Record a deterministic replay; verify two-machine lockstep.

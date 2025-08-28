# Cyberciv (TextGrid) — Offline Prototype

A tiny, offline, deletable prototype: a monospace grid where each cell is a “locale”
mapped to one of **16 synergy types** (the Synergy Grid). Click (or keyboard-select)
a cell to open a side panel and run a safe, toy interaction. A background **tick**
nudges simple scores toward neighborhood balance.

- **Offline only.** No networking. No external APIs. No build tools. One HTML file.
- **Palette:** 16 synergy hues (A1..H2) on a dark background.
- **Isolated module:** Safe to delete without touching the picture-books pipeline.

---

## Run locally

**Option A — VS Code**
Use “Open with Live Server” on `index.html`.

**Option B — Python** (from repo root)

```bash
py -3 -m http.server 5500
# then open:
# http://localhost:5500/x0_1_cyberciv_textgrid/index.html
```

## The 16-Synergy Grid (A1–H2)

| Code | Synergy                 |
|------|--------------------------|
| A1   | Research & Development   |
| A2   | Science & Technology     |
| B1   | Healing & Wellbeing      |
| B2   | AI & Humanity            |
| C1   | Biosphere                |
| C2   | Climate Action           |
| D1   | Economy                  |
| D2   | Sustainability           |
| E1   | Education                |
| E2   | Inclusion                |
| F1   | Governance               |
| F2   | Community                |
| G1   | Infrastructure           |
| G2   | Urban Planning           |
| H1   | Data                     |
| H2   | Privacy                  |

Each locale is typed with one of the above and colored accordingly.

---

## Scores & Benefit Index

Each locale tracks three scores in **[0..1]**:

- **I** — Integrity (stability / fairness of mechanisms)
- **N** — Inclusion (participation / access)
- **G** — Impact (usefulness / outcomes)

A derived **Benefit Index** \(B\) uses the harmonic mean:

\[
B = \frac{3}{\tfrac{1}{\max(\epsilon, I)} + \tfrac{1}{\max(\epsilon, N)} + \tfrac{1}{\max(\epsilon, G)}}
\]

with a small \(\epsilon\) to avoid division by zero. This favors **balanced progress**
over spiky trade-offs.

> UI hint: a green highlight appears when \(B \ge 0.66\).

---

## Controls

- **Width / Height** — rebuild grid dimensions (24×16 default).
- **Regenerate** — reseed the world (random initial scores, same type tiling rule).
- **Tick ×1** — advance one step of neighborhood evolution.
- **Run / Stop** — auto-advance once per second.

**Side-panel actions (per selected locale):**

- **Nudge balance** — Pull I, N, G toward a target center (0.75) by 20%.
- **Spark neighbors** — Push each neighbor’s I, N, G 10% toward that neighbor’s own triplet mean (gentle smoothing).
- **Stabilize inclusion** — Adjust N 25% toward the average of that cell’s I and G.

---

## Evolution Rule (Tick)

On each tick, for every cell:

1. Compute neighbor means for I, N, G.
2. Move this cell’s I/N/G 5% toward those means.
3. Add a tiny random drift in **[−0.01, +0.01]** for each score.
4. Clamp to **[0,1]**.

This produces soft, local consensus dynamics with small noise.

---

## Data Model (per cell)

```ts
{
  x: number, y: number,
  type: { code: 'A1'..'H2', name: string },
  i: number, n: number, g: number  // [0..1]
}
```

The initial tiling assigns types in a simple repeating pattern; scores start around **0.5–0.7**.

---

## Safety

- Fictional sim only. **No real funds**, **no scraping**, **no system calls**.
- Single HTML file, local browser runtime. **No persistence** by default.
- It’s a UI toy for thinking about balance (**Impact / Inclusion / Integrity**).

---

## Roadmap (light)

- [ ] Label helper for I/N/G in the UI (tooltips, compact legend).
- [ ] Optional save/load to JSON (download/upload).
- [ ] Seed parameter & deterministic reseeding.
- [ ] Tiny test harness: snapshot a 3×3 world and validate tick math.
- [ ] Alternate benefit functions (min-mean, CES) for comparison.
- [ ] Accessibility polishing (ARIA, keyboard focus states).

---

## Changelog

- **v0.1 (2025-08-29)** — Initial offline prototype (text grid, 16 synergies, locale panel, actions, tick).

---

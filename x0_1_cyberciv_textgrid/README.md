# Cyberciv (TextGrid) — Offline Prototype

A tiny, offline, deletable prototype: a monospace grid where each cell is a “locale”
mapped to one of 16 synergy types (the Synergy Grid). Click a cell to open a side
panel and run a safe, toy interaction. A background “tick” nudges simple scores.

- No networking. No external APIs. No build tools. One HTML file.
- Color palette = 16 synergies (A1..H2) on a dark background.
- Deletable at any time without touching the picture-books pipeline.

## Run locally
Option A — VS Code: “Open with Live Server” on `index.html`
Option B — Python: from repo root
`py -3 -m http.server 5500`
Then open
`http://localhost:5500/x0_1_cyberciv_textgrid/index.html`

## Safety
- Fictional sim only. No real funds, scraping, or system calls.
- It’s a UI toy for thinking about balance (Impact/Inclusion/Integrity).

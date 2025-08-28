# Research Arcade (Text)

A safe, text-first set of **educational minigames** about AI research and development.
All agents are fictional and sandboxed. There is no networking or real money.

## Core loop
- Play minigames to raise the **Benefit Index** = harmonic mean of Impact, Inclusion, Integrity.
- Crossing thresholds “unlocks” the next mode (still local, still fictional).

## Modules
- engine/runner.py — tiny text engine
- minigames/*.json — minigame specs
- docs/SAFETY_CHARTER.md — non-negotiable guardrails

Run (local):
`python x0_0_research_arcade/engine/runner.py`

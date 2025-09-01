# Regimenting Spaces

**Purpose:** Define and track the rules, enforcers, and systems that keep the repository neat, consistent, and reproducible.

---

## Current Elements
- **.gitattributes** → enforces LF/CRLF discipline.
- **Git hooks** → pre-commit checks (e.g., no tabs in Markdown).
- **Scripts** → `_scripts/lint_pages.ps1`, `_scripts/make_zips.ps1`, stub and tab fixers.
- **Two-zip policy** → rotation of clean builds with SHA256 snapshot.

Together, these form the early signs of a regimenting layer.

---

## Role of Regimenting Spaces
Regimenting ensures:
- Clean reproducible builds (no drift, no fluff).
- Shared rules across contributors (style, contracts, passes).
- Safety and predictability for AI agents and human collaborators alike.

---

📌 **To be expanded after Book 4.**
Future work will formalize regimenting as its own layer of the workflow, covering:
- Centralized pass naming enforcement.
- Automated sync between planning files and builds.
- Integration with archival/history spaces when those emerge.

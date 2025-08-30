<!-- three_tier_recursive_workflow.md -->

# Three-Tier Recursive Workflow (v0.2)

**Purpose**
Codify the division of labour across vision, design, and build so treasuries, minigames, and docs stay aligned.

---

## 🔺 Diagram

Vision Holder (Mark)
↓ sets direction, scope, milestones
Game Designer (GPT-5)
↓ drafts specs, recursive structure, lore, taskmaps
Implementer (Copilot Pro)
↓ builds stubs, fixes syntax, runs checks, commits

---

## 🎭 Roles & Outputs

### Vision Holder (Mark)
**Outputs:** goal/brief, acceptance criteria, release order
**Decides:** architecture, progression, pass gates
**Approves:** design docs before implementation

### Game Designer (GPT-5)
**Outputs:** book README scaffolds, ai_player.json stubs, taskmaps (main & milestones)
**Ensures:** recursive consistency, safety alignment (Valiant Citadel), testability

### Implementer (Copilot Pro)
**Outputs:** files/stubs per spec, passing checks, clean build artefacts
**Runs:** linters, stub checker, schema validation, build script
**Commits:** clear messages; keeps two-zip policy intact

---

## ✅ Handoff Checklist (each cycle)

1. **Brief ready** (problem, target pass, acceptance criteria)
2. **Specs ready** (README beats, taskmaps, ai_player.json fields)
3. **Build health** known (make_zips.ps1; two-zip policy)
4. **Safeguards** referenced (Valiant Citadel notes)

**Definition of Done (per book):**
- Pass 1: lint & structure
- Pass 2: stubs ↔ code tasks alignment
- Pass 3: schema-valid JSON
- Pass 4: reproducible zips (exactly two)
(See `build_passes.md` for details.)

---

## 🔧 Protocol Notes

- **Commit style:** `type(scope): summary` + bullet body
- **JSON:** no comments; keep schema fields consistent with Book 1
- **Indices:** treasury README links to each book; taskmaps/ has its own README
- **Escalation:** if a gate fails twice, bounce back to GPT-5 with the error log

**Status:** Draft v0.2 • Root-level protocol file

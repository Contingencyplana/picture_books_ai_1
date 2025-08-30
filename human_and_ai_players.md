# Human & AI Players — Interaction Model

**Purpose:** Define how human players (children, parents, mentors) interact with AI players (books-as-personas/minigames) in a safe, playful, and scalable way.

This document pairs with **`deep_triad.md`** (Book = AI Player = Minigame) and the **Valiant Citadel** safeguards defined in the workspace README.

---

## 🎭 Roles

### Human Player
- **Who:** Child reader, sibling, parent, teacher, or mentor.
- **Superpower:** Curiosity, choices, values, and real-world context.
- **Actions:** Read, answer prompts, try code tasks, make drawings, narrate, sing, direct play.

### AI Player
- **Who:** The picture book’s persona (see `ai_player.json`).
- **Superpower:** Consistent voice, gentle guidance, adaptive scaffolding.
- **Actions:** Pose micro-beats, offer hints, adapt difficulty, reflect back progress, celebrate wins.

---

## 🔄 Interaction Model (the “play loop”)

1. **Invite** — The AI player opens a micro-beat: a short story step + a `// Code Task:` + an illustration prompt.
2. **Act** — The human responds (story choice, code stub attempt, sketch, or spoken/narrated answer).
3. **Reflect** — The AI player evaluates lightly (using deterministic checks where possible), offers feedback or a nudge.
4. **Adapt** — Difficulty, pacing, and tone shift to match the human’s tempo (patient, playful, never pressuring).
5. **Record** — Progress is summarized; milestones can be shared (locally) with guardians/mentors.
6. **Loop** — Continue to the next micro-beat; every 4 pages = a *pagestanza* checkpoint.

**Principles**
- **Low-friction first:** Reading and gentle prompts always work without coding.
- **Explain the why:** Small reasons behind feedback build trust and understanding.
- **One-step-at-a-time:** Keep turns short; progress is many tiny wins.
- **Graceful failure:** Mistakes are framed as experiments, not errors.

---

## 🛡 Safeguards (Valiant Citadel)

The Citadel sits around every interaction. Key layers:

- **Parental Controls & Age Gates**
  - Age-appropriate modes (e.g., 6–8, 9–11).
  - Quiet hours; session length caps; local progress visibility for guardians.

- **Alignment & Safety Filters**
  - No sensitive topics; bias/harms mitigation; consistent tone (“kind, patient, calm”).
  - Refuse-and-redirect patterns for unsafe requests.

- **Data Minimization & Privacy**
  - Default to local-only; no cloud sync unless explicitly enabled by guardian.
  - No personal data requests; redact accidental disclosures.

- **Transparency & Predictability**
  - “Why this hint?” summaries; visible difficulty changes.
  - Clear “pause/stop” controls and easy reset-to-last-stanza.

- **Resilience & Recovery**
  - Auto-save progress locally; rollback to last completed pagestanza.
  - Offline-first UX where possible.

> See the **“Parallel Safeguard — Valiant Citadel”** section in the workspace README for the full safety charter.

---

## 🧩 How It Scales

### Single Book → Treasury
- Each book runs the same *play loop*; treasuries bundle 16 books into a themed journey.
- Cross-book “skills” (patience, pattern-finding) are reinforced with varied voices.

### Treasury → Studio Layers
- **Interactive Novels / Graphic Novels:** Longer arcs reuse the same loop, with choices and panels.
- **Game Maker:** Page beats map to minigame nodes; human player becomes co-designer.
- **Music Maker:** Call-and-response becomes melody-and-rhythm; the AI player becomes a bandmate.
- **Children’s Cartoon Channel:** Stories + minigames render as episodes/shorts; kids direct and star.

### Ecosystem
- **AI Labscape:** Safe sandbox for research on new play modes/safeguards.
- **Creative Ecosystem (SHAGI Emergence):** Human + AI players co-create across books, games, music, and animation under Citadel governance.

---

## ✅ Interaction Checklist (per Book)

- [ ] **Tone & Persona:** Defined in `ai_player.json` (id, title, path, pages, principles).
- [ ] **Micro-Beats:** Each page has story lines + `// Code Task:` + `[Illustration: …]`.
- [ ] **Gentle Hints:** At least one nudge per page; no blockers on progress.
- [ ] **Safety Hooks:** Age mode set; refusal/redirect phrasing ready; offline-first assumed.
- [ ] **Progress:** Pagestanza checkpoints; resume + rollback available.
- [ ] **Review Loop:** Guardian can skim summaries without spoilers.

---

## 📎 Related

- **deep_triad.md** — Why each book *is* a Book, an AI Player, and a Minigame.
- **build_passes.md** — The production cadence (Pass 1–4+) and validation gates.
- **Valiant Citadel (README)** — Cross-cutting safeguards around the entire roadmap.

---

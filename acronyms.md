# acronyms.md

Acronyms used across **Picture Books Publishing House AI** and the broader Creative Ecosystem.

> Additions welcome. Keep entries alphabetical. If an acronym overlaps with a common industry term, note our project-specific meaning.

---

## A

- **AI** — Artificial Intelligence.
- **AI Labscape (AIL)** — Open sandbox for AI R&D; humans and AI co-experiment (new modes, safeguards, recursion).
- **AI Player (AIP)** — A book’s persona/agent defined by `ai_player.json` and page contracts.
- **AI Player JSON (AIPJ)** — The `ai_player.json` file (schema-validated book/player metadata).
- **ALT** — Alternative text for images/illustrations (accessibility).

## B

- **BPH** — *Picture Books Publishing House* (this workspace’s focus).

## C

- **C3** — *Children’s Cartoon Channel* (kid-made cartoons with parental safeguards).
- **CRC** — *Contract, Reproducibility, Consistency* (shorthand for our build guarantees).
- **CRLF** — Windows newline (`\r\n`); used in `.ps1` while repo targets LF for Markdown/text.
- **CSR** — *Checksums & Size Review* (the quick SHA256 + MB scan after zips).
- **CT** — *Code Task* (implicit ID CT-01..CT-32 mapped by page number; defined inline via each page’s single `// Code Task:` line — no separate `code_tasks.md`).

## D

- **DT** — *Deep Triad* (Book = AI Player = Minigame).

## E

- **E2E** — End-to-End (from page stubs → validated zips).

## G

- **GKS** — *Gamified Kickstarter* (“Money Machine”: funding as gameplay).
- **GLVL** — *Gamified LLVM* (“Lingual Lab”: compiler as playground).

## L

- **LF** — Line Feed newline (`\n`), default for Markdown/text in Git.
- **Lint** — Page contract linter (`_scripts/lint_pages.ps1`).

## M

- **MB** — Megabytes (size unit shown in build summaries).
- **MSZ** — *Mirrorstanza* (four consecutive **Roadstanzas**; a macro planning layer).

## P

- **Pass N** — One of the build passes (P1 Scaffold, P2 Narrative, P3 Code/Schema, P4 Repro/Validation, (Opt) P5 Art v0, etc. (Schema)).
- **PBP** — *Picture Book Page* (one `pageNN.md`).
- **PNN** — Page shorthand used in docs/commits (e.g., P03–P10).
- **PS** — PowerShell script.

## R

- **RZP** — *Rotation Zip Policy* (“latest + one timestamped”).
- **RSZ** — *Roadstanza* (four consecutive picture books; series-level planning segment, e.g., RSZ-0 “Foundations”).
- ~~**RZ**~~ — **Deprecated** alias (“Roadmap Zero / Roadstanza 0”). Prefer **RSZ-0** or the full phrase *Roadstanza 0* to avoid confusion with **RZP**.

## S

- **SHA256** — Hash used for zip verification.
- **SHAGI** — *Supersafe Hyperadvanced Artificial General Intelligence* (ecosystem end-state).
- **Stub Check** — Python harness validating `// Code Task` stubs.

## T

- **TBK** — *Treasury Book* (one 32-page book).
- **TOF** — *Treasury of Fairytales* (first treasury family).

## V

- **VC** — *Valiant Citadel* (parallel safeguards: security, alignment, parental controls, resilience).
- **V0** — Version 0 (first, lightweight pass; e.g., Art Pass v0).

---

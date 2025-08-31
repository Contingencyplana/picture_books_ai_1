# Fluff Inventory (Local-Only / Non-Review Artifacts)

> **Purpose:** A concise map of files/folders that external reviewers (e.g., GPT-5) cannot access directly.
> **Scope:** Local-only assets, large binaries, ephemeral caches, private refs, licensed media, and machine-specific config.
> **Update Policy:** Regenerate/update this file whenever `dist/picture_books_ai_1_clean_latest.zip` changes.

---

## Legend

- **Type:** one of [`generated`, `cache`, `binary-asset`, `private`, `config`, `script`, `template`, `playground`]
- **SoT:** Source of Truth (e.g., “local only”, “drive link”, “rendered from script”)
- **Zip:** Whether included in the clean ZIP (`yes`/`no`)
- **Regen:** How to rebuild/reacquire if missing
- **Sens:** Sensitivity note (e.g., “licensed art – do not redistribute”)

---

## Overview (High Level)

- **Local caches & build artifacts:** Speed up dev; excluded from clean zips.
- **Large/licensed assets:** Kept locally; described here for provenance & credits.
- **Machine/IDE configs:** VS Code, PowerShell tasks, local runners.
- **Playground drafts:** Exploratory text/images that don’t ship.

---

## Inventory (Brief Entries)

### 1) `_assets/reference_images/`

- **Type:** binary-asset
- **SoT:** Local folder (curated refs)
- **Zip:** no
- **Regen:** Curated by Mark; see credits in `docs/attribution.md`
- **Sens:** May include licensed or sourced images – internal reference only
- **Notes:** Visual tone refs for Books 1–2; used for moodboards.

### 2) `_playground/prompts/`

- **Type:** playground
- **SoT:** Local only
- **Zip:** no
- **Regen:** Not applicable; ephemeral ideation. Summarize winning prompts into `docs/prompt_notes.md`
- **Sens:** none

### 3) `.vscode/` (launch, tasks)

- **Type:** config
- **SoT:** Repo; machine-specific overrides in `.vscode/*.code-workspace`
- **Zip:** yes (non-secret)
- **Regen:** Copy from template in `docs/templates/vscode/`
- **Sens:** none

### 4) `_scripts/local_only/`

- **Type:** script
- **SoT:** Local only
- **Zip:** no
- **Regen:** Recreate from `docs/templates/scripts/` if missing
- **Sens:** May include machine paths; do not commit.

### 5) `_cache/` (lint/stub/schema caches)

- **Type:** cache
- **SoT:** Generated
- **Zip:** no
- **Regen:** Running `./_scripts/make_zips.ps1` or `invoke build`
- **Sens:** none

---

## Regeneration Notes

- **Build:** `pwsh -NoProfile -ExecutionPolicy Bypass ./_scripts/make_zips.ps1`
- **After build:** Update this file’s *Build Snapshot* with the latest ZIP hash.

### Build Snapshot

- **Latest ZIP:** `dist/picture_books_ai_1_clean_latest.zip`
- **Last Hash:** 021D3FBEC5A8DAD3CA7BA3BCDAC193122DCD8172CD57645119F4B655F6B7B944
- **Last Updated:** 2025-08-31 21:58 localh

---

## Inclusion Policy

- **Never in zip:** Caches, licensed original binaries, temp/playground drafts, machine secrets.
- **Allowed in zip:** Configs/templates that are safe & helpful to reviewers.
- **Document here:** Anything skipped from the ZIP that someone might look for later.

---

## Credits / Licensing

- See `docs/attribution.md` for any third-party assets referenced by the fluff.

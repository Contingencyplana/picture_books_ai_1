# React Preview (Local)

A one-page React UI that reads local minigame JSON and lets you click through choices.

## Run locally (no external APIs)
Option A — VS Code: Right-click `x0_0_research_arcade/react_preview/index.html` → “Open with Live Server”.
Option B — Python: from repo root:
py -3 -m http.server 5500

arduino
Copy code
Then open:
http://localhost:5500/x0_0_research_arcade/react_preview/index.html

vbnet
Copy code

Notes:
- The page loads React/Babel via CDN only (to avoid tooling). We can vendor UMD bundles later for fully offline use.
- Minigame data is local: `x0_0_research_arcade/minigames/*.json`. No networking to external APIs.

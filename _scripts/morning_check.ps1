$ErrorActionPreference = 'Stop'

# look for ghost book dirs at repo root (any a0_* except the canonical treasury)
$ghosts = Get-ChildItem -Directory -LiteralPath (Get-Location) |
  Where-Object { $_.Name -match '^a\d+_' -and $_.Name -ne 'a0_0_treasury_of_fairytales' } |
  Select-Object -ExpandProperty Name

# run tests
pytest -q

# fail if ghosts exist
if ($ghosts) { throw "Ghosts at repo root: $($ghosts -join ', ')" }

Write-Host "Morning check OK."

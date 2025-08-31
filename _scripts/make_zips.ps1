# _scripts/make_zips.ps1
# Build a clean zip after running pre-zip checks.
# Enforces exactly two files in dist/: <project>_clean_latest.zip and the single most recent timestamped zip.
# Also prints SHA256 checksums and a size/timestamp summary for quick verification.

param(
  [switch]$Release
)

$ErrorActionPreference = 'Stop'

# --- guard: block root-level ghost book dirs ---
$root = (Resolve-Path "$PSScriptRoot\..").Path
$ghosts = Get-ChildItem -Directory -LiteralPath $root |
  Where-Object { $_.Name -match '^a\d+_' -and $_.Name -notmatch '^a\d+_0_treasury_' }
if ($ghosts) {
  Write-Error "Ghost directories at root: $($ghosts.Name -join ', '). Aborting zip."
  exit 1
}
# --- end guard ---

# Resolve repo root (parent of this script's folder)
$RepoRoot = Split-Path -Parent $PSScriptRoot
Set-Location $RepoRoot

# --- Pre-zip: run stub contract checks ---------------------------------------------------------
Write-Host "Running stub contract checks..."
& python "tests/page_stub_check.py"
if ($LASTEXITCODE -ne 0) {
  Write-Error "Stub check failed. Aborting zip."
  exit 1
}
Write-Host "Stub check passed.`n"

# --- Prep paths --------------------------------------------------------------------------------
$ProjectName = Split-Path $RepoRoot -Leaf           # e.g., picture_books_ai_1
$BaseName    = "${ProjectName}_clean"               # e.g., picture_books_ai_1_clean
$DistDir     = Join-Path $RepoRoot 'dist'
$LatestZip   = Join-Path $DistDir  "${BaseName}_latest.zip"

if (-not (Test-Path $DistDir)) {
  New-Item -ItemType Directory -Path $DistDir | Out-Null
}

# --- Rotate previous latest (if any) using its original timestamp ------------------------------
# Name the rotated zip from the previous latest's LastWriteTime (yyyy-MM-dd-HHmm)
if (Test-Path $LatestZip) {
  $prevTs   = (Get-Item $LatestZip).LastWriteTime.ToString('yyyy-MM-dd-HHmm')
  $DatedZip = Join-Path $DistDir "${BaseName}_${prevTs}.zip"
  Move-Item -LiteralPath $LatestZip -Destination $DatedZip -Force
  Write-Host "Rotated previous latest to: $DatedZip"
}

# --- Build clean zip ---------------------------------------------------------------------------
# Exclude typical non-source directories/files from the archive.
$ExcludeTop = @('.git', 'dist', '.venv', 'venv', 'node_modules', '.pytest_cache', '__pycache__')

# Collect top-level entries to include (everything except excluded tops)
$TopLevelPaths = (Get-ChildItem -LiteralPath $RepoRoot -Force | Where-Object {
  $ExcludeTop -notcontains $_.Name
}).FullName

# Create temp zip, then move into dist as *_latest.zip
$TempZip = Join-Path $env:TEMP ("${BaseName}_$(Get-Date -Format 'yyyy-MM-dd-HHmm').tmp.zip")
if (Test-Path $TempZip) { Remove-Item -LiteralPath $TempZip -Force }

Compress-Archive -Path $TopLevelPaths -DestinationPath $TempZip -CompressionLevel Optimal -Force

# Promote to latest
Move-Item -LiteralPath $TempZip -Destination $LatestZip -Force

# --- Prune old zips: keep ONLY latest + most recent dated --------------------------------------
# Regex for: <BaseName>_YYYY-MM-DD-HHmm.zip
$DateNameRegex = ([regex]::Escape("${BaseName}_")) + '\d{4}-\d{2}-\d{2}-\d{4}\.zip$'

# Get dated files (exclude *_latest.zip), keep newest one by name, delete others
$DatedFiles = Get-ChildItem -LiteralPath $DistDir -Filter "${BaseName}_*.zip" -ErrorAction SilentlyContinue |
  Where-Object { $_.Name -match $DateNameRegex } |
  Sort-Object Name -Descending

if ($DatedFiles.Count -gt 1) {
  $ToRemove = $DatedFiles | Select-Object -Skip 1
  foreach ($f in $ToRemove) {
    Remove-Item -LiteralPath $f.FullName -Force -ErrorAction SilentlyContinue
  }
}

# Recompute to reflect final state
$DatedFiles = Get-ChildItem -LiteralPath $DistDir -Filter "${BaseName}_*.zip" -ErrorAction SilentlyContinue |
  Where-Object { $_.Name -match $DateNameRegex } |
  Sort-Object Name -Descending

Write-Host "DONE. Kept exactly two files in dist:"
Write-Host "  - $([System.IO.Path]::GetFileName($LatestZip))"
if ($DatedFiles.Count -ge 1) {
  Write-Host "  - $($DatedFiles[0].Name)"
} else {
  Write-Host "  - (no prior timestamped build yet)"
}

# --- Summary: size + timestamp + SHA256 --------------------------------------------------------
function Show-BuildSummary {
  param(
    [Parameter(Mandatory=$true)][string]$LatestPath,
    [Parameter(Mandatory=$false)][System.IO.FileInfo]$DatedFile
  )

  $rows = @()

  if (Test-Path $LatestPath) {
    $fi   = Get-Item -LiteralPath $LatestPath
    $hash = (Get-FileHash -Algorithm SHA256 -LiteralPath $LatestPath).Hash
    $rows += [PSCustomObject]@{
      Name          = $fi.Name
      Size_MB       = [Math]::Round($fi.Length / 1MB, 2)
      LastWriteTime = $fi.LastWriteTime
      SHA256        = $hash
    }
  }

  if ($null -ne $DatedFile) {
    $hash = (Get-FileHash -Algorithm SHA256 -LiteralPath $DatedFile.FullName).Hash
    $rows += [PSCustomObject]@{
      Name          = $DatedFile.Name
      Size_MB       = [Math]::Round($DatedFile.Length / 1MB, 2)
      LastWriteTime = $DatedFile.LastWriteTime
      SHA256        = $hash
    }
  }

  if ($rows.Count -gt 0) {
    Write-Host "`nBuild Summary:"
    $rows | Format-Table -AutoSize | Out-String | Write-Host

    if ($rows.Count -eq 2) {
      if ($rows[0].SHA256 -eq $rows[1].SHA256) {
        Write-Host "Hash check: ℹ latest matches previous (reproducible/no content change)."
      } else {
        Write-Host "Hash check: ℹ latest differs from previous (expected if files changed)."
      }
    }
  }
}

$MostRecentDated = $null
if ($DatedFiles.Count -ge 1) { $MostRecentDated = $DatedFiles[0] }
Show-BuildSummary -LatestPath $LatestZip -DatedFile $MostRecentDated

# --- Print snapshot to console ----------------------------------------------------------
$zip  = Get-Item -LiteralPath $LatestZip
$hash = (Get-FileHash $zip.FullName -Algorithm SHA256).Hash
$when = (Get-Item -LiteralPath $LatestZip).LastWriteTime.ToString("yyyy-MM-dd HH:mm:ss")

Write-Host "`nBuild Snapshot:"
Write-Host "  ZIP:    $($zip.Name)"
Write-Host "  SHA256: $hash"
Write-Host "  When:   $when"

# --- Fluff summary (optional) -----------------------------------------------------------
$fluff = Join-Path $RepoRoot 'tools\list_fluff.ps1'
if (Test-Path $fluff) {
  Write-Host "`nFluff summary:"
  pwsh -NoProfile -File $fluff
} else {
  Write-Host "`nFluff summary: (no fluff script)"
}

# --- Append snapshot to docs ONLY on -Release -------------------------------------------
if ($Release) {
  $docDir = Join-Path $RepoRoot 'docs'
  if (-not (Test-Path $docDir)) { New-Item -ItemType Directory -Path $docDir | Out-Null }
  $doc = Join-Path $docDir 'fluff_inventory.md'
  Add-Content -Path $doc -Value @"
### Build Snapshot

- **Latest ZIP:** dist/$($zip.Name)
- **Last Hash:** $hash
- **Last Updated:** $when local
"@
  Write-Host "Snapshot appended to docs (release mode)."
} else {
  Write-Host "Docs unchanged (non-release build)."
}

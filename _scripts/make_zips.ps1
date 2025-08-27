# _scripts/make_zips.ps1
<#
.SYNOPSIS
  Maintain exactly two zips in dist/: 
  - <repo>_clean_latest.zip (current build)
  - <repo>_clean_YYYY-MM-DD-HHmm.zip (previous build)

.PROCESS
  1) Delete any existing timestamped clean zips.
  2) If a _clean_latest.zip exists, rename it to today's timestamp.
  3) Create a fresh _clean_latest.zip from repo contents (excluding .git and dist).
#>

param(
  [string]$RepoName = "picture_books_ai_1"
)

# Resolve paths
$ScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$RepoRoot   = Split-Path -Parent $ScriptRoot
Set-Location $RepoRoot

# Ensure dist/
$dist = Join-Path $RepoRoot "dist"
if (-not (Test-Path $dist)) {
  New-Item -ItemType Directory -Path $dist | Out-Null
}

# Names/patterns
$ts          = Get-Date -Format "yyyy-MM-dd-HHmm"
$latestZip   = Join-Path $dist "$RepoName`_clean_latest.zip"
$tsPattern   = Join-Path $dist "$RepoName`_clean_20*.zip"  # matches any timestamped clean zip
$newTsZip    = Join-Path $dist "$RepoName`_clean_$ts.zip"
$tmpZip      = Join-Path $dist "__tmp_build.zip"

# 1) Delete any existing timestamped clean zips
Get-ChildItem -Path $tsPattern -ErrorAction SilentlyContinue | Remove-Item -Force -ErrorAction SilentlyContinue

# 2) Rotate: latest -> timestamped (if latest exists)
if (Test-Path $latestZip) {
  Rename-Item -Path $latestZip -NewName (Split-Path $newTsZip -Leaf) -Force
  Write-Host "Rotated previous latest to: $newTsZip"
}

# 3) Build a fresh latest zip (exclude .git and dist)
#    Gather items to include
$items = Get-ChildItem -LiteralPath $RepoRoot -Force | Where-Object { $_.Name -notin @('.git','dist') }
if (-not $items) {
  Write-Host "No items found to archive." -ForegroundColor Yellow
  exit 1
}

# Create temp zip then rename to latest
if (Test-Path $tmpZip) { Remove-Item $tmpZip -Force }
Compress-Archive -Path ($items | ForEach-Object { $_.FullName }) -DestinationPath $tmpZip -Force
if (Test-Path $latestZip) { Remove-Item $latestZip -Force }
Rename-Item -Path $tmpZip -NewName (Split-Path $latestZip -Leaf) -Force

Write-Host "DONE. Kept two files in dist/:"
Write-Host "  - $(Split-Path $latestZip -Leaf)"
if (Test-Path $newTsZip) { Write-Host "  - $(Split-Path $newTsZip -Leaf)" }

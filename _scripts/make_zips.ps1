# _scripts/make_zips.ps1
<#
.SYNOPSIS
  Maintain exactly two zips in dist/: 
  - <repo>_clean_latest.zip (current build)
  - <repo>_clean_YYYY-MM-DD-HHmm.zip (previous build)

  Excludes Windows cruft (Thumbs.db, desktop.ini, *.lnk), .git, and dist.
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
if (-not (Test-Path $dist)) { New-Item -ItemType Directory -Path $dist | Out-Null }

# Names/patterns
$ts        = Get-Date -Format "yyyy-MM-dd-HHmm"
$latestZip = Join-Path $dist "$RepoName`_clean_latest.zip"
$tsPattern = Join-Path $dist "$RepoName`_clean_20*.zip"   # any timestamped clean zip
$newTsZip  = Join-Path $dist "$RepoName`_clean_$ts.zip"

# 1) Delete any existing timestamped clean zips
Get-ChildItem -Path $tsPattern -ErrorAction SilentlyContinue | Remove-Item -Force -ErrorAction SilentlyContinue

# 2) Rotate: latest -> timestamped (if latest exists)
if (Test-Path $latestZip) {
  Rename-Item -Path $latestZip -NewName (Split-Path $newTsZip -Leaf) -Force
  Write-Host "Rotated previous latest to: $newTsZip"
}

# 3) Build a fresh latest zip
#    Stage a filtered copy to avoid zipping cruft
$staging = Join-Path $dist "__staging"
if (Test-Path $staging) { Remove-Item -Recurse -Force $staging }
New-Item -ItemType Directory -Path $staging | Out-Null

# Copy everything except .git, dist, and Windows cruft
$excludeDirs = @('.git', 'dist')
$excludeGlobs = @('Thumbs.db','desktop.ini','*.lnk')

# Copy directories (recursive)
Get-ChildItem -Force -Directory | Where-Object { $_.Name -notin $excludeDirs } | ForEach-Object {
  $target = Join-Path $staging $_.Name
  Copy-Item -Recurse -Force -Path $_.FullName -Destination $target -Exclude $excludeGlobs 2>$null
}

# Copy loose files at root
Get-ChildItem -Force -File -Exclude $excludeGlobs | ForEach-Object {
  Copy-Item -Force -Path $_.FullName -Destination (Join-Path $staging $_.Name)
}

# Create/refresh latest zip from staging
$tmpZip = Join-Path $dist "__tmp_build.zip"
if (Test-Path $tmpZip) { Remove-Item $tmpZip -Force }
Compress-Archive -Path $staging\* -DestinationPath $tmpZip -Force -CompressionLevel Optimal

if (Test-Path $latestZip) { Remove-Item $latestZip -Force }
Rename-Item -Path $tmpZip -NewName (Split-Path $latestZip -Leaf) -Force

# Clean staging
Remove-Item -Recurse -Force $staging

Write-Host "DONE. Kept up to two files in dist/:"
Write-Host "  - $(Split-Path $latestZip -Leaf)"
if (Test-Path $newTsZip) { Write-Host "  - $(Split-Path $newTsZip -Leaf)" }

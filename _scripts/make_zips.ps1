# _scripts/make_zips.ps1
# Build a clean zip after running pre-zip checks.
# Enforces exactly two files in dist/: <project>_clean_latest.zip and the single most recent timestamped zip.
# Also prints SHA256 checksums and a size/timestamp summary for quick verification.

$ErrorActionPreference = 'Stop'

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
$Timestamp   = Get-Date -Format "yyyy-MM-dd-HHmm"
$DatedZip    = Join-Path $DistDir  "${BaseName}_${Timestamp}.zip"

if (-not (Test-Path $DistDir)) {
  New-Item -ItemType Directory -Path $DistDir | Out-Null
}

# --- Rotate previous latest (if any) -----------------------------------------------------------
if (Test-Path $LatestZip) {
  Move-Item -LiteralPath $LatestZip -Destination $DatedZip -Force
  Write-Host "Rotated previous latest to: $DatedZip"
}

# --- Build clean zip ---------------------------------------------------------------------------
# Exclude typical non-source directories/files from the archive.
$ExcludeTop = @('.git', 'dist', '.venv', 'venv', 'node_modules', '.pytest_cache', '__pycache__')

# Collect top-level entries to include (everything except excluded tops)
$TopLevel = Get-ChildItem -LiteralPath $RepoRoot -Force | Where-Object {
  $ExcludeTop -notcontains $_.Name
}

# Create temp zip, then move into dist as *_latest.zip
$TempZip = Join-Path $env:TEMP ("${BaseName}_${Timestamp}.tmp.zip")
if (Test-Path $TempZip) { Remove-Item -LiteralPath $TempZip -Force }

Compress-Archive -Path $TopLevel.FullName -DestinationPath $TempZip -Force

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

Write-Host "DONE. Kept exactly two files in dist/:"
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
    $fi = Get-Item -LiteralPath $LatestPath
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

    if ($rows.Count -eq 2 -and $rows[0].SHA256 -eq $rows[1].SHA256) {
      Write-Host "Hash check: ✅ latest matches the rotated timestamped zip."
    } elseif ($rows.Count -eq 2) {
      Write-Host "Hash check: ⚠ latest differs from the rotated timestamped zip."
    }
  }
}

$MostRecentDated = $null
if ($DatedFiles.Count -ge 1) { $MostRecentDated = $DatedFiles[0] }
Show-BuildSummary -LatestPath $LatestZip -DatedFile $MostRecentDated

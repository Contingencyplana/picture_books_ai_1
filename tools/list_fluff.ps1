# tools/list_fluff.ps1

$patterns = @(
  "_assets/reference_images","_assets/original_art","_samples","_cache",
  "_temp","_playground","_scripts/local_only"
)

$rows = @()
foreach ($p in $patterns) {
  if (Test-Path $p) {
    $files  = Get-ChildItem -LiteralPath $p -Recurse -Force -File
    $bytes  = ($files | Measure-Object -Property Length -Sum).Sum
    $sizeMB = if ($bytes) { [math]::Round($bytes/1MB, 2) } else { 0 }
    $latest = if ($files.Count -gt 0) {
      ($files | Sort-Object LastWriteTime -Descending | Select-Object -First 1).LastWriteTime
    } else { $null }

    $rows += [pscustomobject]@{
      Folder    = $p
      Files     = $files.Count
      SizeMB    = $sizeMB
      LastWrite = $latest
    }
  }
}

$rows | Sort-Object Folder | Format-Table -AutoSize

if (-not $rows -or $rows.Count -eq 0) {
  Write-Host "  (no fluff folders found for the configured patterns)"
}

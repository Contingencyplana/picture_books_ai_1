$root = Get-Location
$patterns = @(
  "_assets/reference_images","_assets/original_art","_samples","_cache",
  "_temp","_playground","_scripts/local_only"
)
$rows = @()
foreach ($p in $patterns) {
  if (Test-Path $p) {
    $files = Get-ChildItem -LiteralPath $p -Recurse -Force -File
    $count = $files.Count
    $bytes = ($files | Measure-Object -Property Length -Sum).Sum
    $sizeMB = if ($bytes) { [math]::Round($bytes/1MB,2) } else { 0 }
    $rows += [pscustomobject]@{
      Folder = $p
      Files  = $count
      SizeMB = $sizeMB
      Updated = (Get-Date)
    }
  }
}
$rows | Sort-Object Folder | Format-Table -AutoSize

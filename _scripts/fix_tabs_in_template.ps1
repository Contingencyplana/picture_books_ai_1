param(
  [string]$TemplatePath = "_templates/picture_book_template",
  [int]$TabWidth = 4
)

function Expand-Tabs([string]$text, [int]$width) {
  # Replace ALL \t with spaces. For Markdown code blocks this is fine; we don't need
  # smart alignment—just deterministic 4-space indents per contract.
  return ($text -replace "`t", (' ' * $width))
}

$files = Get-ChildItem -Path (Join-Path $TemplatePath 'page*.md') -File
foreach ($f in $files) {
  $raw = Get-Content -LiteralPath $f.FullName -Raw -Encoding utf8
  $fixed = Expand-Tabs $raw $TabWidth

  if ($fixed -ne $raw) {
    # Ensure UTF-8 (no BOM), LF endings, no trailing whitespace changes beyond tabs
    $fixed = $fixed -replace "`r`n", "`n"      # normalize to LF
    Set-Content -LiteralPath $f.FullName -Value $fixed -NoNewline -Encoding utf8
    Write-Host "Fixed tabs:" $f.FullName
  }
}

Write-Host "Scan after fix (should be empty):"
$hits = Select-String -Pattern "`t" -Path (Join-Path $TemplatePath 'page*.md')
if ($hits) { $hits | Select Path, LineNumber, Line } else { Write-Host "✅ No tabs found." }

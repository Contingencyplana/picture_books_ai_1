param(
    [Parameter(Mandatory=$false)]
    [string]$BookPath
)

if (-not $BookPath) {
    Write-Host "Usage: .\\lint_pages.ps1 -BookPath '<path-to-book-folder>'"
    Write-Host "Example: .\lint_pages.ps1 -BookPath .\a0_0_treasury_of_fairytales\a0_0_the_loop_that_wanted_to_close"
    exit 2
}

$ErrorActionPreference = 'Stop'
$missingFiles = @()
$missingTitle = @()
$missingCodeTask = @()
$missingIllustration = @()

for ($i = 1; $i -le 32; $i++) {
    $pageNum = $i.ToString('00')
    $pageFile = Join-Path $BookPath ("page$pageNum.md")
    if (-not (Test-Path $pageFile)) {
        $missingFiles += $pageFile
        continue
    }
    $lines = Get-Content $pageFile
    if (-not ($lines | Where-Object { $_ -match '^(\{\{BOOK_TITLE\}\}|.+) — Page (\{\{PAGE_NUMBER\}\}|\d+)' })) {
        $missingTitle += $pageFile
    }
    if (-not ($lines | Where-Object { $_ -match '^// Code Task:' })) {
        $missingCodeTask += $pageFile
    }
    if (-not ($lines | Where-Object { $_ -match '^\[.*\]$' })) {
        $missingIllustration += $pageFile
    }
}

Write-Host "--- Lint Summary ---"
Write-Host "Pages missing: $($missingFiles.Count)"
Write-Host "Pages missing title: $($missingTitle.Count)"
Write-Host "Pages missing code task: $($missingCodeTask.Count)"
Write-Host "Pages missing illustration: $($missingIllustration.Count)"

if ($missingFiles.Count -or $missingTitle.Count -or $missingCodeTask.Count -or $missingIllustration.Count) {
    if ($missingFiles.Count) { Write-Host "Missing files:"; $missingFiles | ForEach-Object { Write-Host "  $_" } }
    if ($missingTitle.Count) { Write-Host "Missing title line:"; $missingTitle | ForEach-Object { Write-Host "  $_" } }
    if ($missingCodeTask.Count) { Write-Host "Missing code task:"; $missingCodeTask | ForEach-Object { Write-Host "  $_" } }
    if ($missingIllustration.Count) { Write-Host "Missing illustration prompt:"; $missingIllustration | ForEach-Object { Write-Host "  $_" } }
    exit 1
}

Write-Host "All checks passed!"
exit 0

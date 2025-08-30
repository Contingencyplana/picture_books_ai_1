param(
    [Parameter(Mandatory = $true)]
    [string]$BookPath
)

$ErrorActionPreference = 'Stop'

if (-not (Test-Path -LiteralPath $BookPath)) {
    Write-Host "Usage: .\lint_pages.ps1 -BookPath '<path-to-book-folder>'"
    Write-Host "Example: .\lint_pages.ps1 -BookPath .\a0_0_treasury_of_fairytales\a0_0_the_loop_that_wanted_to_close"
    Write-Error "BookPath not found: $BookPath"
    exit 2
}

# ---------------- Regexes per contract ----------------
# Title: '# Page NN' where NN = 1..32, optional leading zero (01..09)
$rxTitleLine = '^\s*#\s*Page\s*(?<num>0?\d{1,2})\s*$'

# Code Task (LENIENT): presence of marker only.
# Rationale: the strict format is enforced by tests/page_stub_check.py.
$rxCodeTask = '(?i)^\s*//\s*Code\s*Task:'

# Illustration: [Illustration: ...] (at least a few chars inside)
$rxIllustration = '^\s*\[Illustration:\s*.{3,}\]\s*$'

$missingFiles        = @()
$missingTitle        = @()
$titleNumberMismatch = @()
$missingCodeTask     = @()
$missingIllustration = @()

for ($i = 1; $i -le 32; $i++) {
    $pageNN   = $i.ToString('00')
    $pageName = "page$($pageNN).md"
    $pagePath = Join-Path -Path $BookPath -ChildPath $pageName

    if (-not (Test-Path -LiteralPath $pagePath)) {
        $missingFiles += $pagePath
        continue
    }

    # Read as UTF-8 to preserve Unicode characters faithfully
    $lines = Get-Content -LiteralPath $pagePath -Encoding UTF8

    # --- Title check ---
    $firstNonEmpty = $null
    foreach ($ln in $lines) {
        if ($ln.Trim().Length -gt 0) { $firstNonEmpty = $ln; break }
    }

    if ($null -eq $firstNonEmpty -or ($firstNonEmpty -notmatch $rxTitleLine)) {
        $missingTitle += $pagePath
    } else {
        $null = $null
        $firstNonEmpty -match $rxTitleLine | Out-Null
        $headerNum = [int]$Matches['num']
        if ($headerNum -ne $i) {
            $titleNumberMismatch += "$pagePath (header says $($Matches['num']); expected $i)"
        }
    }

    # --- Code Task check (lenient, presence only) ---
    if (-not ($lines | Where-Object { $_ -match $rxCodeTask })) {
        $missingCodeTask += $pagePath
    }

    # --- Illustration check ---
    if (-not ($lines | Where-Object { $_ -match $rxIllustration })) {
        $missingIllustration += $pagePath
    }
}

Write-Host "--- Lint Summary ---"
Write-Host "Pages missing: $($missingFiles.Count)"
Write-Host "Pages missing title: $($missingTitle.Count)"
Write-Host "Pages with title/page-number mismatch: $($titleNumberMismatch.Count)"
Write-Host "Pages missing code task: $($missingCodeTask.Count)"
Write-Host "Pages missing illustration: $($missingIllustration.Count)"

$hadErrors = $false

if ($missingFiles.Count) {
    Write-Host "Missing files:"; $missingFiles | ForEach-Object { Write-Host "  $_" }
    $hadErrors = $true
}
if ($missingTitle.Count) {
    Write-Host "Missing title line:"; $missingTitle | ForEach-Object { Write-Host "  $_" }
    $hadErrors = $true
}
if ($titleNumberMismatch.Count) {
    Write-Host "Title/page-number mismatch:"; $titleNumberMismatch | ForEach-Object { Write-Host "  $_" }
    $hadErrors = $true
}
if ($missingCodeTask.Count) {
    Write-Host "Missing code task:"; $missingCodeTask | ForEach-Object { Write-Host "  $_" }
    $hadErrors = $true
}
if ($missingIllustration.Count) {
    Write-Host "Missing illustration prompt:"; $missingIllustration | ForEach-Object { Write-Host "  $_" }
    $hadErrors = $true
}

if ($hadErrors) { exit 1 }

Write-Host "All checks passed!"
exit 0

Param(
    [Parameter(Mandatory=$true)][string]$TemplatePath
)

$errorCount = 0
Get-ChildItem -Path $TemplatePath -Filter 'page??.md' | Sort-Object Name | ForEach-Object {
    $file = $_.FullName
    $lines = Get-Content -Raw -Path $file -Encoding UTF8 -ErrorAction Stop -Delimiter '`0' | Out-String | Select-Object -ExpandProperty ToString
    $text = Get-Content -Path $file -Raw
    if ($text -match "`t") {
        Write-Host "TAB FOUND: $($_.Name)" -ForegroundColor Red
        $errorCount++
    }
    if ($text -notmatch '// Code Task: .*?_p\d{2}\(\) → RESULT: "Stub."') {
        Write-Host "CODE TASK MISMATCH: $($_.Name)" -ForegroundColor Yellow
        $errorCount++
    }
    if ($text -notmatch 'def .*?_p\d{2}\(\):\s*\n\s+return "Stub."') {
        Write-Host "STUB RETURN MISMATCH: $($_.Name)" -ForegroundColor Yellow
        $errorCount++
    }
}

if ($errorCount -eq 0) {
    Write-Host "All template pages validated (no tabs, contract lines present)." -ForegroundColor Green
    exit 0
} else {
    Write-Host "Validation completed with $errorCount issue(s)." -ForegroundColor Red
    exit 1
}

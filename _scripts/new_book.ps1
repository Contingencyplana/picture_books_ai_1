param(
    [Parameter(Mandatory)]
    [string]$TreasuryId,
    [Parameter(Mandatory)]
    [string]$BookId,
    [Parameter(Mandatory)]
    [string]$BookTitle,
    [Parameter(Mandatory)]
    [string]$TargetTreasuryPath
)

$ErrorActionPreference = 'Stop'

try {
    $templatePath = Join-Path $PSScriptRoot '..\_templates\picture_book_template'
    $safeBookTitle = $BookTitle.ToLower().Replace(' ','_')
    $targetBookPath = Join-Path $TargetTreasuryPath ("${BookId}_$safeBookTitle")

    # Copy the template folder
    Copy-Item -Recurse -Force $templatePath $targetBookPath

    # Get all .md and .json files except in assets
    $files = Get-ChildItem -Path $targetBookPath -Recurse -Include *.md,*.json | Where-Object { $_.FullName -notmatch '\\assets\\' }

    foreach ($file in $files) {
        (Get-Content $file.FullName) |
            ForEach-Object {
                $_ -replace '\{\{TREASURY_ID\}\}', $TreasuryId `
                   -replace '\{\{BOOK_ID\}\}', $BookId `
                   -replace '\{\{BOOK_TITLE\}\}', $BookTitle
            } | Set-Content $file.FullName
    }

    Write-Host "Created: $targetBookPath"
    Write-Host "DONE"
}
catch {
    Write-Error "Error: $_"
    exit 1
}

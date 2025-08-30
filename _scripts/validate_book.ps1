param(
  [Parameter(Mandatory = $true)]
  [string]$BookPath,

  # Optional: build zips after validation succeeds
  [switch]$ZipAfter
)

$ErrorActionPreference = 'Stop'

# Resolve repo root (parent of this script's folder) and normalize paths
$RepoRoot = Split-Path -Parent $PSScriptRoot
Set-Location $RepoRoot
$BookFull  = (Resolve-Path -LiteralPath $BookPath).Path

function Get-RelativePath($base, $target) {
  $baseFull   = (Resolve-Path -LiteralPath $base).Path
  $targetFull = (Resolve-Path -LiteralPath $target).Path
  $rel = [System.IO.Path]::GetRelativePath($baseFull, $targetFull)
  return $rel -replace '\\','/'
}

# ---------- 1) Stub checker ----------
Write-Host "▶ Running stub checker (tests/page_stub_check.py)..."
& python "tests/page_stub_check.py"
$stubOk = ($LASTEXITCODE -eq 0)
if ($stubOk) { Write-Host "✔ Stub checker: OK" } else { Write-Host "✘ Stub checker: FAILED" }

# ---------- 2) Page linter ----------
Write-Host "`n▶ Running page linter (_scripts/lint_pages.ps1)..."
& pwsh "_scripts/lint_pages.ps1" -BookPath $BookFull
$lintOk = ($LASTEXITCODE -eq 0)
if ($lintOk) { Write-Host "✔ Lint: OK" } else { Write-Host "✘ Lint: FAILED" }

# ---------- 3) ai_player.json sanity check ----------
Write-Host "`n▶ Validating ai_player.json..."
$aiPath = Join-Path $BookFull "ai_player.json"
$aiOk   = $false
$aiMsgs = @()

if (-not (Test-Path -LiteralPath $aiPath)) {
  $aiMsgs += "ai_player.json not found at: $aiPath"
} else {
  try {
    $json = Get-Content -LiteralPath $aiPath -Raw -Encoding UTF8 | ConvertFrom-Json
    # Required fields
    if ([string]::IsNullOrWhiteSpace($json.id))      { $aiMsgs += "Missing or empty 'id'." }
    if ([string]::IsNullOrWhiteSpace($json.title))   { $aiMsgs += "Missing or empty 'title'." }
    if ([string]::IsNullOrWhiteSpace($json.path))    { $aiMsgs += "Missing or empty 'path'." }
    if ($null -eq $json.pages)                       { $aiMsgs += "Missing 'pages'." }
    elseif ($json.pages -ne 32)                      { $aiMsgs += "'pages' must be 32 for picture books (got $($json.pages))." }

    # Optional but recommended: $schema field
    if ($null -eq $json.'$schema') {
      $aiMsgs += "Note: missing '`$schema' (recommended: _schemas/ai_player.schema.json)."
    } else {
      $expectedSchema = "_schemas/ai_player.schema.json"
      if ($json.'$schema' -ne $expectedSchema) {
        $aiMsgs += "Note: '`$schema' is '$($json.'$schema')' (recommended '$expectedSchema')."
      }
    }

    # Sanity: path should match relative folder path of the book
    $relFromRepo = Get-RelativePath $RepoRoot $BookFull
    if ($json.path -ne $relFromRepo) {
      $aiMsgs += "Note: 'path' differs from book folder relative path. JSON='$($json.path)', actual='$relFromRepo'."
    }

    if ($aiMsgs.Count -eq 0) { $aiOk = $true }
  } catch {
    $aiMsgs += "Failed to parse ai_player.json: $($_.Exception.Message)"
  }
}

if ($aiOk) {
  Write-Host "✔ ai_player.json: OK"
} else {
  Write-Host "✘ ai_player.json: FAILED"
  $aiMsgs | ForEach-Object { Write-Host "  - $_" }
}

# ---------- Summary ----------
Write-Host "`n==== Validation Summary ===="
Write-Host "Stub checker : " + ($(if ($stubOk) {"OK"} else {"FAIL"}))
Write-Host "Page lint    : " + ($(if ($lintOk) {"OK"} else {"FAIL"}))
Write-Host "ai_player    : " + ($(if ($aiOk) {"OK"} else {"FAIL"}))

if (-not ($stubOk -and $lintOk -and $aiOk)) {
  Write-Host "`nResult: ❌ One or more checks failed."
  exit 1
}

Write-Host "`nResult: ✅ All checks passed."

# ---------- Optional zip ----------
if ($ZipAfter) {
  Write-Host "`n▶ Building zips (make_zips.ps1)..."
  & pwsh "_scripts/make_zips.ps1"
  if ($LASTEXITCODE -ne 0) {
    Write-Host "✘ Zip step failed."
    exit 1
  }
}

exit 0

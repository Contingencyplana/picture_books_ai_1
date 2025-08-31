param([switch]$Fix)

$ErrorActionPreference = 'Stop'
$cfgPath = Join-Path $PSScriptRoot '..\.doctor-lucid.yml'
if (-not (Test-Path $cfgPath)) { Write-Host "No .doctor-lucid.yml; nothing to do."; exit 0 }

# Example: normalize one-blank-line after H1 + CP1252->UTF8 + Illustration dedupe
$targets = Get-ChildItem -Recurse -Filter *.md |
  Where-Object { $_.FullName -notmatch '\\dist\\' }

foreach ($f in $targets) {
  $s = Get-Content -Raw $f.FullName

  # dedupe [Illustration:] lines, keep the last
  $lines = $s -split '\r?\n'
  $ill   = ($lines | Where-Object { $_ -match '^\[Illustration:' } | Select-Object -Last 1)
  $lines = $lines | Where-Object { $_ -notmatch '^\[Illustration:' }
  if ($ill) { $lines += $ill }
  $s = ($lines -join "`r`n")

  # fix MD022: exactly one blank line after H1
  $s = [regex]::Replace($s, '^(# .+?)\r?\n(?:\s*\r?\n)*', "`$1`r`n`r`n",
        [System.Text.RegularExpressions.RegexOptions]::Multiline)

# CP1252 -> UTF-8 repair (safe, common chars)
$utf8   = [System.Text.Encoding]::UTF8
$cp1252 = [System.Text.Encoding]::GetEncoding(1252)

# —, –, ’, “, ”
$codepoints = 0x2014, 0x2013, 0x2019, 0x201C, 0x201D

foreach ($cp in $codepoints) {
  $correct = [string][char]$cp                            # proper Unicode char
  $garbled = $cp1252.GetString($utf8.GetBytes($correct))  # how it looks when mojibaked
  $s = $s.Replace($garbled, $correct)                     # fix it
}

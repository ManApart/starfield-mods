$ErrorActionPreference = 'Stop'

$exe = 'S:\xSFEdit64.exe'
if (Test-Path 'C:\Tools\xEdit\xSFEdit64.exe') {
  $exe = 'C:\Tools\xEdit\xSFEdit64.exe'
}

$iniFile = Join-Path $env:USERPROFILE 'Documents\My Games\Starfield\Starfield.ini'
$saveDir = Join-Path $env:USERPROFILE 'Documents\My Games\Starfield\Saves\'
$pluginsFile = Join-Path $env:LOCALAPPDATA 'Starfield\Plugins.txt'
$scriptsDir = 'S:\Edit Scripts\'
$dataDir = 'S:\Data\'

if (-not (Test-Path $exe)) {
  Write-Host "Missing xSFEdit64.exe at $exe"
  exit 1
}

if (-not (Test-Path $iniFile)) {
  Write-Host "Missing Starfield.ini at $iniFile"
  exit 1
}

if (-not (Test-Path $pluginsFile)) {
  Write-Host "Missing Plugins.txt at $pluginsFile"
  exit 1
}

Set-Location 'S:\'

$args = @(
  '-sf1',
  "-D:$dataDir",
  "-I:$iniFile",
  "-G:$saveDir",
  "-P:$pluginsFile",
  "-S:$scriptsDir"
)

Write-Host "Launching: $exe"
Write-Host 'Arguments:'
$args | ForEach-Object { Write-Host "  $_" }
Write-Host ''

& $exe @args
$code = $LASTEXITCODE

Write-Host ''
Write-Host "Exit code: $code"
exit $code

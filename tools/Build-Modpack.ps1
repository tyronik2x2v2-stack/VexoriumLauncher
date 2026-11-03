param(
    [Parameter(Mandatory = $true)]
    [ValidatePattern('^\d+\.\d+\.\d+$')]
    [string]$Version,
    [string]$Owner = "tyronik2x2v2-stack",
    [string]$Repository = "VexoriumLauncher"
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$sourceRoot = Join-Path $repoRoot "modpack-source"
$vexoriumRoot = Join-Path $sourceRoot "VEXORIUM"
$distRoot = Join-Path $repoRoot "dist"
$zipPath = Join-Path $distRoot "VexoriumModpack.zip"

$categories = @(
    "Vehicles",
    "Skins",
    "Accessories",
    "Clothing",
    "Map",
    "Buildings",
    "Textures",
    "Audio"
)

if (-not (Test-Path $vexoriumRoot -PathType Container)) {
    throw "Missing modpack source folder: $vexoriumRoot"
}

$assetFiles = Get-ChildItem -LiteralPath $vexoriumRoot -File -Recurse |
    Where-Object { $_.Name -ne ".gitkeep" -and $_.Name -ne "README.md" }

if (-not $assetFiles) {
    throw "No model/texture assets found. Add files under modpack-source/VEXORIUM first."
}

foreach ($category in $categories) {
    $path = Join-Path $vexoriumRoot $category
    if (-not (Test-Path $path -PathType Container)) {
        New-Item -ItemType Directory -Path $path -Force | Out-Null
    }
}

New-Item -ItemType Directory -Path $distRoot -Force | Out-Null
if (Test-Path $zipPath) {
    Remove-Item -LiteralPath $zipPath -Force
}

# Compress the VEXORIUM folder itself so the ZIP root contains VEXORIUM/.
Compress-Archive -Path $vexoriumRoot -DestinationPath $zipPath -CompressionLevel Optimal

$sha256 = (Get-FileHash -LiteralPath $zipPath -Algorithm SHA256).Hash.ToLowerInvariant()
$tag = "v$Version"
$downloadUrl = "https://github.com/$Owner/$Repository/releases/download/$tag/VexoriumModpack.zip"

$manifest = [ordered]@{
    version = $Version
    downloadUrl = $downloadUrl
    sha256 = $sha256
    archiveLayout = "ZIP root contains VEXORIUM/ with Vehicles, Skins, Accessories, Clothing, Map, Buildings, Textures and Audio."
}

$manifestPath = Join-Path $repoRoot "modpack.json"
$manifest | ConvertTo-Json -Depth 5 | Set-Content -LiteralPath $manifestPath -Encoding utf8

Write-Host ""
Write-Host "Modpack archive created:"
Write-Host "  $zipPath"
Write-Host "Size:"
Write-Host "  $((Get-Item $zipPath).Length) bytes"
Write-Host "SHA-256:"
Write-Host "  $sha256"
Write-Host ""
Write-Host "Manifest updated:"
Write-Host "  $manifestPath"
Write-Host ""
Write-Host "Next: create/publish GitHub Release $tag and attach VexoriumModpack.zip."

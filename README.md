# VEXORIUM ROLEPLAY Launcher

Windows x64 launcher for VEXORIUM ROLEPLAY.

## Player installation

On first launch, the launcher prepares one fixed game directory:

`C:\\VEXORIUM\\Game`

No folder picker is shown. If the managed game folder does not exist, the launcher downloads the project game archive configured in `.github/workflows/build-installer.yml`, verifies that it is a ZIP containing `gta_sa.exe`, and installs it through a staging folder. Existing installations outside the VEXORIUM directory are not used as the active game.

After the game is installed, the launcher automatically installs/verifies the SA-MP client, ASI Loader, Mod Loader, and the VEXORIUM client asset pack described by `modpack.json`. The launcher checks the selected server endpoint and starts the game client.

## Client asset pack

The manifest is `modpack.json`. Its ZIP archive must contain a top-level `VEXORIUM` folder with these categories:

- `Vehicles`
- `Skins`
- `Accessories`
- `Clothing`
- `Map`
- `Buildings`
- `Textures`
- `Audio`

Place source assets under `modpack-source/VEXORIUM`, then use `tools/Build-Modpack.ps1` to create a ZIP and calculate its SHA-256. Publish that ZIP as a GitHub Release asset and put its HTTPS download URL, version, and SHA-256 into `modpack.json`.

Important: Mod Loader client assets are not automatically equivalent to new server-side model IDs. New additional player/object models must also be registered by a server runtime that supports custom models; the client pack must contain the corresponding files for every player.

## Build

The workflow at `.github/workflows/build-installer.yml` builds a self-contained .NET 8 Windows x64 launcher and publishes it to GitHub Releases.

A build starts automatically when changes are pushed to `main`, or manually from **Actions → Build VEXORIUM Launcher → Run workflow**.

## Download

Latest launcher:

https://github.com/tyronik2x2v2-stack/VexoriumLauncher/releases/latest/download/VexoriumLauncher.exe

## Version

The current version is stored in `version.json`.

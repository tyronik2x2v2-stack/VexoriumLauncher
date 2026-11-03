# VEXORIUM client modpack source

Place the actual model and texture files under `VEXORIUM/` using these category folders: `Vehicles`, `Skins`, `Accessories`, `Clothing`, `Map`, `Buildings`, `Textures`, and `Audio`.

The ZIP delivered to players must contain a top-level `VEXORIUM/` folder. Do not put installers, EXE files, scripts, or unrelated archives in the modpack. Only include assets that the project is authorized to distribute. When assets are ready, run `tools/Build-Modpack.ps1 -Version x.y.z`, publish the generated ZIP as a GitHub Release asset, and keep the generated `modpack.json` in the main branch.

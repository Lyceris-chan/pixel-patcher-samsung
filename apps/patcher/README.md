# Pixel Watch Patcher Engine

The core patching engine for adapting Google Pixel Watch faces and assets to Samsung Galaxy Watch hardware.

## ✨ Features

- **Unified Patching**: Combines legacy fixes (kill code bypass, AOD freeze) with modern complication bridging.
- **Dynamic Discovery**: Automatically identifies target classes using bytecode signatures instead of hardcoded filenames.
- **Compact DEX Support**: Uses modern Apktool implementations to preserve Compact DEX headers, preventing "Header size mismatch" crashes on Wear OS 4/5.
- **Complication Bridging**: Redirects native Pixel/Fitbit complication providers to the high-performance `Pixel Bridge` app automatically.
- **Factory Image Extraction**: Rapidly unsparses and decompresses system `img` files to harvest original Pixel Watch APKs, `.ogg` sounds, and `.ttf` fonts locally using Python natively alongside `7z`.

## 🛠️ Components

- `patch_watchface_unified.py`: The main orchestration script.
- `lib/`:
    - `complication_data_patcher.py`: Injects protective safeguards and payload handlers into Smali bytecode.
    - `default_complication_patcher.py`: Re-routes default watch face providers to `com.pixelbridge.complications`.
    - `watchface_config_patcher.py`: Fixes `lateinit` property initialization crashes.
    - `unsparse.py`: High-performance Android sparse image converter.
    - `extract_factory_image.py`: Automates Google Factory ZIP extraction.

## 🚀 Usage (Standalone)

While it is recommended to use the main toolkit wizard, the patcher can be run independently on individual APKs:

```bash
python3 patch_watchface_unified.py <input.apk> [output.apk]
```


## Recommended Pixel Watch 4 LTE Factory Image

For reproducible extraction of stock fonts/sounds/APKs, use:

- `https://dl.google.com/dl/android/aosp/menari_lte-cp1a.260305.014.w4-factory-7043463b.zip`

Example:

```bash
python3 lib/extract_factory_image.py /path/to/menari_lte-cp1a.260305.014.w4-factory-7043463b.zip
```

## Debloat Package Catalog

The debloat subsystem ships with a documented package catalog so users can review exactly which protected/system packages are intentionally excluded from destructive actions. The canonical source is `lib/debloat_catalog.py` (dictionary form), and `lib/debloat.py` consumes it directly.

| Package | Category | Why it is protected |
| --- | --- | --- |
| `com.google.android.wearable.sysui` | Core system | Critical Wear OS UI package. |
| `com.samsung.android.watch.watchface.superhero` | Core watchface | Safe fallback watchface used by migration recovery. |
| `com.android.systemui` | Core system | Critical Android UI process. |
| `android` | Core framework | Base framework package. |
| `com.google.android.gms` | Core services | Required by Play services-backed features. |
| `com.android.vending` | Store services | Needed for Play Store app installs and updates. |

## Patch Documentation (Why / Where / When / How)

| Patch Area | Why | Where | When Applied | How |
| --- | --- | --- | --- | --- |
| Complication provider remap | Ensure Samsung watches use bridge providers that mirror Pixel/Fitbit defaults. | `lib/provider_mapper.py`, `lib/default_complication_patcher.py` | During watchface patch pipeline before rebuild/sign. | Rewrites provider component strings from Pixel/Fitbit services to `com.pixelbridge.complications/*`. |
| Complication text/data fallback | Avoid `--` placeholders caused by name mismatches or placeholder-only payloads. | `lib/complication_data_patcher.py`, bridge `HealthDataManager.kt` | At runtime (bridge) and at patch-time (smali) depending on target app path. | Adds safer parsing/placeholder checks and alias-aware key lookups. |
| Complication tap-to-open behavior | Match Pixel expectation that tapping a health complication opens health app context. | Bridge `Complication*Service.kt`, `ComplicationIntents.kt` | Runtime when complication data is served. | Adds immutable `PendingIntent` tap actions that launch Samsung Health package when installed. |
| Font packaging (Samsung Sans method) | Keep compatibility with Samsung font validation path while using Pixel-style font assets. | `lib/font_patcher.py`, `tools/samsung_font_toolkit/samsung_sans_template` | When user runs font patch flow. | Repackages chosen TTF into Samsung Sans-compatible FlipFont APK template and signs it. |
| Factory extraction (fonts/sounds/APKs) | Pull stock Pixel assets for closer UX parity and offline reproducibility. | `lib/extract_factory_image.py`, `lib/factory_image.py`, `lib/unsparse.py` | Before patching assets or building replacement packs. | Extracts nested factory images, unsparses partitions, then harvests `.apk`, `.ogg`, and related assets. |
| Debloat safety rails | Prevent core-package removal and keep migration path recoverable. | `lib/debloat.py`, `lib/debloat_catalog.py` | During any debloat action. | Blocks protected packages and exposes a documented catalog for UI/CLI visibility. |

## Extended Debloat Risk Dictionary

For broader debloat guidance (including optional apps), see:

- `lib/debloat_package_risks.py`

Each entry includes:
- package purpose/description
- risk level (`critical`, `high`, `medium`, `low`)
- expected impact if removed
- practical recommendation

The runtime helper `DebloatEngine.list_package_risks()` exposes the same data to CLI/UI layers.

## Settings Breakage Risk (Debloat)

Some package removals can break specific Settings pages or toggles. The debloater now tracks `settings_impacted` for each documented package in `lib/debloat_package_risks.py`.

Use this workflow before removal:
1. Inspect package risk (`DebloatEngine.get_removal_risk(package)` / `list_package_risks()`).
2. Confirm the impacted setting area is not needed by the user.
3. Prefer `disable` before `uninstall` so rollback is easier.

## One UI 8 (Wear OS 6, R920XXU2DZB6) Default Configuration Notes

These baseline ADB commands can be used after patch/debloat to restore expected defaults:

```bash
# Re-enable known critical packages
adb shell cmd package install-existing com.google.android.wearable.sysui
adb shell cmd package install-existing com.android.systemui
adb shell cmd package install-existing com.google.android.gms
adb shell cmd package install-existing com.android.vending

# Set Pixel Bridge as default for supported complication providers (patch output dependent)
# Example verification command:
adb shell dumpsys activity providers | grep -i pixelbridge
```

For font parity, keep the Samsung Sans-compatible packaging flow (`lib/font_patcher.py`) and source TTF extracted from the chosen Pixel factory image. For sounds parity, use `lib/extract_factory_image.py` to harvest `.ogg` assets from factory partitions before packaging.

### What “Caging” Means

Caging is a reversible containment action (not full uninstall):
- applies app-ops background restriction (`RUN_IN_BACKGROUND=ignore`)
- applies network policy restriction for background behavior

Benefits:
- safer than uninstall for uncertain packages
- easier rollback when a setting/function breaks

Tradeoff:
- package remains installed and still uses storage

The API helpers `DebloatEngine.explain_caging()` and `DebloatEngine.suggest_cage_candidates()` provide this guidance programmatically.

### Full-package documentation workflow

Because package sets vary by firmware/region, the project now combines:
1. curated risk entries (`lib/debloat_package_risks.py`), and
2. runtime lookup fallback (`get_removal_risk`) for unknown packages.

Recommended flow:
- export installed package list from watch,
- annotate/extend `lib/debloat_package_risks.py` with missing packages,
- use `disable`/`cage` first, then uninstall only after verification.

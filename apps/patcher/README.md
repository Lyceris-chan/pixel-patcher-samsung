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
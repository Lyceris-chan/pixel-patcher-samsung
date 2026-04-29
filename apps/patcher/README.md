# Pixel Watch Patcher Engine

The core patching engine for adapting Google Pixel Watch faces to Samsung Galaxy Watch hardware.

## ✨ Features

- **Unified Patching**: Combines legacy fixes (kill code bypass, AOD freeze) with modern complication bridging.
- **Dynamic Discovery**: No longer depends on hardcoded filenames. Automatically identifies target classes using bytecode signatures.
- **Compact DEX Support**: Uses AAPT2 and modern Apktool to preserve Compact DEX headers, preventing "Header size mismatch" crashes on Wear OS 4/5.
- **Complication Bridging**: Redirects native Pixel/Fitbit complication providers to the high-performance `Pixel Bridge` app.
- **Register-Agnostic Regex**: Advanced regex patterns that dynamically capture registers, ensuring reliability across different compiler optimizations.

## 🛠️ Components

- `patch_watchface_unified.py`: The main orchestration script.
- `lib/`:
    - `complication_data_patcher.py`: Adds `isPlaceholder()` checks to Smali code.
    - `default_complication_patcher.py`: Re-routes default watch face providers.
    - `watchface_config_patcher.py`: Fixes `lateinit` property initialization crashes.
    - `unsparse.py`: High-performance Android sparse image converter.
    - `config.py`: Centralized path and tool management.

## 🚀 Usage (Standalone)

While it is recommended to use the main toolkit wizard, the patcher can be run independently:

```bash
python3 apps/patcher/patch_watchface_unified.py <input.apk> [output.apk]
```

## 📝 Technical Details

For in-depth technical rationale and patch specifications, see the [Knowledge Base](../../docs/KNOWLEDGE_BASE.md).

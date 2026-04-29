# Pixel Watch Toolkit for Samsung Galaxy Watch 5 Pro

This mono-repo provides a production-grade automated pipeline to port Google Pixel Watch resources (watch faces, launchers, and sounds) to the Samsung Galaxy Watch 5 Pro (SM-R925F). It handles precision binary patching, health data bridging, and multithreaded resource extraction.

## Project Architecture & Data Flow

```text
.
├── main.py                # Primary Entry Point (Interactive TUI)
├── apps/
│   ├── patcher/           # Binary patching logic, regex engines, and vendored libs
│   └── bridge/            # Kotlin source code for the Android Complication Bridge
├── docs/                  # Technical deep-dives and architectural documentation
└── tools/                 # OS-specific portable binaries, analysis toolkits, and loose scripts
```

The toolkit operates as a hybrid system:
1.  **Host-Side (Python):** Orchestrates the extraction of factory images, decompilation of APKs, precision bytecode modification (SMALI), and re-signing for modern Wear OS.
2.  **Watch-Side (Kotlin/Wear OS):** The "Pixel Bridge" application runs as a background service on the watch, proxying health data from the Wear OS Health Services API to the patched watch faces.

**Data Flow:**
`Pixel Factory Image` → `7-Zip Extraction` → `Apktool Decompile` → `Python UnifiedPatcher` (Bytecode Mod) → `Apktool Rebuild` → `Uber APK Signer` → `ADB Installation` ←→ `Pixel Bridge Service` (Data Proxy).

## Technical Rationale ("The Why")

### 1. Why Binary Patching?
Pixel watch faces contain hardcoded dependencies on Google-exclusive hardware and software features.
*   **Hardware Kill-Switches:** The `WatchFaceApplication` throws an `IllegalStateException` if it detects non-Google hardware. We precisely bypass this `throw` in the bytecode.
*   **Feature Spoofing:** Many animations rely on `PackageManager.hasSystemFeature()`. We patch the return values to `true` to unlock full visual fidelity.
*   **AOD Stability:** Samsung's ambient mode transitions can trigger `IllegalArgumentException` in the Pixel renderer. We inject exception handling to prevent watch face freezes.

### 2. Why the Complication Bridge?
The Samsung Galaxy Watch 5 Pro implements a **"Safe Watch Face"** restriction. Third-party watch faces (including ported Pixel ones) are blocked from accessing Samsung Health data directly.
*   **The Solution:** The **Pixel Bridge** uses the system-level **Health Services API** (accessible via `BODY_SENSORS` permissions) to fetch raw sensor data and presents it via standard `ComplicationDataSourceService` interfaces that the watch faces can bind to.

### 3. Why Specific Tools?
*   **AAPT2:** Required for proper resource alignment on Wear OS 4+.
*   **Uber APK Signer (v1.3.0):** Automatically applies v2/v3 signatures and Zipalign, meeting the strict security requirements of modern Android.
*   **Apktool (v3.0.2):** Latest 2026 release providing superior resource decoding and stability.
*   **Android Platform-Tools (v37.0.0):** Ensures compatibility with the latest Wear OS 5/6 kernels.
*   **Zero-Dependency Python:** The toolkit manages its own portable binaries (ADB, JRE 17, 7-Zip 26.00) to ensure cross-platform consistency and zero host system pollution.

## Engineering Standards

### Google Developer Style Guide Adherence
*   **Python:** Adheres to **PEP 8** and **Google Python Style Guide**. Uses type hinting (`typing`), pre-compiled regex for performance, and clean separation of concerns.
*   **Kotlin:** Follows **Google Android/Kotlin Style Guide**. Utilizes `suspend` functions, Coroutines for non-blocking I/O, and `SharedPreferences` for low-latency data caching between the Bridge and Complications.

### Implementation Principles
*   **Idempotency:** Patching operations are designed to be safe to run multiple times.
*   **Precision Modification:** We use targeted regex patterns rather than replacing entire files to maintain compatibility across different APK versions.
*   **Async Performance:** Heavy tasks like extraction and tool setup use `concurrent.futures` or Coroutines to maintain responsiveness.

## Building and Running

### Main Toolkit
```bash
python3 main.py
```
*Handles the end-to-end wizard including tool setup, extraction, and patching.*

### Pixel Bridge (Android)
```bash
cd apps/bridge
./gradlew assembleDebug
```
*Output: `apps/bridge/app/build/outputs/apk/debug/app-debug.apk`*

### Manual Patching
```bash
python3 apps/patcher/patch_watchface_unified.py input.apk output.apk
```

## Key Files & Symbols

*   `apps/patcher/patch_watchface_unified.py`:
    *   `_EXCEPTION_THROW_PATTERN`: Regex for bypassing the hardware kill-switch.
    *   `_HAS_SYSTEM_FEATURE_PATTERN`: Regex for feature spoofing.
*   `apps/bridge/app/src/main/java/com/pixelbridge/complications/HealthDataManager.kt`:
    *   `registerPassiveListener()`: Initializes background health monitoring.
    *   `getSleepDurationLast24h()`: Fetches data via Health Connect.
*   `docs/KNOWLEDGE_BASE.md`: The definitive source for reverse-engineering insights and Samsung-specific technical hurdles.

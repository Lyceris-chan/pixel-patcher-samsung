# Pixel Watch Toolkit for Samsung Galaxy Watch 5 Pro

**Unified toolkit for porting Pixel Watch faces, launchers, and sounds to the Samsung Galaxy Watch 5 Pro.**

This mono-repo provides a comprehensive, automated pipeline to adapt Google Pixel Watch resources specifically for the Samsung Galaxy Watch 5 Pro (SM-R925F). It handles binary patching, complication bridging, resource extraction, and deep system modifications with zero host dependencies.

## 🚀 Getting Started

The toolkit is designed for portability. You only need **Python 3.8+** installed on your host system (Windows, macOS, or Linux).

1.  **Clone the Repository:**
    ```bash
    git clone https://github.com/your-repo/pixel-watch-toolkit.git
    cd pixel-watch-toolkit
    ```

2.  **Launch the Toolkit:**
    ```bash
    python3 main.py
    ```

*Note: On the first run, the toolkit will detect your operating system and offer to download the necessary portable binaries (ADB, JRE, Apktool, etc.) into the `tools/` directory.*

## ✨ Core Features

*   🪄 **Automated Wizard**: A start-to-finish automated workflow that handles setup, factory image extraction, and interactive resource selection in one cohesive flow.
*   🎨 **Automated APK Patching**: Precision-modifies Pixel Watch face APKs to bypass hardware kill-switches, fix Always-On Display (AOD) freezes, and unlock Pixel-exclusive animations.
*   🛜 **Wireless ADB Integration**: Seamlessly pair and connect to your watch over Wi-Fi directly from the toolkit's interface.
*   🌉 **Pixel Complication Bridge**: Compiles and installs a high-performance background service that bridges **11+ health metrics** directly to your watch faces. The toolkit automatically maps original Pixel provider slots to their Bridge equivalents, ensuring a "native-feel" experience. Fully compliant with AndroidX Wear Watchface APIs (`GOAL_PROGRESS`, `RANGED_VALUE` bounds checking, and `MonochromaticImage` support for Fitbit Icon parity).
*   ⌨️ **Pixel Apps & Configuration**: Automatically extracts and configures the Pixel Keyboard as the default IME and installs the Pixel Launcher as the default home application.
*   🎵 **System Audio Overhaul**: Deploys native system alarms, ringtones, and UI notifications (including low battery and charging sounds) gracefully via ADB.
*   ✒️ **Custom Font (zFont) Integration**: Automated extraction, patching, and spoofing of `.ttf` fonts (e.g., Google Sans) into a Samsung-compatible FlipFont APK format, complete with 1-click install.
*   🛡️ **Zero-Config Security**: Automatically grants all necessary health, sensor, and system permissions via ADB during installation. Your watch faces work immediately with full data access.

### Supported Bridge Metrics:
*   ❤️ **Heart Rate**: Real-time BPM from optical sensor.
*   👣 **Step Count**: Cumulative daily steps (`GOAL_PROGRESS` support).
*   🔥 **Active Calories**: Active metabolic calories burned.
*   📏 **Distance**: Daily distance traveled.
*   🧗 **Floors Climbed**: Total elevation gain in floors.
*   🩸 **SpO2**: Blood oxygen saturation percentage.
*   ⚡ **Active Minutes**: Daily active exercise duration.
*   🏔️ **Elevation**: Total daily elevation gain.
*   💓 **HRV**: Heart Rate Variability.
*   🫁 **Respiratory Rate**: Breathing rate.
*   😴 **Sleep Duration**: Total sleep duration from last 24h.

## 📁 Project Architecture

```text
.
├── main.py                # Primary Entry Point (Interactive TUI)
├── apps/
│   ├── patcher/           # Binary patching logic, regex engines, and vendored libs
│   └── bridge/            # Kotlin source code for the Android Complication Bridge
├── docs/                  # Technical deep-dives and architectural documentation
└── tools/                 # OS-specific portable binaries, analysis toolkits, and loose scripts
```

---

**Version**: 2.1.0  
**Compliance**: Adheres to Google Developer Style Guidelines.  
**Tested Environments**: 
*   Samsung Galaxy Watch 5 Pro (SM-R925F, One UI 6.0 / Wear OS 4+)
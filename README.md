# Pixel Watch Toolkit for Samsung Galaxy Watch 5 Pro

**Unified toolkit for porting Pixel Watch faces, launchers, and sounds to the Samsung Galaxy Watch 5 Pro.**

This mono-repo provides a comprehensive, automated pipeline to adapt Google Pixel Watch resources specifically for the Samsung Galaxy Watch 5 Pro (SM-R925F). It handles binary patching, complication bridging, and resource extraction with zero host dependencies.

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
*   🌉 **Pixel Complication Bridge**: Compiles and installs a high-performance background service that bridges **11+ health metrics** directly to your watch faces. The toolkit automatically maps original Pixel provider slots to their Bridge equivalents, ensuring a "native-feel" experience where data appears exactly where it would on a Pixel Watch.

### Supported Metrics:
*   ❤️ **Heart Rate**: Real-time BPM from optical sensor.
*   👣 **Step Count**: Cumulative daily steps.
*   🔥 **Active Calories**: Active metabolic calories burned.
*   📏 **Distance**: Daily distance traveled (KM/Miles).
*   🧗 **Floors Climbed**: Total elevation gain in floors.
*   🩸 **SpO2**: Blood oxygen saturation percentage.
*   ⚡ **Active Minutes**: Daily active exercise duration.
*   🏔️ **Elevation**: Total daily elevation gain.
*   💓 **HRV**: Heart Rate Variability (RMSSD).
*   🫁 **Respiratory Rate**: Breathing rate.
*   😴 **Sleep Duration**: Total sleep duration from last 24h (via Health Connect).

See the [Bridge Implementation Guide](docs/BRIDGE_IMPLEMENTATION.md) for technical details on data provenance and permissions.
*   🔔 **High-Performance Extraction**: Uses multithreaded 7-Zip extraction to process gigabyte-scale factory images in seconds, allowing you to select and install specific apps and sounds.
*   🛡️ **Zero-Config Security**: Automatically grants all necessary health, sensor, and system permissions via ADB during installation. Your watch faces work immediately with full data access, no manual hurdles.
*   🚀 **Pixel Launcher Support**: Automatically installs and configures the Pixel Watch Launcher as your default home application.

### System Operations and Management

The toolkit includes integrated management commands within the interactive wizard to secure and optimize the watch environment post-installation.

*   **App Location Auditing**: Wear OS applications frequently poll location sensors to update environmental metrics, which passively drains battery life on non-native hardware. The toolkit provides a real-time audit of all packages holding fine or coarse location permissions. This allows users to review and sequentially revoke these permissions in a single action, ensuring battery preservation and privacy.
*   **Developer Mode Management**: Leaving Android Developer Options enabled introduces measurable background overhead (such as the persistent ADB daemon) and presents a security risk. The toolkit includes a dedicated command to modify the global system settings, cleanly disabling the developer menu and tearing down background debugging services once the installation is complete.
*   **Safe Device Disconnection**: Standard ADB commands to disable network interfaces abruptly sever the connection before the execution succeeds, resulting in broken pipe errors on the host. To ensure a graceful exit, the toolkit dispatches a detached background process to the watch. This process waits for the host to successfully close the ADB session before independently disabling the Wi-Fi and Bluetooth radios on the device.

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

## 🔧 Technical Rationale

For a deep-dive into **why** specific patches are necessary—including the "Safe Watch Face" whitelist and AOD rendering exceptions—please refer to our [Technical Knowledge Base](docs/KNOWLEDGE_BASE.md).

---

**Version**: 2.1.0  
**Compliance**: Adheres to Google Developer Style Guidelines.  
**Tested Environments**: 
*   Samsung Galaxy Watch 5 Pro (SM-R925F, One UI 6.0 / Watch OS)


# Pixel Bridge

The Pixel Bridge is a native Kotlin Wear OS application that acts as a secure background service. It bridges the system-level Health Services API (available on Samsung Galaxy Watches) to the `ComplicationDataSourceService` endpoints expected by Google Pixel watch faces.

## Architecture

This bridge is engineered for strict adherence to the **AndroidX Wear Watchface API**. It correctly implements:
- `GOAL_PROGRESS` (Type 13) payloads for accumulation metrics (e.g., Steps).
- `RANGED_VALUE` (Type 5) payloads with strict `coerceIn(min, max)` bounding to prevent API 33+ fatal exceptions.
- `MonochromaticImage` integration, ensuring Fitbit icons gracefully tint and match native Pixel Watch aesthetics.
- `PassiveMonitoringClient` background updates without aggressive polling.

## Build Instructions

To build the APK manually:

```bash
./gradlew assembleDebug
```

The compiled APK will be located in `app/build/outputs/apk/debug/app-debug.apk`.

## Features
- Real-time Heart Rate (BPM)
- Daily Step Count (with 10k Goal)
- Daily Distance
- Active Calories Burned
- Floors Climbed
- Blood Oxygen (SpO2)
- Sleep Duration
- Active Minutes
- Elevation
- Heart Rate Variability (HRV)
- Respiratory Rate
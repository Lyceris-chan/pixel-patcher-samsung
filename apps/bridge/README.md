# Pixel Bridge

The Pixel Bridge is a Kotlin Wear OS application that acts as a background service. It bridges the system-level Health Services API (available on Samsung Galaxy Watches) to the `ComplicationDataSourceService` endpoints expected by Google Pixel watch faces.

## Build Instructions

To build the APK:

```bash
./gradlew assembleDebug
```

The compiled APK will be located in `app/build/outputs/apk/debug/app-debug.apk`.

## Features
- Real-time Heart Rate (BPM)
- Daily Step Count
- Daily Distance
- Active Calories Burned
- Floors Climbed
- Blood Oxygen (SpO2)
- Sleep Duration
- Active Minutes
- Elevation
- Heart Rate Variability (HRV)
- Respiratory Rate

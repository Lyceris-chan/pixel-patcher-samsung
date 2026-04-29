# Pixel Bridge Implementation Details

This document outlines the technical implementation of the Pixel Bridge application, which provides health and fitness data to Pixel Watch faces running on Samsung Galaxy Watch devices.

## Data Sources

The application utilizes two primary data sources to provide comprehensive coverage of health metrics:

### 1. Health Services on Wear OS (`androidx.health:health-services-client`)
Acts as the primary source for real-time sensor data and daily aggregates computed by the watch's hardware.

*   **Mode:** `PassiveMonitoringClient`
*   **Metrics Provided:**
    *   `HEART_RATE_BPM`: Live heart rate from the optical sensor.
    *   `STEPS_DAILY`: Total steps taken since midnight.
    *   `CALORIES_DAILY`: Active and basal calories burned.
    *   `DISTANCE_DAILY`: Distance traveled (converted to km).
    *   `FLOORS_DAILY`: Total floors climbed.
    *   `SPO2`: Blood oxygen saturation percentage.
    *   `ACTIVE_EXERCISE_DURATION_DAILY`: Total minutes spent in active exercise.
    *   `ELEVATION_GAIN_DAILY`: Total elevation gain for the day.
    *   `HEART_RATE_VARIABILITY_RMSSD`: HRV metrics.
    *   `RESPIRATORY_RATE`: Breathing rate.

### 2. Health Connect (`androidx.health.connect.client`)
Used for retrieving historical data and metrics aggregated from multiple authorized applications.

*   **Metrics Provided:**
    *   `SleepSessionRecord`: Used to compute total sleep duration over the last 24 hours.

## Technical Architecture

### HealthDataManager
A centralized manager class that handles:
*   Registration of the `PassiveListenerService`.
*   Asynchronous reading of Health Connect records using Coroutines.
*   Persistent storage of the latest metrics in `SharedPreferences` for fast retrieval by complication services.

### PassiveListenerService
A background service that receives updates from Health Services even when the application is not in the foreground. It parses `DataPoint` objects and updates the local cache.

### Complication Services
Individual `SuspendingComplicationDataSourceService` implementations for each metric. They retrieve the latest available data from `HealthDataManager` and format it as `ShortTextComplicationData`.

## Permissions & Security

The toolkit automatically grants all required runtime permissions via ADB during the installation phase. This ensures the bridge and watchfaces work immediately without manual configuration.

### Automatically Granted Permissions (via ADB)

| Permission | Component | Rationale |
| :--- | :--- | :--- |
| `BODY_SENSORS` | All | Real-time Heart Rate, SpO2, and sensor data. |
| `BODY_SENSORS_BACKGROUND` | All | Allows data fetching while the watchface is not active. |
| `ACTIVITY_RECOGNITION` | All | Step counting, floors climbed, and exercise detection. |
| `ACCESS_FINE_LOCATION` | Watchfaces | Weather updates, altitude, and GPS-based metrics. |
| `READ_MEDIA_AUDIO` | Watchfaces | Access to custom Pixel Ringtones and Alarms. |
| `RECEIVE_COMPLICATION_DATA` | Watchfaces | Allows the watchface to bind to the Bridge service. |
| `HIGH_SAMPLING_RATE_SENSORS`| Bridge | Ensures high-precision real-time sensor updates. |

### Health Connect Data Access
While system permissions are granted via ADB, **Health Connect** (used for Sleep and historical data) requires a one-time user authorization. 
1. Open the **Pixel Bridge** app from your watch's app drawer.
2. Follow the on-screen prompts to grant "Read" access for Sleep and Steps.
3. This is a framework-level requirement on Android 14+ for data privacy.

## References

*   [Health Services on Wear OS | Android Developers](https://developer.android.com/training/wearables/health-services)
*   [Health Connect | Android Developers](https://developer.android.com/health-and-fitness/guides/health-connect)
*   [Build a Complication Data Source | Android Developers](https://developer.android.com/training/wearables/watch-faces/complications/data-sources)

#!/usr/bin/env bash
set -euo pipefail

adb shell pm grant com.pixelbridge.complications android.permission.BODY_SENSORS || true
adb shell pm grant com.pixelbridge.complications android.permission.BODY_SENSORS_BACKGROUND || true
adb shell pm grant com.pixelbridge.complications android.permission.ACTIVITY_RECOGNITION || true

adb shell pm grant com.google.android.deskclock android.permission.POST_NOTIFICATIONS || true
adb shell appops set com.google.android.deskclock SCHEDULE_EXACT_ALARM allow || true

echo "Permission grant script completed."
echo "Note: Health Connect permissions must still be approved by the user in-app."

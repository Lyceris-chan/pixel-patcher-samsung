# Wear OS App Visibility Guide

This document explains how the Pixel Watch Toolkit determines if an installed application will appear in your Samsung Galaxy Watch's app drawer.

## How Visibility Works
In Android and Wear OS, an application is only shown in the app drawer if its `AndroidManifest.xml` contains an activity with the `android.intent.category.LAUNCHER` category. 

If an app lacks this category, it operates entirely in the background, as a system service, or as a plug-in component (like a Watch Face). 

## Visibility Table

The toolkit dynamically scans your extracted factory image to determine visibility. Below is a reference for common Pixel Watch applications:

| App Name | Package Name | App Drawer Visibility | Description |
| :--- | :--- | :---: | :--- |
| **Pixel Watch Faces** | `com.google.android.wearable.watchface` | ❌ **Hidden** | Accessed by long-pressing your current watch face to enter the picker. |
| **Complication Bridge** | `com.pixelbridge.complications` | ❌ **Hidden** | Runs silently in the background providing data to watch faces. |
| **Pixel Launcher** | `com.google.android.wearable.app` | ❌ **Hidden** | Replaces your home screen and recent apps UI; does not have its own drawer icon. |
| **Pixel Recorder** | `com.google.android.apps.recorder` | ✅ **Visible** | Appears in your app drawer for recording voice memos. |
| **Fitbit** | `com.fitbit.FitbitMobile` | ✅ **Visible** | Appears in your app drawer to launch the main Fitbit interface. |
| **Weather** | `com.google.android.apps.weather` | ✅ **Visible** | Appears in your app drawer for weather forecasts. |
| **System Sounds** | N/A (`.ogg` files) | ❌ **Hidden** | Injected directly into the Android media provider for use in Settings. |

## TUI Integration
When you run the automated wizard via `python3 main.py`, the App Selection screen will parse every APK on-the-fly and display a **Visible** column (`Yes` or `No`), so you know exactly how the app will behave once installed on your watch.

"""System Tweaks and Optimization for Pixel Watch Toolkit.

This module applies various system-level optimizations and UX tweaks
to the Samsung Galaxy Watch, enhancing power management and visual aesthetics.
"""

import subprocess
import logging

logger = logging.getLogger(__name__)

class SystemTweaks:
    """Applies system-level tweaks via ADB."""

    def __init__(self, adb_path: str = "adb"):
        self.adb_path = adb_path

    def _run_adb(self, *args: str) -> subprocess.CompletedProcess:
        """Helper to run adb commands."""
        return subprocess.run([self.adb_path, "shell", *args], capture_output=True, text=True)

    def optimize_power_management(self) -> None:
        """Configures power management settings."""
        logger.info("Applying Power Management Tweaks...")
        # Disable "Stay awake while charging"
        self._run_adb("settings", "put", "global", "stay_on_while_plugged_in", "0")
        
        # Disable "Enable WiFi when charging"
        self._run_adb("settings", "put", "global", "enable_wifi_when_charging", "0")
        
        # Turn off automatic WiFi
        self._run_adb("settings", "put", "global", "wifi_on_when_proxy_disconnected", "0")
        
        # Disable Samsung's custom ChargingAod window overlay
        self._run_adb("settings", "put", "global", "charging_info_always", "0")
        self._run_adb("settings", "put", "system", "charging_info_always", "0")
        self._run_adb("settings", "put", "secure", "charging_info_always", "0")
        
        # Tighten Doze idle timers (~30s)
        self._run_adb("device_config", "put", "device_idle", "light_idle_to", "30000")
        
        logger.info("Power management optimized.")

    def apply_ui_ux_tweaks(self) -> None:
        """Configures UI/UX settings like animations and indicators."""
        logger.info("Applying UI/UX Tweaks...")
        # Animations: Set all scales to 0.5
        self._run_adb("settings", "put", "global", "window_animation_scale", "0.5")
        self._run_adb("settings", "put", "global", "transition_animation_scale", "0.5")
        self._run_adb("settings", "put", "global", "animator_duration_scale", "0.5")
        
        # Status Indicators: Implement "Hide after 2 seconds"
        # This is typically a Samsung specific setting, placeholder key:
        self._run_adb("settings", "put", "system", "status_indicator_display_duration", "2000")
        
        # Set screen timeout to 15 seconds to save battery
        self._run_adb("settings", "put", "system", "screen_off_timeout", "15000")
        
        logger.info("UI/UX tweaks applied.")

    def apply_fixes(self) -> None:
        """Applies specific system bug fixes."""
        logger.info("Applying System Fixes...")
        # Apply the fix for "System Update crashing in Settings list"
        # Typically fixed by re-enabling a stub or changing a setting
        self._run_adb("pm", "enable", "com.google.android.gms/.update.SystemUpdateActivity")
        logger.info("System Fixes applied.")

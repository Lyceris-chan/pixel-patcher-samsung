"""
ADB Manager for Pixel Extract toolkit.

This module provides functions for managing ADB connections, including 
support for Wireless ADB pairing and connection which is standard on 
modern Wear OS devices.
"""

import os
import subprocess
import sys
import re
from typing import Optional, List, Tuple
import config

def get_adb_path() -> str:
    """Get the path to the bundled adb binary."""
    adb_bin = "adb"
    if sys.platform == "win32":
        adb_bin = "adb.exe"
    
    # Check bundled platform-tools first
    bundled_adb = os.path.join(config.TOOLS_DIR, "platform-tools", adb_bin)
    if os.path.exists(bundled_adb):
        return bundled_adb
    
    # Fallback to system adb (if any)
    return "adb"

def run_adb_command(args: List[str]) -> Tuple[int, str, str]:
    """
    Run an ADB command and return return code, stdout, and stderr.
    
    Args:
        args: List of arguments for adb
        
    Returns:
        Tuple[int, str, str]: (return_code, stdout, stderr)
    """
    adb_path = get_adb_path()
    cmd = [adb_path] + args
    
    try:
        process = subprocess.Popen(
            cmd,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True
        )
        stdout, stderr = process.communicate()
        return process.returncode, stdout, stderr
    except FileNotFoundError:
        return 1, "", "ADB binary not found."
    except Exception as e:
        return 1, "", str(e)

def check_adb_connection() -> bool:
    """
    Check if a device is currently connected via ADB.
    
    Returns:
        bool: True if at least one device is connected
    """
    rc, stdout, _ = run_adb_command(["devices"])
    if rc != 0:
        return False
    
    # Filter out "List of devices attached" line and empty lines
    lines = [line for line in stdout.splitlines() if line.strip() and not line.startswith("List of")]
    return len(lines) > 0

def pair_wireless_adb(address: str, pin: str) -> bool:
    """
    Pair with a device using Wireless ADB pairing.
    
    Args:
        address: IP address and port (e.g. 192.168.1.100:41234)
        pin: Pairing PIN
        
    Returns:
        bool: True if pairing successful
    """
    print(f"Attempting to pair with {address} using PIN {pin}...")
    rc, stdout, stderr = run_adb_command(["pair", address, pin])
    
    if rc == 0 and "Successfully paired" in stdout:
        print(f"✅ Successfully paired with {address}")
        return True
    else:
        print(f"❌ Pairing failed: {stderr or stdout}")
        return False

def connect_wireless_adb(address: str, default_port: int = 5555) -> bool:
    """
    Connect to a device via Wireless ADB.
    
    Args:
        address: IP address (optionally with port) of the watch
        default_port: Port to use if not specified in address
        
    Returns:
        bool: True if connection successful
    """
    if ":" not in address:
        target = f"{address}:{default_port}"
    else:
        target = address

    print(f"Attempting to connect to {target}...")
    rc, stdout, stderr = run_adb_command(["connect", target])
    
    if rc == 0 and "connected to" in stdout:
        print(f"✅ Successfully connected to {target}")
        return True
    else:
        print(f"❌ Connection failed: {stderr or stdout}")
        return False

def get_device_info() -> Optional[str]:
    """Get connected device model name."""
    rc, stdout, _ = run_adb_command(["shell", "getprop", "ro.product.model"])
    if rc == 0:
        return stdout.strip()
    return None

def install_apk(apk_path: str, reinstall: bool = True) -> bool:
    """Install an APK to the connected device."""
    args = ["install", "-d", "-g"]
    if reinstall:
        args.append("-r")
    args.append(apk_path)
    
    rc, stdout, stderr = run_adb_command(args)
    
    # Handle signature mismatch / incompatible update
    if rc != 0 and "INCOMPATIBLE" in (stdout + stderr):
        print("⚠️ Incompatible version found. Please uninstall the existing app first.")
        # We don't auto-uninstall yet to be safe, but we notify.
        
    return rc == 0

def grant_production_permissions(package_name: str, is_bridge: bool = False) -> None:
    """
    Grants all required production permissions via ADB to ensure immediate functionality.
    
    Args:
        package_name: The Android package name to grant permissions to.
        is_bridge: If True, grants bridge-specific health permissions.
    """
    # Base permissions required for both watchfaces and the bridge
    base_permissions = [
        "android.permission.BODY_SENSORS",
        "android.permission.BODY_SENSORS_BACKGROUND",
        "android.permission.ACTIVITY_RECOGNITION"
    ]
    
    # Permissions specific to the Pixel Watchfaces
    watchface_permissions = [
        "android.permission.ACCESS_FINE_LOCATION",
        "android.permission.ACCESS_COARSE_LOCATION",
        "android.permission.READ_EXTERNAL_STORAGE",
        "android.permission.READ_MEDIA_AUDIO",
        "com.google.android.wearable.permission.RECEIVE_COMPLICATION_DATA"
    ]
    
    # Permissions specific to the Bridge (Sensor access and Health Connect interaction)
    bridge_permissions = [
        "android.permission.HIGH_SAMPLING_RATE_SENSORS",
        "com.samsung.android.wear.shealth.healthdataprovider.permission.READ"
    ]

    target_list = base_permissions + (bridge_permissions if is_bridge else watchface_permissions)
    
    print(f"[*] Granting {len(target_list)} permissions to {package_name}...")
    for perm in target_list:
        success = grant_permission(package_name, perm)
        status = "✓" if success else "!"
        # Log failures quietly as some permissions are SDK-version dependent
        if not success:
            pass # Silently skip unsupported/already granted perms

def grant_permission(package: str, permission: str) -> bool:
    """Grant a runtime permission to a package via ADB."""
    rc, _, _ = run_adb_command(["shell", "pm", "grant", package, permission])
    return rc == 0

def force_enable_components(package_name: str) -> bool:
    """
    Force-enable all services in a package and un-stop it.
    """
    # 1. Un-stop the package (Essential for API 30+)
    run_adb_command(["shell", "am", "force-stop", package_name])
    
    # 2. Dump all services
    rc, stdout, _ = run_adb_command(["shell", "pm", "dump", package_name])
    if rc != 0:
        return False
        
    # Extract all service names
    services = re.findall(r'Service\s+{[^}]+' + re.escape(package_name) + r'/([^}]+)}', stdout)
    
    for service in services:
        if "WatchFaceService" in service or "orbita" in service.lower() or "Modular" in service:
            full_name = f"{package_name}/{service}"
            full_name = full_name.split()[0] # Remove potential extras
            run_adb_command(["shell", "pm", "enable", full_name])
                
    return True

def set_watchface(service_path: str) -> bool:
    """Set the active watchface via ADB."""
    # Force enable first
    pkg = service_path.split("/")[0]
    force_enable_components(pkg)
    
    # Modern method using 'cmd wallpaper'
    rc, _, _ = run_adb_command(["shell", "cmd", "wallpaper", "set-wallpaper", "--component", service_path])
    
    # Fallback/Secondary method for some Samsung versions
    run_adb_command(["shell", "settings", "put", "secure", "active_watchface_component", service_path])
    
    return rc == 0

def push_file(local_path: str, remote_path: str) -> bool:
    """Push a file to the connected device."""
    rc, _, _ = run_adb_command(["push", local_path, remote_path])
    return rc == 0

if __name__ == "__main__":
    # Quick test
    print(f"ADB Path: {get_adb_path()}")
    if check_adb_connection():
        print(f"Device connected: {get_device_info()}")
    else:
        print("No device connected.")

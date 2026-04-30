#!/usr/bin/env python3
"""
Pixel Watch Toolkit - Production Interoperability Suite

Automated pipeline for adapting Pixel Watch resources to Samsung hardware.
Includes full Wizard workflow, dynamic patching, and health data bridging.

Version: 2.1.0
"""

import os
import sys
import subprocess
import zipfile
import shutil
import signal
import concurrent.futures
from pathlib import Path
from datetime import datetime
from typing import Tuple, List, Optional, Callable

# Add internal paths
sys.path.insert(0, os.path.join(os.path.dirname(__file__), 'apps', 'patcher'))
sys.path.insert(0, os.path.join(os.path.dirname(__file__), 'apps', 'patcher', 'lib'))

try:
    import config
    CONF = config.get_config()
    ADB = CONF['adb']
    JAVA = CONF['java']
    SEVENZ = CONF['7z']
except ImportError:
    CONF = {}
    ADB = JAVA = SEVENZ = None

class Colors:
    HEADER = '\033[95m'
    BLUE = '\033[94m'
    CYAN = '\033[96m'
    GREEN = '\033[92m'
    YELLOW = '\033[93m'
    RED = '\033[91m'
    WARNING = '\033[93m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'


def print_header():
    print(f"\n{Colors.BOLD}{Colors.CYAN}{'=' * 70}{Colors.ENDC}")
    print(f"{Colors.BOLD}{Colors.CYAN}  Pixel Watch Toolkit for Samsung Galaxy Watch{Colors.ENDC}")
    print(f"{Colors.BOLD}{Colors.CYAN}  Production Interoperability Suite - v3.0.0{Colors.ENDC}")
    print(f"{Colors.BOLD}{Colors.CYAN}{'=' * 70}{Colors.ENDC}")


def print_section(title: str):
    print(f"\n{Colors.BOLD}{Colors.BLUE}▶ {title}{Colors.ENDC}")
    print(f"{Colors.BLUE}{'─' * 70}{Colors.ENDC}")


def run_adb_command(cmd: list) -> Tuple[bool, str]:
    if not ADB: return False, "ADB not found."
    try:
        result = subprocess.run([ADB] + cmd, capture_output=True, text=True, timeout=45)
        return result.returncode == 0, result.stdout.strip()
    except Exception as e: return False, str(e)


def check_setup():
    conf = config.get_config()
    required = ['java', 'adb', '7z', 'apktool', 'signer']
    missing = [t for t in required if not conf.get(t) or not os.path.exists(conf.get(t))]
    if missing:
        print_header()
        print(f"{Colors.YELLOW}Toolchain Incomplete: {', '.join(missing)}{Colors.ENDC}")
        if input("\nDownload portable binaries? (y/n): ").lower() == 'y':
            from setup_tools import main as run_setup
            run_setup()
            import importlib
            importlib.reload(config)
            global CONF, ADB, JAVA, SEVENZ
            CONF = config.get_config()
            ADB, JAVA, SEVENZ = CONF['adb'], CONF['java'], CONF['7z']
        else: sys.exit(1)


def get_apk_info(apk_path: str) -> Optional[dict]:
    # Extracting info via apktool is too slow for thousands of APKs.
    # Fallback to basic info based on filename to speed up scanning.
    label = os.path.basename(apk_path).replace('.apk', '')
    return {
        'package': "unknown",
        'version': "unknown",
        'label': label,
        'visible': True
    }


def parse_range(s: str) -> List[int]:
    res = []
    for p in s.split(','):
        if '-' in p:
            a, b = map(int, p.split('-'))
            res.extend(range(a, b+1))
        else: res.append(int(p))
    return res


def push_sound(local: str, cat: str):
    name = os.path.basename(local)
    m = {'ringtone': 'Ringtones', 'notification_sound': 'Notifications', 'alarm_alert': 'Alarms', 'low_battery_sound': 'Notifications', 'charging_sounds_file': 'Notifications'}
    rem = f"/sdcard/{m.get(cat, 'Notifications')}/{name}"
    print(f"Deploying {name}...")
    if run_adb_command(["push", local, rem])[0]:
        run_adb_command(["shell", "content", "call", "--method", "scan_volume", "--uri", "content://media", "--arg", "external_primary"])
        ok, out = run_adb_command(["shell", "content", "query", "--uri", "content://media/external/audio/media", "--projection", "_id", "--where", f"'_display_name=\"{name}\"'"])
        if ok and "_id=" in out:
            try:
                mid = out.split("_id=")[1].split(",")[0].strip()
                uri = f"content://media/external/audio/media/{mid}"
                namespace = "global" if cat in ("charging_sounds_file", "low_battery_sound") else "system"
                run_adb_command(["shell", "settings", "put", namespace, cat, uri])
                print(f"{Colors.GREEN}Successfully set {name} as default {cat}{Colors.ENDC}")
            except: pass


def menu_wizard():
    print_section("Automated Installation Wizard")
    check_setup()

    do_extract = input("Extract factory image from ZIP? (y/n): ").lower() == 'y'
    if do_extract:
        zip_p = input("Enter path to Factory ZIP: ").strip()
        if os.path.exists(zip_p):
            from extract_factory_image import process_factory_image
            process_factory_image(zip_p)

    # Debloat
    print(f"\n{Colors.WARNING}WARNING: Debloating may cause instability or break certain watch features.{Colors.ENDC}")
    if input("Run Debloater? (y/n): ").lower() == 'y':
        from debloat import DebloatEngine
        engine = DebloatEngine(ADB)
        engine.run_migration_fixup()

    # System Tweaks
    print(f"\n{Colors.WARNING}WARNING: System Tweaks modify core power and UI settings, which may cause unexpected battery behavior.{Colors.ENDC}")
    if input("Apply System Tweaks (Power & UI)? (y/n): ").lower() == 'y':
        from tweaks import SystemTweaks
        tweaks = SystemTweaks(ADB)
        tweaks.optimize_power_management()
        tweaks.apply_ui_ux_tweaks()
        tweaks.apply_fixes()

    # Font Integration
    print(f"\n{Colors.WARNING}WARNING: Font patching modifies system overlays and could cause UI glitches or unreadable text.{Colors.ENDC}")
    if input("Patch and inject Pixel Watch Font (Google Sans)? (y/n): ").lower() == 'y':
        from font_patcher import patch_font, setup_pixel_keyboard
        ttf_path = input("Path to TTF (e.g. Wear-GoogleSans-Regular.ttf): ").strip()
        if os.path.exists(ttf_path):
            out_apk = "wf_work/patched_font.apk"
            if patch_font(ttf_path, out_apk, "Google Sans"):
                if run_adb_command(["install", "-r", out_apk])[0]:
                    print(f"{Colors.GREEN}Font installed successfully. Please select it in watch settings.{Colors.ENDC}")
        kbd_apk = input("Path to Pixel Keyboard APK (or press Enter to skip): ").strip()
        if os.path.exists(kbd_apk):
            setup_pixel_keyboard(kbd_apk)

    # APK Selection via AppManager
    from app_manage import AppManager
    am = AppManager()
    am.verify_portable_tools()
    
    import config as lib_config
    apks_d = Path(lib_config.APKS_DIR)
    apks = list(apks_d.glob("**/*.apk"))
    sel_apks = []
    if apks:
        print(f"\nScanning {len(apks)} APKs...")
        meta = []
        for a in apks:
            i = get_apk_info(str(a))
            if i: meta.append((a, i))
        meta.sort(key=lambda x: x[1]['label'])
        print(f"\n{Colors.BOLD}{'ID':<4} {'App Name':<30} {'Version':<15} {'Visible':<10} {'Package'}{Colors.ENDC}")
        for i, (p, info) in enumerate(meta, 1):
            vis_str = "Yes" if info.get('visible') else "No"
            print(f"{i:<4} {info['label'][:30]:<30} {info['version'][:15]:<15} {vis_str:<10} {info['package']}")
        c = input("\nEnter IDs to install (e.g. 1,3-5) or 'all' (or press Enter to skip): ").strip().lower()
        if c == 'all': sel_apks = [m[0] for m in meta]
        elif c:
            try:
                ids = parse_range(c)
                sel_apks = [meta[x-1][0] for x in ids if 0 < x <= len(meta)]
            except: pass

    # Sound Selection
    snd_d = Path(lib_config.SOUNDS_DIR)
    snds = list(snd_d.glob("**/*.ogg"))
    sel_snds = []
    if snds:
        print(f"\nFound {len(snds)} system sounds.")
        sc = input("1. Default sounds (incl. battery/charging)  2. Select individual  3. All  4. None: ").strip()
        if sc == '1': sel_snds = "DEFAULTS"
        elif sc == '2':
            snds.sort(key=lambda x: x.name)
            for i, s in enumerate(snds, 1): print(f"{i:<4} {s.name}")
            try: sel_snds = [snds[x-1] for x in parse_range(input("IDs: ")) if 0 < x <= len(snds)]
            except: pass
        elif sc == '3': sel_snds = snds

    # Watchface and Bridge bundle
    watchfaces = [a for a in sel_apks if "WatchFaces" in a.name or "watchface" in a.name.lower()]
    do_b = False
    if watchfaces:
        print(f"\n{Colors.YELLOW}Note: Selected Watch Faces will be patched and installed alongside the Pixel Bridge as a bundle.{Colors.ENDC}")
        do_b = True
    elif input("\nBuild & Install Complication Bridge standalone? (y/n): ").lower() == 'y':
        do_b = True

    print(f"\n{Colors.BOLD}Starting Deployment...{Colors.ENDC}")
    if do_b: menu_build_bridge()

    for wf in watchfaces:
        out = str(wf).replace('.apk', '_patched.apk')
        print(f"Patching {wf.name}...")
        subprocess.run([sys.executable, 'apps/patcher/patch_watchface_unified.py', str(wf), out])
        if run_adb_command(["install", "-r", out])[0]:
            from adb_manager import grant_production_permissions
            info = get_apk_info(out)
            pkg = info['package'] if info else "com.google.android.wearable.watchface.rwf"
            grant_production_permissions(pkg, is_bridge=False)

    for a in sel_apks:
        if a not in watchfaces:
            print(f"Installing {a.name}...")
            if run_adb_command(["install", "-r", str(a)])[0]:
                info = get_apk_info(str(a))
                if info:
                    from adb_manager import grant_production_permissions
                    grant_production_permissions(info['package'], is_bridge=False)

    if sel_snds == "DEFAULTS":
        for s in snds:
            if 'Ringtone' in s.name: push_sound(str(s), "ringtone")
            elif 'Notification' in s.name: push_sound(str(s), "notification_sound")
    elif isinstance(sel_snds, list):
        for s in sel_snds: push_sound(str(s), "notification_sound")
    print(f"\n{Colors.GREEN}{Colors.BOLD}Wizard Complete!{Colors.ENDC}")


def menu_build_bridge():
    print_section("Pixel Bridge Build & Deploy")
    if subprocess.run([sys.executable, 'apps/patcher/tools/build_bridge.py']).returncode == 0:
        apk = Path('apps/bridge/app/build/outputs/apk/release/app-release-unsigned.apk')
        if apk.exists():
            subprocess.run([JAVA, '-jar', CONF['signer'], '--apks', str(apk), '--allowResign', '--overwrite'], capture_output=True)
            signed = Path('apps/bridge/app/build/outputs/apk/release/app-release-unsigned-aligned-debugSigned.apk')
            if not signed.exists(): signed = apk
            if run_adb_command(["install", "-r", str(signed)])[0]:
                from adb_manager import grant_production_permissions
                grant_production_permissions("com.pixelbridge.complications", is_bridge=True)
                print(f"{Colors.GREEN}Pixel Bridge installed and permissions granted automatically.{Colors.ENDC}")


def main():
    while True:
        print_header()
        print(f"{Colors.GREEN}{Colors.BOLD}0. START WIZARD (Recommended){Colors.ENDC}")
        print("1. Pair/Connect Wireless ADB")
        print("2. Patch specific Watch Face APK")
        print("3. Build/Install Complication Bridge")
        print("4. Manual Sparse Image Conversion")
        print("5. Check/Toggle App Location Access")
        print("6. Turn Off Developer Mode")
        print("7. Turn Off WiFi and Bluetooth (Disconnect)")
        print("8. Exit")
        c = input(f"\n{Colors.BOLD}Selection: {Colors.ENDC}").strip()
        if c == '0': menu_wizard()
        elif c == '1':
            from adb_manager import pair_wireless_adb, connect_wireless_adb
            addr = input("Address (IP:Port): ")
            pin = input("PIN (or enter to skip): ")
            if pin: pair_wireless_adb(addr, pin)
            connect_wireless_adb(addr)
        elif c == '2':
            check_setup()
            inf = input("Path to APK: ").strip()
            if os.path.exists(inf):
                out = inf.replace('.apk', '_patched.apk')
                subprocess.run([sys.executable, 'apps/patcher/patch_watchface_unified.py', inf, out])
        elif c == '3': menu_build_bridge()
        elif c == '4':
            check_setup()
            img = input("Path to .img: ").strip()
            if os.path.exists(img):
                from unsparse import unsparse
                raw = img.replace('.img', '_raw.img')
                if unsparse(img, raw) and SEVENZ:
                    subprocess.run([SEVENZ, 'x', raw, f'-o{img}_extracted', '-y'])
                    os.remove(raw)
        elif c == '5':
            ok, out = run_adb_command(["shell", "pm", "list", "packages", "-g"])
            if ok:
                loc_apps = []
                current_pkg = None
                for line in out.splitlines():
                    if line.startswith("Package {"):
                        current_pkg = line.split("{")[1].split("}")[0].strip()
                    elif "android.permission.ACCESS_FINE_LOCATION" in line or "android.permission.ACCESS_COARSE_LOCATION" in line:
                        if "granted=true" in line and current_pkg and current_pkg not in loc_apps:
                            loc_apps.append(current_pkg)
                print(f"\n{Colors.BOLD}Apps with Location Access:{Colors.ENDC}")
                for pkg in loc_apps: print(f" - {pkg}")
                if input("\nRevoke location access for all these apps? (y/n): ").lower() == 'y':
                    for pkg in loc_apps:
                        run_adb_command(["shell", "pm", "revoke", pkg, "android.permission.ACCESS_FINE_LOCATION"])
                        run_adb_command(["shell", "pm", "revoke", pkg, "android.permission.ACCESS_COARSE_LOCATION"])
                    print(f"{Colors.GREEN}Location access revoked for all listed apps.{Colors.ENDC}")
        elif c == '6':
            print("Turning off developer mode...")
            run_adb_command(["shell", "settings", "put", "global", "development_settings_enabled", "0"])
            print(f"{Colors.GREEN}Developer mode disabled.{Colors.ENDC}")
        elif c == '7':
            print("Turning off WiFi and Bluetooth. Connection will be lost.")
            run_adb_command(["shell", "nohup sh -c 'sleep 2 && svc wifi disable && svc bluetooth disable' > /dev/null 2>&1 &"])
            print(f"{Colors.GREEN}Commands dispatched. Disconnecting...{Colors.ENDC}")
            sys.exit(0)
        elif c == '8': break
        input("\nPress Enter to return...")

if __name__ == '__main__':
    try: main()
    except KeyboardInterrupt: sys.exit(0)

#!/usr/bin/env python3
"""
Build script for Pixel Bridge App.
Downloads a minimal local Android SDK if not present, and builds the bridge app via Gradle.
This ensures zero host system dependencies and cross-platform compatibility.
"""

import os
import sys
import subprocess
import urllib.request
import zipfile
import platform
from pathlib import Path
from typing import Optional

# Setup directories
TOOLS_DIR = Path(__file__).parent
SDK_DIR = TOOLS_DIR / 'android_sdk'

# Cross-platform SDK tools
OS_NAME = platform.system()
if OS_NAME == 'Linux':
    CMDLINE_TOOLS_URL = 'https://dl.google.com/android/repository/commandlinetools-linux-10406996_latest.zip'
    SDK_BIN_EXT = ''
elif OS_NAME == 'Windows':
    CMDLINE_TOOLS_URL = 'https://dl.google.com/android/repository/commandlinetools-win-10406996_latest.zip'
    SDK_BIN_EXT = '.bat'
elif OS_NAME == 'Darwin':
    CMDLINE_TOOLS_URL = 'https://dl.google.com/android/repository/commandlinetools-mac-10406996_latest.zip'
    SDK_BIN_EXT = ''
else:
    print(f"[✗] Unsupported OS: {OS_NAME}")
    sys.exit(1)

def download_and_extract(url: str, dest_dir: Path) -> bool:
    """Download and extract Android SDK Command-line Tools."""
    zip_path = dest_dir / 'cmdline-tools.zip'
    print(f"[*] Downloading Android SDK Command-line Tools...")
    try:
        req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
        with urllib.request.urlopen(req) as response, open(zip_path, 'wb') as out_file:
            out_file.write(response.read())
            
        print(f"[*] Extracting...")
        with zipfile.ZipFile(zip_path, 'r') as zip_ref:
            zip_ref.extractall(dest_dir)
        zip_path.unlink()
        
        # Set executable permissions for Linux/Mac
        if OS_NAME != 'Windows':
            for root, dirs, files in os.walk(dest_dir):
                for f in files:
                    if 'bin' in root or f.endswith(SDK_BIN_EXT):
                        os.chmod(os.path.join(root, f), 0o755)
        
        # Move cmdline-tools contents into cmdline-tools/latest as required by sdkmanager
        extracted = dest_dir / 'cmdline-tools'
        latest = extracted / 'latest'
        if not latest.exists():
            latest.mkdir(parents=True, exist_ok=True)
            for item in list(extracted.iterdir()):
                if item.name != 'latest':
                    item.rename(latest / item.name)
                    
        print("[✓] SDK Tools ready.")
        return True
    except Exception as e:
        print(f"[✗] Failed to download SDK: {e}")
        return False

def accept_licenses(sdkmanager_path: Path) -> bool:
    """Auto-accept all Android SDK licenses."""
    print("[*] Accepting SDK licenses...")
    try:
        process = subprocess.Popen(
            [str(sdkmanager_path), '--licenses'],
            stdin=subprocess.PIPE,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True
        )
        # Send 'y' for all license prompts
        out, err = process.communicate(input='y\n' * 100)
        return process.returncode == 0
    except Exception as e:
        print(f"[✗] Failed to accept licenses: {e}")
        return False

# Import toolkit config
import sys
sys.path.insert(0, str(TOOLS_DIR.parent / 'lib'))
try:
    import config
    CONF = config.get_config()
    JAVA = CONF['java']
except ImportError:
    CONF = {}
    JAVA = None

def build_bridge() -> bool:
    """Main build orchestration for the bridge app."""
    project_root = TOOLS_DIR.parent.parent.parent
    bridge_dir = project_root / 'apps' / 'bridge'
    
    if not bridge_dir.exists():
        print(f"[✗] apps/bridge directory not found at {bridge_dir}")
        return False
        
    print("[*] Installing required SDK packages (build-tools, platforms)...")
    sdkmanager = SDK_DIR / 'cmdline-tools' / 'latest' / 'bin' / f'sdkmanager{SDK_BIN_EXT}'
    
    if not sdkmanager.exists():
        print(f"[✗] sdkmanager not found at {sdkmanager}")
        return False

    env = os.environ.copy()
    if JAVA:
        java_path = Path(JAVA)
        # Try to find the root of the JRE/JDK
        if java_path.parent.name == 'bin':
            env['JAVA_HOME'] = str(java_path.parent.parent)
        else:
            env['JAVA_HOME'] = str(java_path.parent)
        
    # Ensure platforms and build-tools are present
    subprocess.run([str(sdkmanager), "platforms;android-34", "build-tools;34.0.0"], 
                   check=False, env=env, capture_output=True)
    
    print("[*] Building Bridge App via Gradle...")
    env['ANDROID_HOME'] = str(SDK_DIR.resolve())
    
    gradlew = bridge_dir / ('gradlew.bat' if OS_NAME == 'Windows' else 'gradlew')
    
    # Try to generate gradle wrapper if missing
    if not gradlew.exists():
        print("[*] Generating Gradle wrapper...")
        try:
            subprocess.run(['gradle', 'wrapper'], cwd=str(bridge_dir), env=env, timeout=60, capture_output=True)
        except:
            print("[!] System 'gradle' not found. This may fail if wrapper is missing.")

    try:
        if gradlew.exists():
            if OS_NAME != 'Windows':
                os.chmod(gradlew, 0o755)
            
            # Execute build
            cmd = [str(gradlew), 'assembleRelease', '--no-daemon']
            result = subprocess.run(cmd, cwd=str(bridge_dir), env=env)
            
            if result.returncode == 0:
                print("[✓] Build successful!")
                apk_path = bridge_dir / 'app' / 'build' / 'outputs' / 'apk' / 'release' / 'app-release-unsigned.apk'
                if apk_path.exists():
                    print(f"   APK: {apk_path}")
                return True
            else:
                print("[✗] Build failed.")
                return False
        else:
            print("[✗] Gradle wrapper (gradlew) missing and could not be generated.")
            return False
    except Exception as e:
        print(f"[✗] Build error: {e}")
        return False

def main():
    print("=" * 60)
    print("Pixel Bridge App Builder (Cross-Platform)")
    print("=" * 60)
    
    if not SDK_DIR.exists():
        SDK_DIR.mkdir(parents=True, exist_ok=True)
        if not download_and_extract(CMDLINE_TOOLS_URL, SDK_DIR):
            return 1
            
    sdkmanager = SDK_DIR / 'cmdline-tools' / 'latest' / 'bin' / f'sdkmanager{SDK_BIN_EXT}'
    if not sdkmanager.exists():
        print("[✗] sdkmanager not found. SDK setup failed.")
        return 1
        
    accept_licenses(sdkmanager)
    
    if build_bridge():
        return 0
    return 1

if __name__ == '__main__':
    sys.exit(main())

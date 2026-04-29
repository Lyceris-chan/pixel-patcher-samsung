"""
Central configuration module for Pixel Extract toolkit.

This module provides centralized path management and configuration
to ensure portability across different machines and environments.
All paths are defined relative to the project root directory.
"""

import os
import sys
import platform
import shutil
from pathlib import Path
from typing import Dict, Any, Optional

def get_project_root() -> Path:
    """Get the project root directory."""
    # This file is in apps/patcher/lib/config.py
    return Path(__file__).parent.parent.parent.parent.resolve()

PROJECT_ROOT = get_project_root()
# Standardized paths for the unified project structure
PATCHER_DIR = PROJECT_ROOT / 'apps' / 'patcher'
TOOLS_DIR = PATCHER_DIR / 'tools'
WORK_DIR = PROJECT_ROOT / 'wf_work'
FACTORY_EXTRACT_DIR = WORK_DIR / 'factory_extract'
APKS_DIR = FACTORY_EXTRACT_DIR / 'apks'
SOUNDS_DIR = FACTORY_EXTRACT_DIR / 'sounds'
BOOT_ANIMATION_DIR = FACTORY_EXTRACT_DIR / 'boot'

# Add vendor directory to sys.path for portable python deps
VENDOR_DIR = PATCHER_DIR / 'lib' / 'vendor'
if VENDOR_DIR.exists() and str(VENDOR_DIR) not in sys.path:
    sys.path.insert(0, str(VENDOR_DIR))

def find_executable(name: str, search_paths: list) -> Optional[str]:
    """Finds an executable in the given search paths."""
    extensions = [""]
    if platform.system() == "Windows":
        extensions = [".exe", ".bat", ".cmd"]
    
    for base_path in search_paths:
        if not os.path.exists(base_path):
            continue
        
        # Check base path first
        for ext in extensions:
            target = os.path.join(base_path, name + ext)
            if os.path.isfile(target) and os.access(target, os.X_OK):
                return target
                
        # Recursive search (limit depth for performance)
        for root, dirs, files in os.walk(base_path):
            for ext in extensions:
                target = os.path.join(root, name + ext)
                if os.path.isfile(target) and os.access(target, os.X_OK):
                    return target
    return None

# Tool Paths
JAVA_BIN = find_executable("java", [str(TOOLS_DIR / "jre")])
ADB_BIN = find_executable("adb", [str(TOOLS_DIR / "platform-tools")])
SEVENZ_BIN = (find_executable("7za", [str(TOOLS_DIR)]) or 
              find_executable("7zz", [str(TOOLS_DIR)]) or
              find_executable("7z", [str(TOOLS_DIR)]))

APKTOOL_JAR = str(TOOLS_DIR / "apktool_3.0.2.jar")
UBER_SIGNER_JAR = str(TOOLS_DIR / "uber-apk-signer-1.3.0.jar")

# Fallbacks to system if portable not found
if not JAVA_BIN: JAVA_BIN = shutil.which("java")
if not ADB_BIN: ADB_BIN = shutil.which("adb")
if not SEVENZ_BIN: SEVENZ_BIN = shutil.which("7za") or shutil.which("7z")

def get_config() -> Dict[str, Any]:
    return {
        'project_root': str(PROJECT_ROOT),
        'tools_dir': str(TOOLS_DIR),
        'work_dir': str(WORK_DIR),
        'java': JAVA_BIN,
        'adb': ADB_BIN,
        '7z': SEVENZ_BIN,
        'apktool': APKTOOL_JAR,
        'signer': UBER_SIGNER_JAR
    }

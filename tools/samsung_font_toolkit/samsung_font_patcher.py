#!/usr/bin/env python3
"""
Samsung Font Patcher for Wear OS
-------------------------------
Packages a standard .ttf font into a Samsung-compatible FlipFont APK.
This script automates the spoofing of the com.monotype.android.font.samsungsans 
package ID to bypass signature restrictions on Galaxy Watches.

Usage:
    python3 samsung_font_patcher.py <input.ttf> <output.apk> "[Font Display Name]"
"""

import os
import sys
import shutil
import subprocess
import argparse
from pathlib import Path

# --- Configuration & Path Setup ---
SCRIPT_DIR = Path(__file__).parent.absolute()
TEMPLATE_DIR = SCRIPT_DIR / 'samsung_sans_template'
WORK_DIR = SCRIPT_DIR / '.patcher_work'

# Project-wide configuration integration
try:
    project_root = SCRIPT_DIR.parent.resolve()
    sys.path.insert(0, str(project_root / 'apps' / 'patcher'))
    from lib.config import get_config
    CONFIG = get_config()
except ImportError:
    # Standalone fallback if project structure is missing
    CONFIG = {
        'java': 'java',
        'apktool': 'apktool',
        'signer': 'uber-apk-signer'
    }

def log(msg, level="INFO"):
    prefix = f"[{level}]"
    print(f"{prefix:7} {msg}")

def run_cmd(cmd, description):
    """Executes a shell command and handles errors."""
    try:
        subprocess.run(cmd, check=True, capture_output=True, text=True)
    except subprocess.CalledProcessError as e:
        log(f"Failed during {description}:", "ERROR")
        if e.stderr: print(e.stderr)
        sys.exit(1)
    except FileNotFoundError as e:
        log(f"Required tool not found: {e.filename}. Ensure Java and Apktool are in PATH.", "ERROR")
        sys.exit(1)

def validate_environment():
    """Checks if the template and required tools are available."""
    if not TEMPLATE_DIR.exists():
        log(f"Template directory missing at {TEMPLATE_DIR}", "ERROR")
        sys.exit(1)
    
    # Check for apktool jar if we have a path for it
    if 'apktool' in CONFIG and str(CONFIG['apktool']).endswith('.jar'):
        if not Path(CONFIG['apktool']).exists():
            log(f"Apktool JAR not found at {CONFIG['apktool']}", "ERROR")
            sys.exit(1)

def patch_font(input_ttf, output_apk, font_name):
    """Main patching logic."""
    validate_environment()
    
    # 1. Prepare working directory
    if WORK_DIR.exists():
        shutil.rmtree(WORK_DIR)
    shutil.copytree(TEMPLATE_DIR, WORK_DIR)
    
    log(f"Packaging font: {input_ttf}")
    
    # 2. Inject Font File
    target_ttf = WORK_DIR / 'assets' / 'fonts' / 'Samsungsans.ttf'
    shutil.copy2(input_ttf, target_ttf)
    
    # 3. Patch XML Configuration (Display Name)
    xml_path = WORK_DIR / 'assets' / 'xml' / 'Samsungsans.xml'
    if xml_path.exists():
        content = xml_path.read_text()
        content = content.replace('displayname="Samsung sans"', f'displayname="{font_name}"')
        xml_path.write_text(content)
        
    # 4. Patch strings.xml (App Name/List Label)
    strings_path = WORK_DIR / 'res' / 'values' / 'strings.xml'
    if strings_path.exists():
        content = strings_path.read_text()
        # Handle both the template default and potential previous patches
        import re
        content = re.sub(r'<string name="app_name">.*?</string>', 
                        f'<string name="app_name">{font_name}</string>', 
                        content)
        strings_path.write_text(content)

    # 5. Build the APK
    unsigned_apk = SCRIPT_DIR / '_unsigned_tmp.apk'
    apktool_cmd = [CONFIG['java'], '-jar', CONFIG['apktool']] if str(CONFIG['apktool']).endswith('.jar') else [CONFIG['apktool']]
    run_cmd(apktool_cmd + ['b', str(WORK_DIR), '-o', str(unsigned_apk)], "building APK")
    
    # 6. Sign and Align the APK
    signer_cmd = [CONFIG['java'], '-jar', CONFIG['signer']] if str(CONFIG['signer']).endswith('.jar') else [CONFIG['signer']]
    run_cmd(signer_cmd + ['--apks', str(unsigned_apk), '--out', str(SCRIPT_DIR)], "signing APK")
    
    # 7. Finalize output
    # uber-apk-signer pattern: <input>-aligned-debugSigned.apk
    signed_apk = SCRIPT_DIR / '_unsigned_tmp-aligned-debugSigned.apk'
    if signed_apk.exists():
        shutil.move(signed_apk, output_apk)
        if unsigned_apk.exists(): os.remove(unsigned_apk)
        log(f"Successfully created: {output_apk}", "SUCCESS")
    else:
        log("Signed APK was not found in expected location.", "ERROR")
        sys.exit(1)

    # Cleanup
    if WORK_DIR.exists(): shutil.rmtree(WORK_DIR)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Samsung Wear OS Font Patcher")
    parser.add_argument("input", help="Input .ttf font file")
    parser.add_argument("output", help="Output .apk file path")
    parser.add_argument("name", help="Display name for the font in settings")
    
    args = parser.parse_args()
    
    patch_font(args.input, args.output, args.name)

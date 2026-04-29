"""Module for patching and injecting custom fonts on Wear OS.

This module automates the spoofing of the com.monotype.android.font.samsungsans
package ID to bypass signature restrictions on Galaxy Watches using the
zfont method. It also handles the installation and configuration of the
Pixel Watch keyboard.
"""

import logging
import os
import re
import shutil
import subprocess
from pathlib import Path
from typing import Optional

from lib import config
from lib import adb_manager


def _run_command(cmd: list[str], description: str) -> bool:
    """Executes a shell command and logs errors.

    Args:
        cmd: A list of strings representing the command.
        description: A short description for logging purposes.

    Returns:
        True if the command succeeded, False otherwise.
    """
    try:
        subprocess.run(
            cmd,
            check=True,
            capture_output=True,
            text=True
        )
        return True
    except subprocess.CalledProcessError as e:
        logging.error("Failed during %s: %s", description, e.stderr)
        return False
    except FileNotFoundError as e:
        logging.error("Required tool not found for %s: %s", description, e)
        return False


def patch_font(
    input_ttf: str,
    output_apk: str,
    font_name: str = "Google Sans"
) -> bool:
    """Packages a TTF font into a Samsung-compatible FlipFont APK.

    Args:
        input_ttf: Path to the input .ttf font file.
        output_apk: Path where the generated APK should be saved.
        font_name: Display name for the font in watch settings.

    Returns:
        True if the patching was successful, False otherwise.
    """
    conf = config.get_config()
    project_root = Path(conf['project_root'])
    
    template_dir = project_root / 'tools' / 'samsung_font_toolkit' / 'samsung_sans_template'
    work_dir = project_root / 'wf_work' / '.font_patcher_work'

    if not template_dir.exists():
        logging.error("Template directory missing at %s", template_dir)
        return False

    java_bin = conf.get('java', 'java')
    apktool = conf.get('apktool', 'apktool')
    signer = conf.get('signer', 'uber-apk-signer')

    if work_dir.exists():
        shutil.rmtree(work_dir)
    shutil.copytree(template_dir, work_dir)

    logging.info("Packaging font: %s", input_ttf)

    target_ttf = work_dir / 'assets' / 'fonts' / 'Samsungsans.ttf'
    target_ttf.parent.mkdir(parents=True, exist_ok=True)
    try:
        shutil.copy2(input_ttf, target_ttf)
    except FileNotFoundError:
        logging.error("Input font not found: %s", input_ttf)
        return False

    xml_path = work_dir / 'assets' / 'xml' / 'Samsungsans.xml'
    if xml_path.exists():
        content = xml_path.read_text(encoding='utf-8')
        content = content.replace(
            'displayname="Samsung sans"',
            f'displayname="{font_name}"'
        )
        xml_path.write_text(content, encoding='utf-8')

    strings_path = work_dir / 'res' / 'values' / 'strings.xml'
    if strings_path.exists():
        content = strings_path.read_text(encoding='utf-8')
        content = re.sub(
            r'<string name="app_name">.*?</string>',
            f'<string name="app_name">{font_name}</string>',
            content
        )
        strings_path.write_text(content, encoding='utf-8')

    unsigned_apk = project_root / 'wf_work' / '_unsigned_font_tmp.apk'
    unsigned_apk.parent.mkdir(parents=True, exist_ok=True)
    
    apktool_cmd = [str(java_bin), '-jar', str(apktool)] if str(apktool).endswith('.jar') else [str(apktool)]
    
    if not _run_command(apktool_cmd + ['b', str(work_dir), '-o', str(unsigned_apk)], "building APK"):
        return False

    signer_cmd = [str(java_bin), '-jar', str(signer)] if str(signer).endswith('.jar') else [str(signer)]
    
    if not _run_command(signer_cmd + ['--apks', str(unsigned_apk), '--out', str(project_root / 'wf_work')], "signing APK"):
        return False

    signed_apk = project_root / 'wf_work' / '_unsigned_font_tmp-aligned-debugSigned.apk'
    if signed_apk.exists():
        os.makedirs(os.path.dirname(output_apk), exist_ok=True)
        shutil.move(str(signed_apk), output_apk)
        if unsigned_apk.exists():
            os.remove(unsigned_apk)
        logging.info("Successfully created font APK: %s", output_apk)
    else:
        logging.error("Signed APK was not found in expected location.")
        return False

    if work_dir.exists():
        shutil.rmtree(work_dir)

    return True


def setup_pixel_keyboard(keyboard_apk: str) -> bool:
    """Installs the Pixel Watch keyboard and sets it as the default input method.

    Args:
        keyboard_apk: Path to the Pixel Watch keyboard APK file.

    Returns:
        True if installation and configuration succeeded, False otherwise.
    """
    logging.info("Setting up Pixel Watch keyboard from %s", keyboard_apk)
    
    if not os.path.exists(keyboard_apk):
        logging.error("Keyboard APK not found at %s", keyboard_apk)
        return False

    if not adb_manager.check_adb_connection():
        logging.error("No device connected via ADB to setup keyboard.")
        return False

    if not adb_manager.install_apk(keyboard_apk, reinstall=True):
        logging.error("Failed to install keyboard APK.")
        return False

    # The standard package and service name for Google Keyboard (Gboard)
    ime_service = "com.google.android.inputmethod.latin/com.android.inputmethod.latin.LatinIME"

    # Enable the IME
    rc_enable, _, stderr_enable = adb_manager.run_adb_command(["shell", "ime", "enable", ime_service])
    if rc_enable != 0:
        logging.error("Failed to enable IME: %s", stderr_enable)
        return False

    # Set as default
    rc_set, _, stderr_set = adb_manager.run_adb_command(["shell", "ime", "set", ime_service])
    if rc_set != 0:
        logging.error("Failed to set default IME: %s", stderr_set)
        return False

    logging.info("Successfully installed and set Pixel Watch keyboard as default.")
    return True

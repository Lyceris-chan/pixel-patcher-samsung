"""Module for extracting Pixel Watch factory images.

This module orchestrates the extraction of Android sparse images and
resource files from a Pixel Watch factory image ZIP archive using 7-Zip
and simg2img. It strictly adheres to the Google Python Style Guide.
"""

import glob
import logging
import os
import shutil
import subprocess
from pathlib import Path
from typing import Optional

from lib import config


def _get_tool_path(tool_name: str) -> Optional[str]:
    """Finds the path to a required external tool.

    Args:
        tool_name: The name of the executable (e.g., '7z', 'simg2img').

    Returns:
        The absolute path to the tool, or None if not found.
    """
    conf = config.get_config()

    if tool_name == '7z' and conf.get('7z'):
        return str(conf['7z'])

    path = shutil.which(tool_name)
    if not path and tool_name == 'simg2img':
        # Check tools dir just in case
        tools_dir = Path(conf.get('tools_dir', ''))
        simg2img_path = tools_dir / 'simg2img'
        if simg2img_path.exists() and os.access(simg2img_path, os.X_OK):
            return str(simg2img_path)

    return path


def extract_factory_image(zip_path: str, extract_dir: str) -> bool:
    """Extracts a Pixel Watch factory image.

    Extracts the main archive, finds the nested image ZIP, extracts it,
    unsparses the system.img using simg2img, and finally extracts the
    raw system image.

    Args:
        zip_path: Path to the downloaded factory image ZIP file.
        extract_dir: Directory where the contents should be extracted.

    Returns:
        True if the extraction was successful, False otherwise.
    """
    seven_z = _get_tool_path('7z')
    simg2img = _get_tool_path('simg2img')

    if not seven_z:
        logging.error("Required tool '7z' not found.")
        return False
    if not simg2img:
        logging.error("Required tool 'simg2img' not found.")
        return False

    os.makedirs(extract_dir, exist_ok=True)
    extract_path = Path(extract_dir)

    logging.info("Extracting main factory image zip...")
    try:
        subprocess.run(
            [seven_z, 'x', str(zip_path), f'-o{extract_dir}', '-y'],
            check=True,
            capture_output=True,
            text=True
        )
    except subprocess.CalledProcessError as e:
        logging.error("Failed to extract main factory image: %s", e.stderr)
        return False

    nested_zips = list(extract_path.glob("**/image-*.zip"))
    if not nested_zips:
        logging.error("No nested image-*.zip found in factory image.")
        return False

    nested_zip = nested_zips[0]
    logging.info("Extracting nested image zip: %s", nested_zip.name)
    try:
        subprocess.run(
            [seven_z, 'x', str(nested_zip), f'-o{extract_dir}', '-y'],
            check=True,
            capture_output=True,
            text=True
        )
    except subprocess.CalledProcessError as e:
        logging.error("Failed to extract nested image zip: %s", e.stderr)
        return False

    system_img_path = extract_path / "system.img"
    if not system_img_path.exists():
        logging.error("system.img not found after extraction.")
        return False

    system_raw_path = extract_path / "system_raw.img"
    logging.info("Unsparsing system.img to %s...", system_raw_path.name)
    try:
        subprocess.run(
            [simg2img, str(system_img_path), str(system_raw_path)],
            check=True,
            capture_output=True,
            text=True
        )
    except subprocess.CalledProcessError as e:
        logging.error("simg2img failed: %s", e.stderr)
        return False

    system_extract_dir = extract_path / "system"
    os.makedirs(system_extract_dir, exist_ok=True)

    logging.info("Extracting raw system image...")
    try:
        subprocess.run(
            [seven_z, 'x', str(system_raw_path), f'-o{system_extract_dir}', '-y'],
            check=True,
            capture_output=True,
            text=True
        )
    except subprocess.CalledProcessError as e:
        logging.error("Failed to extract raw system image: %s", e.stderr)
        return False

    logging.info("Factory image extraction complete.")
    return True

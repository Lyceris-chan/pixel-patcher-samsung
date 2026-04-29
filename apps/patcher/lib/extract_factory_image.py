"""
Factory image extraction module for Pixel Extract toolkit.

This module orchestrates the extraction of APKs, sounds, and other 
resources from Pixel Watch factory images using portable tools 
(7-Zip) and pure-Python unsparsing.
"""

import os
import sys
import shutil
import glob
import subprocess
import zipfile
from typing import Optional, List

# Ensure project root is in path
sys.path.append(os.path.dirname(os.path.abspath(__file__)))
import config
import unsparse

def get_7z_path() -> Optional[str]:
    """Get the path to the bundled 7-Zip binary from config."""
    conf = config.get_config()
    p7z = conf.get('7z')
    if p7z and os.path.exists(p7z):
        return p7z
    
    # Final check for system '7z' or '7za' if config didn't find it as an absolute path
    # though config.py already does this. If config.py returned '7z' as a string 
    # (though it shouldn't), shutil.which will confirm it.
    return shutil.which("7z") or shutil.which("7za")

def run_7z_extract(archive_path: str, output_dir: str, filter_pattern: Optional[str] = None) -> bool:
    """
    Extract files from an archive using 7-Zip.
    """
    p7z = get_7z_path()
    if not p7z:
        print("[✗] 7-Zip binary not found. Please run setup.")
        return False
    
    cmd = [p7z, "x", archive_path, f"-o{output_dir}", "-y"]
    if filter_pattern:
        cmd.append(filter_pattern)
        cmd.append("-r")
        
    try:
        result = subprocess.run(cmd, capture_output=True, text=True)
        if result.returncode == 0:
            return True
        else:
            print(f"7-Zip error (RC {result.returncode}): {result.stderr}")
            return False
    except Exception as e:
        print(f"Error running 7-Zip ({p7z}): {e}")
        return False

def extract_from_zip(zip_path: str, extract_dir: str) -> bool:
    """Extract ZIP using 7-Zip for speed, with zipfile as fallback."""
    print(f"[*] Extracting {os.path.basename(zip_path)}...")
    
    # Try 7-Zip first as it's significantly faster for large factory images
    if run_7z_extract(zip_path, extract_dir):
        return True
        
    print("[!] 7-Zip extraction failed or not found, falling back to standard zipfile (slower)...")
    try:
        with zipfile.ZipFile(zip_path, 'r') as zip_ref:
            zip_ref.extractall(extract_dir)
        return True
    except Exception as e:
        print(f"[✗] Error extracting ZIP: {e}")
        return False

def process_factory_image(factory_zip_path: str) -> bool:
    """
    Complete extraction workflow for a factory image.
    
    Args:
        factory_zip_path: Path to the downloaded factory image ZIP
        
    Returns:
        bool: True if successful
    """
    # 1. Unzip factory image to get image-*.zip
    extract_base = config.FACTORY_EXTRACT_DIR
    os.makedirs(extract_base, exist_ok=True)
    os.makedirs(config.APKS_DIR, exist_ok=True)
    os.makedirs(config.SOUNDS_DIR, exist_ok=True)
    
    print(f"Extracting factory image ZIP...")
    if not extract_from_zip(factory_zip_path, str(extract_base)):
        return False
        
    # Find nested image zip
    image_zips = glob.glob(os.path.join(str(extract_base), "**/image-*.zip"), recursive=True)
    if not image_zips:
        print("Error: Could not find nested image ZIP in factory archive.")
        return False
    
    image_zip = image_zips[0]
    image_extract_dir = os.path.join(str(extract_base), "images")
    os.makedirs(image_extract_dir, exist_ok=True)
    
    print(f"Extracting partition images from {os.path.basename(image_zip)}...")
    if not extract_from_zip(image_zip, image_extract_dir):
        return False
        
    # 2. Process system.img and product.img
    partitions = ["system", "product"]
    for part in partitions:
        img_path = os.path.join(image_extract_dir, f"{part}.img")
        if not os.path.exists(img_path):
            continue
            
        raw_img = os.path.join(image_extract_dir, f"{part}_raw.img")
        
        # Unsparse if needed
        if not unsparse.unsparse(img_path, raw_img):
            # If unsparse fails, it might be raw already
            print(f"Warning: Could not unsparse {part}.img, attempting direct extraction...")
            raw_img = img_path
            
        # 3. Extract resources from raw image
        print(f"Extracting resources from {part} partition...")
        
        # Extract APKs
        run_7z_extract(raw_img, str(config.APKS_DIR), "*.apk")
        
        # Extract Sounds (from system)
        if part == "system":
            run_7z_extract(raw_img, str(config.SOUNDS_DIR), "*.ogg")
            run_7z_extract(raw_img, str(config.BOOT_ANIMATION_DIR), "bootanimation*.zip")

    print("\n✅ Factory image extraction complete!")
    return True

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: extract_factory_image.py <factory_zip>")
    else:
        process_factory_image(sys.argv[1])

"""
Default Complication Configuration Patcher.

This module automates the redirection of default watch face complications from 
Google Pixel providers to our custom Pixel Bridge service or 
original system defaults. This ensures a seamless "out-of-the-box" experience 
for the end-user.

Key Strategy:
    Natively supported metrics (Steps, Heart Rate) are re-routed to the 
    Pixel Bridge app. Complex session-based metrics (Sleep, Calories) are 
    retained as system defaults to ensure stability and compatibility.
"""

import os
import re
from typing import Dict, List, Optional, Tuple


# Complication provider mappings: Pixel Component → Bridge/System Component
PROVIDER_MAPPINGS = {
    # Step Count (Bridged via Health Services API)
    'com.google.android.apps.fitness/.complications.StepCountComplicationProviderService': 
        'com.pixelbridge.complications/.StepsComplicationService',
    
    # Heart Rate (Bridged via Health Services API)
    'com.google.android.apps.fitness/.complications.HeartRateComplicationProviderService':
        'com.pixelbridge.complications/.HeartRateComplicationService',

    # Distance (Bridged via Health Services API)
    'com.google.android.apps.fitness/.complications.DistanceComplicationProviderService':
        'com.pixelbridge.complications/.DistanceComplicationService',

    # Calories (Bridged via Health Services API)
    'com.google.android.apps.fitness/.complications.CaloriesComplicationProviderService':
        'com.pixelbridge.complications/.CaloriesComplicationService',

    # Floors (Bridged via Health Services API)
    'com.google.android.apps.fitness/.complications.FloorsComplicationProviderService':
        'com.pixelbridge.complications/.FloorsComplicationService',

    # Active Minutes (Bridged via Health Services API)
    'com.google.android.apps.fitness/.complications.ActiveMinutesComplicationProviderService':
        'com.pixelbridge.complications/.ActiveMinutesComplicationService',

    # Elevation (Bridged)
    'com.google.android.apps.fitness/.complications.ElevationComplicationProviderService':
        'com.pixelbridge.complications/.ElevationComplicationService',

    # HRV (Bridged)
    'com.google.android.apps.fitness/.complications.HRVComplicationProviderService':
        'com.pixelbridge.complications/.HRVComplicationService',

    # Respiratory Rate (Bridged)
    'com.google.android.apps.fitness/.complications.RespiratoryRateComplicationProviderService':
        'com.pixelbridge.complications/.RespiratoryRateComplicationService',
    
    # Note: Sleep and SpO2 are bridged if the watchface uses them.
    'com.google.android.apps.wearable.settings/.complications.SleepComplicationProviderService':
        'com.pixelbridge.complications/.SleepComplicationService',
    
    'com.google.android.apps.wearable.settings/.complications.SpO2ComplicationProviderService':
        'com.pixelbridge.complications/.SpO2ComplicationService',
}


def patch_default_complications(apktool_dir: str) -> Tuple[bool, List[str]]:
    """
    Identifies and redirects default complication configurations.
    
    Args:
        apktool_dir: Path to the decompiled APK source directory.
        
    Returns:
        A tuple containing the success status and a list of modified file paths.
    """
    patched_files = []
    
    # Process XML resource definitions
    xml_dir = os.path.join(apktool_dir, 'res', 'xml')
    if os.path.exists(xml_dir):
        xml_files = [os.path.join(xml_dir, f) for f in os.listdir(xml_dir) if f.endswith('.xml')]
        for xml_file in xml_files:
            if _apply_xml_patch(xml_file):
                patched_files.append(xml_file)
    
    # Process hardcoded Smali string declarations
    for root, _, files in os.walk(apktool_dir):
        if 'smali' not in root: continue
        for filename in files:
            if filename.endswith('.smali'):
                filepath = os.path.join(root, filename)
                if _apply_smali_patch(filepath):
                    patched_files.append(filepath)
    
    return len(patched_files) > 0, patched_files


def _apply_xml_patch(xml_file: str) -> bool:
    """Applies string replacement to XML configuration files."""
    try:
        with open(xml_file, 'r', encoding='utf-8') as f:
            content = f.read()
        
        original_content = content
        for pixel_comp, target_comp in PROVIDER_MAPPINGS.items():
            content = content.replace(pixel_comp, target_comp)
        
        if content != original_content:
            with open(xml_file, 'w', encoding='utf-8') as f:
                f.write(content)
            return True
        return False
    except Exception:
        return False


def _apply_smali_patch(smali_file: str) -> bool:
    """Applies regex-based component redirection to Smali bytecode source."""
    try:
        with open(smali_file, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Optimization: Only process files that mention known Pixel providers
        if 'com.google.android.apps.fitness' not in content and \
           'com.google.android.apps.wearable.settings' not in content:
            return False

        original_content = content
        for pixel_comp, target_comp in PROVIDER_MAPPINGS.items():
            # Match const-string declarations containing the component name
            pattern = f'const-string[^"]*"({re.escape(pixel_comp)})"'
            content = re.sub(pattern, f'const-string "{target_comp}"', content)
        
        if content != original_content:
            with open(smali_file, 'w', encoding='utf-8') as f:
                f.write(content)
            return True
        return False
    except Exception:
        return False


def main() -> None:
    """Entry point for standalone execution and verification."""
    import sys
    if len(sys.argv) < 2:
        print("Usage: python default_complication_patcher.py <apktool_dir>")
        return
    
    apktool_dir = sys.argv[1]
    print(f"[*] Analyzing complication configurations in: {apktool_dir}")
    
    success, patched = patch_default_complications(apktool_dir)
    if success:
        print(f"[✓] Successfully redirected {len(patched)} configuration points.")
    else:
        print("[i] No compatible default complications found for re-routing.")

if __name__ == '__main__':
    main()

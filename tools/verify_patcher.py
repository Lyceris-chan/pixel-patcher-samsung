import sys
import os
from pathlib import Path

# Add paths
sys.path.insert(0, os.path.join(os.getcwd(), 'apps', 'patcher'))
sys.path.insert(0, os.path.join(os.getcwd(), 'apps', 'patcher', 'lib'))

import patch_watchface_unified
import config

def verify():
    print("Testing Patching Logic on existing decoded directory...")
    apktool_dir = os.path.join(os.getcwd(), 'wf_work', 'unified_patch', 'apktool')
    
    if not os.path.exists(apktool_dir):
        print(f"Error: {apktool_dir} not found.")
        return
    
    # Run the patching logic
    # apply_all_patches(apktool_dir)
    success = patch_watchface_unified.apply_all_patches(apktool_dir)
    
    if success:
        print("\n[✓] Patching logic executed successfully on decoded directory.")
    else:
        print("\n[✗] Patching logic failed.")

if __name__ == "__main__":
    verify()

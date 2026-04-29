"""
Watchface Configuration Patcher

Fixes the lateinit property initialization crash by patching the configuration
access methods to return safe defaults when the property is not initialized.

This addresses the crash:
  E WatchFaceService: fye: lateinit property watchFaceConfiguration has not been initialized
"""

import os
import re
from pathlib import Path
from typing import List, Tuple


def patch_watchface_configuration_access(content: str) -> str:
    """
    Patch the H() method in ekr.smali to return early instead of crashing
    when watchFaceConfiguration is not initialized.
    
    Original code throws an exception if the property is null.
    Patched code returns early (no-op) if the property is null.
    """
    # Pattern to match the H() method that accesses watchFaceConfiguration
    pattern = r'(\.method public final H\(\)V\s+\.locals \d+\s+\.line \d+\s+iget-object p0, p0, Lekr;->q:Lfst;\s+\.line \d+\s+\.line \d+\s+if-nez p0, :cond_0\s+\.line \d+\s+const-string p0, "watchFaceConfiguration"\s+\.line \d+\s+invoke-static \{p0\}, Lgce;->b\(Ljava/lang/String;\)V)'
    
    # Replacement: Return early if null instead of throwing exception
    replacement = r'''.method public final H()V
    .locals 0

    .line 1
    iget-object p0, p0, Lekr;->q:Lfst;

    .line 2
    .line 3
    if-nez p0, :cond_0

    .line 4
    # Patched: Return early instead of throwing exception
    return-void

    .line 5
    :cond_0'''
    
    modified = re.sub(pattern, replacement, content, flags=re.DOTALL)
    
    if modified != content:
        print("  ✅ Patched H() method to handle null watchFaceConfiguration")
        return modified
    
    # Fallback: Simple pattern matching for the method
    lines = content.split('\n')
    in_h_method = False
    modified_lines = []
    i = 0
    
    while i < len(lines):
        line = lines[i]
        
        # Detect start of H() method
        if '.method public final H()V' in line:
            in_h_method = True
            modified_lines.append(line)
            i += 1
            continue
        
        # Inside H() method, look for the exception throw
        if in_h_method and 'invoke-static {p0}, Lgce;->b(Ljava/lang/String;)V' in line:
            # Replace the exception throw with return-void
            modified_lines.append('    return-void  # Patched: Return early instead of throwing exception')
            # Skip the next line (const/4 p0, 0x0)
            i += 2
            in_h_method = False
            print("  ✅ Patched H() method to handle null watchFaceConfiguration (fallback)")
            continue
        
        # Detect end of method
        if in_h_method and '.end method' in line:
            in_h_method = False
        
        modified_lines.append(line)
        i += 1
    
    return '\n'.join(modified_lines)


def patch_other_lateinit_properties(content: str) -> str:
    """
    Patch other lateinit property access methods (J, G, O) to handle null gracefully.
    """
    modified = content
    
    # List of methods that access lateinit properties
    methods_to_patch = [
        ('J', 'koruTranslatorConfiguration', 'p'),
        ('G', 'offloadLogger', 'r'),
        ('O', 'healthLogger', 'l'),
    ]
    
    for method_name, prop_name, field_name in methods_to_patch:
        # Pattern to find the method and replace exception throw with return-void
        pattern = rf'(\.method public final {method_name}\(\)[^\n]+\s+\.locals \d+[^{{]+iget-object p0, p0, Lekr;->{field_name}:Lfst;[^{{]+if-[^{{]+:cond_0[^{{]+const-string p0, "{prop_name}"[^{{]+invoke-static \{{p0\}}, Lgce;->b\(Ljava/lang/String;\)V[^{{]+const/4 p0, 0x0)'
        
        # This is complex, so let's use line-by-line approach
        lines = modified.split('\n')
        in_target_method = False
        modified_lines = []
        i = 0
        
        while i < len(lines):
            line = lines[i]
            
            # Detect start of target method
            if f'.method public final {method_name}()' in line:
                in_target_method = True
                modified_lines.append(line)
                i += 1
                continue
            
            # Inside target method, look for the exception throw
            if in_target_method and f'const-string p0, "{prop_name}"' in line:
                # Look ahead for the exception throw
                if i + 2 < len(lines) and 'invoke-static {p0}, Lgce;->b(Ljava/lang/String;)V' in lines[i + 2]:
                    # Skip the const-string and blank lines
                    i += 1
                    while i < len(lines) and (lines[i].strip() == '' or lines[i].strip().startswith('.line')):
                        i += 1
                    # Replace the invoke-static with return-void
                    if i < len(lines) and 'invoke-static {p0}, Lgce;->b(Ljava/lang/String;)V' in lines[i]:
                        modified_lines.append('    return-void  # Patched: Return early for null ' + prop_name)
                        i += 1
                        # Skip const/4 p0, 0x0
                        if i < len(lines) and 'const/4 p0, 0x0' in lines[i]:
                            i += 1
                        in_target_method = False
                        print(f"  ✅ Patched {method_name}() method to handle null {prop_name}")
                        continue
            
            # Detect end of method
            if in_target_method and '.end method' in line:
                in_target_method = False
            
            modified_lines.append(line)
            i += 1
        
        modified = '\n'.join(modified_lines)
    
    return modified


def find_smali_file_containing(decoded_dir: Path, pattern: str) -> List[Path]:
    """Find smali files containing a specific string or regex pattern."""
    matches = []
    for smali_dir in decoded_dir.glob("smali*"):
        for path in smali_dir.rglob("*.smali"):
            try:
                if pattern in path.read_text(encoding='utf-8', errors='ignore'):
                    matches.append(path)
            except:
                continue
    return matches


def patch_ekr_class(decoded_dir: Path) -> bool:
    """
    Find and patch the class containing watchFaceConfiguration (formerly ekr.smali).
    """
    target_files = find_smali_file_containing(decoded_dir, "watchFaceConfiguration")
    
    if not target_files:
        print("  ⚠️ No class containing 'watchFaceConfiguration' found - skipping patch")
        return False
    
    success = False
    for target_path in target_files:
        print(f"\n{'='*60}")
        print(f"Patching Watchface Configuration in {target_path.name}")
        print(f"{'='*60}")
        
        content = target_path.read_text(encoding='utf-8')
        original_content = content
        
        # Apply patches
        content = patch_watchface_configuration_access(content)
        content = patch_other_lateinit_properties(content)
        
        if content != original_content:
            target_path.write_text(content, encoding='utf-8')
            print(f"✅ Successfully patched {target_path.name}")
            success = True
            
    return success


def patch_csb_versioned_bulb_provider(decoded_dir: Path) -> bool:
    """
    Find and patch the class containing versionedBulbProvider (formerly csb.smali).
    """
    target_files = find_smali_file_containing(decoded_dir, "versionedBulbProvider")
    
    if not target_files:
        print("  ⚠️ No class containing 'versionedBulbProvider' found - skipping patch")
        return True
    
    for target_path in target_files:
        print(f"\n{'='*60}")
        print(f"Patching Versioned Bulb Provider in {target_path.name}")
        print(f"{'='*60}")
        
        content = target_path.read_text(encoding='utf-8')
        original_content = content
        
        lines = content.split('\n')
        modified_lines = []
        i = 0
        
        while i < len(lines):
            line = lines[i]
            if 'const-string v0, "versionedBulbProvider"' in line:
                if i + 4 < len(lines) and 'invoke-static {v0}, Lgce;->b(Ljava/lang/String;)V' in lines[i + 4]:
                    modified_lines.append(line)
                    i += 1
                    while i < len(lines) and (lines[i].strip() == '' or lines[i].strip().startswith('.line')):
                        modified_lines.append(lines[i])
                        i += 1
                    if i < len(lines) and 'invoke-static {v0}, Lgce;->b(Ljava/lang/String;)V' in lines[i]:
                        modified_lines.append('    return-void  # Patched: Return early for null versionedBulbProvider')
                        i += 1
                        if i < len(lines) and 'move-object v0, v1' in lines[i]:
                            i += 1
                        print(f"  ✅ Patched versionedBulbProvider in {target_path.name}")
                        continue
            modified_lines.append(line)
            i += 1
        
        new_content = '\n'.join(modified_lines)
        if new_content != original_content:
            target_path.write_text(new_content, encoding='utf-8')
            print(f"✅ Successfully patched {target_path.name}")
            
    return True


def patch_charging_animation(decoded_dir: Path) -> bool:
    """Placeholder for charging animation patch."""
    print("  ℹ️ Charging animation patch (placeholder) - No changes applied")
    return True

if __name__ == "__main__":
    # Test with decoded APK directory
    import sys
    if len(sys.argv) > 1:
        decoded_dir = Path(sys.argv[1])
        patch_ekr_class(decoded_dir)
        patch_csb_versioned_bulb_provider(decoded_dir)
        patch_charging_animation(decoded_dir)
    else:
        print("Usage: python watchface_config_patcher.py <decoded_apk_dir>")

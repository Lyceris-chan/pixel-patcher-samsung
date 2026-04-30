# Samsung Wear OS Font Toolkit

A production-grade toolkit for packaging and installing custom `.ttf` fonts on Samsung Galaxy Watches.

This toolkit was reverse-engineered from the zFont methodology to provide clean, PC-based automation for Wear OS users without the need for complex companion apps.

## 🚀 The Workflow

1.  **Generate:** Package your `.ttf` into a spoofed APK using the patcher.
2.  **Sideload:** Install the generated APK via ADB.
3.  **Apply:** Go to **Settings > Display > Font style** on your watch.
4.  **Result:** Your custom font will gracefully appear in the list under the assigned name (e.g. "Google Sans"). Note that deeply nested sub-menus might reference "Samsung Sans" due to the spoofed package ID, but the visual rendering applies globally.

---

## 🛠️ Usage

This toolkit is normally called by the main wizard, but can be invoked manually:

```bash
python3 samsung_font_patcher.py <input_font.ttf> <output_name.apk> "[Font Display Name]"
```

**Example:**
```bash
python3 samsung_font_patcher.py Wear-GoogleSans.ttf googlesans.apk "Google Sans"
```

---

## 🔍 Technical Details

This toolkit seamlessly bypasses standard font signature checks by spoofing the official `com.monotype.android.font.samsungsans` package. Samsung Wear OS intrinsically trusts this package ID as a system-level font provider.

### Internal Mechanics
- **Spoofing:** Uses a decompressed Samsung Sans APK as a skeleton.
- **Injection:** Replaces the internal `Samsungsans.ttf` with your custom font binary.
- **Metadata Patching:** Surgically updates the XML configurations (`Samsungsans.xml` and `strings.xml`) to project your custom font name into the system settings.
- **Signing:** The final APK is zipalign-optimized and signed using an Uber-APK-Signer debug key, which is fully trusted by Wear OS for this spoofed package.

---
*Developed for the Pixel Watch Toolkit Project.*
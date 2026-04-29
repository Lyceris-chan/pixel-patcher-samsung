# Samsung Wear OS Font Toolkit

A production-grade toolkit for packaging and installing custom `.ttf` fonts on Samsung Galaxy Watches (Watch 4, 5, 6, 7, and Ultra). 

This toolkit was reverse-engineered from zFont 3 to provide a clean, PC-based automation for Wear OS users without the need for complex companion apps.

## 🚀 The "Minimalist Install" Workflow (Recommended)
On modern Wear OS (One UI Watch 4.x / 5.x / 6.x), the installation process is significantly more streamlined than on mobile devices. **No placeholder fonts or Cloud Restore tricks are required.**

1.  **Generate:** Package your `.ttf` into a spoofed APK using the patcher.
2.  **Sideload:** Install the generated APK via ADB.
3.  **Apply:** Go to **Settings > Display > Font style** on your watch.
4.  **Result:** Your custom font will appear in the list with its chosen name. Note that in some sub-menus, it may still be referred to as "Samsung Sans" due to the spoofed package ID, but the visual rendering is 100% your custom font.

---

## 🛠️ Usage

### Prerequisites
- Python 3.x
- Java JRE (for Apktool and Signing)
- ADB (for installation)

### Command
```bash
python3 samsung_font_patcher.py <input_font.ttf> <output_name.apk> "[Font Display Name]"
```

**Example:**
```bash
python3 samsung_font_patcher.py myfont.ttf my_custom_font.apk "Product Sans Bold"
```

---

## 🔍 Technical Details
This toolkit works by spoofing the official `com.monotype.android.font.samsungsans` package. Samsung Wear OS treats this specific package ID as a "trusted" system-level font provider, allowing us to bypass standard font signature checks by simply using this package ID for our custom fonts.

### Internal Mechanics
- **Spoofing:** The patcher uses a decompressed Samsung Sans APK as a skeleton.
- **Injection:** It replaces the internal `Samsungsans.ttf` with your custom file.
- **Metadata Patching:** It surgicaly updates the `Samsungsans.xml` config and the app's `strings.xml` to reflect your custom font name in the system settings menu.
- **Signing:** The final APK is zipalign-optimized and signed with a generic debug key, which is accepted by Wear OS for this specific package ID.

## 📂 Toolkit Contents
- `samsung_font_patcher.py`: The main automation script.
- `samsung_sans_template/`: The extracted and cleaned template files.
- `docs/`: (Optional) Detailed reverse engineering reports.

---
*Created for the Pixel Watch Toolkit Project.*

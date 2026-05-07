# Pixel Watch Toolkit

**Unified toolkit for patching Pixel watch resources and bridging health complications on Wear OS devices.**

This mono-repo provides an automated pipeline to adapt Pixel watch resources for compatible Wear OS targets. It covers APK patching, complication/tiles bridging, factory image extraction, and Samsung FlipFont (zFont-style) packaging support.

## Scope and support statement

- The project is designed to be **device-generic**.
- Validation so far has been performed primarily on **Samsung Galaxy Watch 5 Pro (SM-R925F)** running **One UI Watch 6 / Wear OS 4**.
- Other devices/firmware may require additional compatibility testing.

## Core features

- Automated patching workflow for watchface APK behavior fixes.
- Wear OS bridge app for complications + tiles health data publication.
- Factory image extraction helpers and app/resource inventory utilities.
- Samsung Sans / FlipFont-compatible zFont packaging flow.
- Permission helper artifacts for post-install app enablement.

## Current limitations

> ⚠️ Not all user-facing apps extracted from factory images are guaranteed to function on every target watch/firmware combination. Some apps depend on proprietary services, signing, privileged permissions, or OEM-only frameworks.

## Repository layout

```text
.
├── apps/
│   ├── patcher/
│   └── bridge/
├── docs/
├── factory_resources/
│   └── permissions/
└── tools/
```

## Quick start

```bash
python3 main.py
```

## Bridge build check

```bash
cd apps/bridge
./gradlew --no-daemon clean assembleDebug
```

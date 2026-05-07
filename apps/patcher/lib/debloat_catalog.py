"""Documented package catalog for the debloat subsystem.

This module is intentionally data-only so UI layers and CLI commands can import
and render package documentation without loading ADB logic.
"""

from typing import Dict

DEBLOAT_PACKAGE_CATALOG: Dict[str, Dict[str, str]] = {
    "com.google.android.wearable.sysui": {
        "category": "Core system",
        "rationale": "Critical Wear OS UI package; protected from modifications.",
    },
    "com.samsung.android.watch.watchface.superhero": {
        "category": "Core watchface",
        "rationale": "Known-safe default watch face used for migration recovery.",
    },
    "com.android.systemui": {
        "category": "Core system",
        "rationale": "Critical Android UI process; protected from modifications.",
    },
    "android": {
        "category": "Core framework",
        "rationale": "Android framework package; protected from modifications.",
    },
    "com.google.android.gms": {
        "category": "Core services",
        "rationale": "Google Play services dependency for many watch features.",
    },
    "com.android.vending": {
        "category": "Store services",
        "rationale": "Play Store package; required for app installs and updates.",
    },
}

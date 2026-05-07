"""Extended package dictionary for watch debloat planning.

The catalog is intentionally conservative: entries include package purpose,
risk level, and user-visible impact to help users make informed decisions.
"""

from typing import Dict

DEBLOAT_PACKAGE_RISKS: Dict[str, Dict[str, str]] = {
    "android": {
        "category": "core-framework",
        "description": "Android framework package used by all apps and services.",
        "risk": "critical",
        "impact_if_removed": "Device instability or boot failure.",
        "recommendation": "Never remove.",
        "settings_impacted": "All Settings surfaces indirectly depend on this package.",
    },
    "com.android.systemui": {
        "category": "core-system-ui",
        "description": "System UI process for status bar, dialogs, and shell UI.",
        "risk": "critical",
        "impact_if_removed": "Boot loops or unusable interface.",
        "recommendation": "Never remove.",
        "settings_impacted": "Display, notifications, quick settings, and system dialogs.",
    },
    "com.google.android.wearable.sysui": {
        "category": "wear-shell",
        "description": "Wear OS shell/UI package for watch interaction surfaces.",
        "risk": "critical",
        "impact_if_removed": "Watch UI may fail to start.",
        "recommendation": "Never remove.",
        "settings_impacted": "Watch home, tiles launcher, and Settings entry points can fail.",
    },
    "com.google.android.gms": {
        "category": "google-services",
        "description": "Google Play services required by many watch apps and APIs.",
        "risk": "high",
        "impact_if_removed": "Pairing, sync, auth, and fitness features may break.",
        "recommendation": "Keep unless building fully de-Googled setup.",
        "settings_impacted": "Google account, permissions mediation, and app-linked settings."
    },
    "com.android.vending": {
        "category": "store",
        "description": "Google Play Store on watch.",
        "risk": "medium",
        "impact_if_removed": "No on-watch app install/update via Play Store.",
        "recommendation": "Keep for mainstream users.",
        "settings_impacted": "Store/update settings and app-management flows."
    },
    "com.samsung.android.watch.watchface.superhero": {
        "category": "fallback-watchface",
        "description": "Known-safe stock watch face for migration fallback.",
        "risk": "medium",
        "impact_if_removed": "Fewer recovery options if patched face fails.",
        "recommendation": "Keep as rescue face.",
        "settings_impacted": "Watchface selection fallback in Settings may be reduced."
    },
    "com.samsung.android.wearable.app": {
        "category": "wearable-manager",
        "description": "Samsung wearable companion hooks and control surfaces.",
        "risk": "high",
        "impact_if_removed": "Pairing and wearable management may fail.",
        "recommendation": "Do not remove unless replaced by tested alternatives.",
        "settings_impacted": "Device pairing, notifications routing, and wearable companion settings."
    },
    "com.samsung.android.shealth": {
        "category": "health",
        "description": "Samsung Health companion package for health feature integration.",
        "risk": "medium",
        "impact_if_removed": "Health sync and app launches from complications may fail.",
        "recommendation": "Keep if using health complications.",
        "settings_impacted": "Health permissions, goals, and complication-provider settings.",
    },
    "com.samsung.android.watch.bixby": {
        "category": "assistant",
        "description": "Bixby assistant integration on watch.",
        "risk": "low",
        "impact_if_removed": "Voice assistant features unavailable.",
        "recommendation": "Optional removal if assistant not needed.",
        "settings_impacted": "Assistant/voice settings pages will be unavailable.",
    },
    "com.google.android.apps.maps": {
        "category": "navigation",
        "description": "Google Maps watch client.",
        "risk": "low",
        "impact_if_removed": "Navigation on watch unavailable.",
        "recommendation": "Optional.",
        "settings_impacted": "Navigation shortcuts in settings/tiles may stop working.",
    },
    "com.spotify.music": {
        "category": "media",
        "description": "Spotify watch client.",
        "risk": "low",
        "impact_if_removed": "Spotify playback/offline control unavailable.",
        "recommendation": "Optional.",
        "settings_impacted": "Media controls/source shortcuts may be unavailable.",
    },
    "com.samsung.android.watchface": {
        "category": "watchface-engine",
        "description": "Samsung watchface runtime components.",
        "risk": "high",
        "impact_if_removed": "Watchface rendering/selection can break.",
        "recommendation": "Keep.",
        "settings_impacted": "Watchface settings and customization pages.",
    },
    "com.samsung.android.biometrics.app.setting": {
        "category": "security",
        "description": "Biometric settings module.",
        "risk": "medium",
        "impact_if_removed": "PIN/biometric settings features may degrade.",
        "recommendation": "Keep unless unused and tested.",
        "settings_impacted": "Security and lockscreen settings.",
    },
    "com.google.android.apps.walletnfcrel": {
        "category": "payments",
        "description": "Google Wallet / tap-to-pay watch client.",
        "risk": "low",
        "impact_if_removed": "NFC payments unavailable.",
        "recommendation": "Optional if payments unused.",
        "settings_impacted": "Payment defaults and NFC payment settings.",
    },
    "com.google.android.apps.assistant": {
        "category": "assistant",
        "description": "Google Assistant client and intents.",
        "risk": "low",
        "impact_if_removed": "Assistant actions unavailable.",
        "recommendation": "Optional.",
        "settings_impacted": "Assistant preferences and voice settings.",
    },
    "com.google.android.apps.messaging": {
        "category": "communications",
        "description": "Google Messages companion app.",
        "risk": "low",
        "impact_if_removed": "On-watch message UI unavailable.",
        "recommendation": "Optional.",
        "settings_impacted": "Messaging shortcuts/notification actions.",
    },
    "com.google.android.apps.fitness": {
        "category": "fitness",
        "description": "Fitbit/Fitness app package used by many stock complications.",
        "risk": "medium",
        "impact_if_removed": "Stock fitness complications and history may disappear.",
        "recommendation": "Keep unless fully bridged and verified.",
        "settings_impacted": "Complication provider lists and fitness account settings.",
    },
    "com.google.android.apps.wearable.settings": {
        "category": "settings",
        "description": "Wearable settings package that hosts some system complication providers.",
        "risk": "critical",
        "impact_if_removed": "Settings app pages and core providers can fail.",
        "recommendation": "Never remove.",
        "settings_impacted": "Large portions of Settings app functionality.",
    },

}

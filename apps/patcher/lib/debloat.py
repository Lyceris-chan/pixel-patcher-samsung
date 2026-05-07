"""Debloating Engine for Pixel Watch Toolkit.

This module provides tools to safely debloat the Samsung Galaxy Watch,
ensuring essential packages are never touched and providing multiple
removal modes: DISABLE, UNINSTALL, and CAGE.
"""

import subprocess
import logging
from typing import List, Dict

from debloat_catalog import DEBLOAT_PACKAGE_CATALOG
from debloat_package_risks import DEBLOAT_PACKAGE_RISKS

logger = logging.getLogger(__name__)

NEVER_TOUCH: List[str] = list(DEBLOAT_PACKAGE_CATALOG.keys())

class DebloatEngine:
    """Handles debloating operations via ADB."""

    def __init__(self, adb_path: str = "adb"):
        self.adb_path = adb_path

    def _run_adb(self, *args: str) -> subprocess.CompletedProcess:
        """Helper to run adb commands."""
        return subprocess.run([self.adb_path, "shell", *args], capture_output=True, text=True)

    def is_protected(self, package_name: str) -> bool:
        """Checks if a package is in the NEVER_TOUCH list."""
        return package_name in NEVER_TOUCH

    def disable_package(self, package_name: str) -> bool:
        """Disables the package without uninstalling."""
        if self.is_protected(package_name):
            logger.warning(f"Cannot disable protected package: {package_name}")
            return False
        res = self._run_adb("pm", "disable-user", "--user", "0", package_name)
        return res.returncode == 0

    def uninstall_package(self, package_name: str) -> bool:
        """Uninstalls the package for the current user."""
        if self.is_protected(package_name):
            logger.warning(f"Cannot uninstall protected package: {package_name}")
            return False
        res = self._run_adb("pm", "uninstall", "-k", "--user", "0", package_name)
        return res.returncode == 0

    def cage_package(self, package_name: str) -> bool:
        """Cages the package using appops and netpolicy to prevent it from running in background."""
        if self.is_protected(package_name):
            logger.warning(f"Cannot cage protected package: {package_name}")
            return False
        res1 = self._run_adb("appops", "set", package_name, "RUN_IN_BACKGROUND", "ignore")
        res2 = self._run_adb("cmd", "netpolicy", "add", "restrict-background-whitelist", package_name)
        # Note: In real scenarios, restricting background might involve other commands.
        return res1.returncode == 0 and res2.returncode == 0

    def run_migration_fixup(self) -> None:
        """Handles users coming from older debloat versions by restoring key apps."""
        logger.info("Running Migration Fixup for older debloat versions...")
        # Re-enable standard apps that were previously removed by older, aggressive scripts
        previously_removed = [
            "com.samsung.android.watch.watchface.superhero"
        ]
        for pkg in previously_removed:
            self._run_adb("cmd", "package", "install-existing", pkg)
        logger.info("Migration Fixup complete.")

    def list_documented_packages(self) -> List[Dict[str, str]]:
        """Returns documented debloat packages as a stable, sorted list."""
        return [
            {"package": package_name, **metadata}
            for package_name, metadata in sorted(DEBLOAT_PACKAGE_CATALOG.items())
        ]


    def list_package_risks(self) -> List[Dict[str, str]]:
        """Returns extended debloat package risk dictionary as a sorted list."""
        return [
            {"package": package_name, **metadata}
            for package_name, metadata in sorted(DEBLOAT_PACKAGE_RISKS.items())
        ]


    def get_removal_risk(self, package_name: str) -> Dict[str, str]:
        """Gets risk metadata for a package, including settings impact guidance."""
        data = DEBLOAT_PACKAGE_RISKS.get(package_name)
        if data is None:
            return {
                "package": package_name,
                "risk": "unknown",
                "impact_if_removed": "Not documented. Treat as high risk until verified.",
                "settings_impacted": "Unknown settings impact.",
                "recommendation": "Research before removal.",
            }
        return {"package": package_name, **data}


    def explain_caging(self) -> Dict[str, str]:
        """Explains what caging means and when to prefer it over uninstall."""
        return {
            "definition": "Caging restricts background execution/network policy instead of removing APK files.",
            "commands": "appops RUN_IN_BACKGROUND ignore + netpolicy restrict background whitelist management",
            "benefit": "Lower risk and easier rollback compared with uninstall.",
            "tradeoff": "App remains installed and may still consume storage.",
        }

    def suggest_cage_candidates(self) -> List[str]:
        """Returns low-risk candidates commonly suited for caging before uninstall."""
        return [
            "com.spotify.music",
            "com.google.android.apps.maps",
            "com.google.android.apps.assistant",
            "com.google.android.apps.messaging",
            "com.samsung.android.watch.bixby",
        ]

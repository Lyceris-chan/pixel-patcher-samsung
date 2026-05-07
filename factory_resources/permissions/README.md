# Local Permission Artifacts

This directory stores app-permission manifests generated from factory image analysis and/or device validation runs.

## Purpose

- Keep a local, versioned permission source used by install scripts.
- Ensure required grants (for example notification access for alarm/clock flows) are reproducible.

## Suggested files

- `packages.csv`: package inventory from factory image.
- `runtime_permissions.json`: runtime grants by package.
- `appops.json`: app-ops state snapshots.
- `grant_script.sh`: deterministic `adb shell pm grant` / `appops set` script.

## Important warning

Not all user-facing applications from a factory image will work when sideloaded. Keep compatibility notes in this directory when failures are observed.

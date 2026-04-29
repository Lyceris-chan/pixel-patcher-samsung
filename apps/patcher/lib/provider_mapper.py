"""
Provider mapping module for Samsung Health complication substitution.

This module provides mappings between Pixel Watch complication providers
and Samsung Health complication providers. It enables runtime provider
substitution so that Samsung Health providers are automatically used as
defaults when the watchface is installed on a Samsung device.

The module maps complication types (Steps, Heart Rate, Calories, Sleep, etc.)
to their corresponding Samsung Health provider component names.

Dependencies:
    - typing: Type hints support

Usage:
    from provider_mapper import get_samsung_provider, PROVIDER_MAPPINGS
    
    samsung_provider = get_samsung_provider("STEP_COUNT")
    if samsung_provider:
        print(f"Samsung provider: {samsung_provider}")

Requirements Addressed:
    - Runtime provider substitution for Samsung Health complications
    - Automatic default provider configuration on Samsung devices
    - Seamless user experience without manual configuration
"""

from typing import Dict, Optional, List, Tuple


# Pixel Watch default complication provider component names
# These are the providers used by default on Pixel Watch devices
PIXEL_PROVIDERS: Dict[str, str] = {
    "STEP_COUNT": "com.google.android.apps.fitness/com.google.android.apps.fitness.complications.StepCountComplicationProviderService",
    "HEART_RATE": "com.google.android.apps.fitness/com.google.android.apps.fitness.complications.HeartRateComplicationProviderService",
    "CALORIES": "com.google.android.apps.fitness/com.google.android.apps.fitness.complications.CaloriesComplicationProviderService",
    "DISTANCE": "com.google.android.apps.fitness/com.google.android.apps.fitness.complications.DistanceComplicationProviderService",
    "ACTIVE_MINUTES": "com.google.android.apps.fitness/com.google.android.apps.fitness.complications.ActiveMinutesComplicationProviderService",
    "FLOORS": "com.google.android.apps.fitness/com.google.android.apps.fitness.complications.FloorsComplicationProviderService",
    "SLEEP": "com.google.android.apps.wearable.settings/com.google.android.clockwork.settings.complications.SleepComplicationProviderService",
    "BLOOD_OXYGEN": "com.google.android.apps.wearable.settings/com.google.android.clockwork.settings.complications.SpO2ComplicationProviderService",
}


# Samsung Health complication provider component names
# These are the equivalent providers on Samsung Galaxy Watch devices
SAMSUNG_PROVIDERS: Dict[str, str] = {
    "STEP_COUNT": "com.samsung.android.wear.shealth/com.samsung.android.wear.shealth.complications.steps.StepsComplicationProviderService",
    "HEART_RATE": "com.samsung.android.wear.shealth/com.samsung.android.wear.shealth.complications.heartrate.HeartrateComplicationProviderService",
    "CALORIES": "com.samsung.android.wear.shealth/com.samsung.android.wear.shealth.complications.calories.CaloriesComplicationProviderService",
    "DISTANCE": "com.samsung.android.wear.shealth/com.samsung.android.wear.shealth.complications.distance.DistanceComplicationProviderService",
    "ACTIVE_MINUTES": "com.samsung.android.wear.shealth/com.samsung.android.wear.shealth.complications.activetime.ActiveTimeComplicationProviderService",
    "FLOORS": "com.samsung.android.wear.shealth/com.samsung.android.wear.shealth.complications.floors.FloorsComplicationProviderService",
    "SLEEP": "com.samsung.android.wear.shealth/com.samsung.android.wear.shealth.complications.sleep.SleepComplicationProviderService",
    "BLOOD_OXYGEN": "com.samsung.android.wear.shealth/com.samsung.android.wear.shealth.complications.bloodoxygen.BloodOxygenComplicationProviderService",
    "STRESS": "com.samsung.android.wear.shealth/com.samsung.android.wear.shealth.complications.stress.StressComplicationProviderService",
    "WATER": "com.samsung.android.wear.shealth/com.samsung.android.wear.shealth.complications.water.WaterComplicationProviderService",
}


# Provider mapping: Pixel provider → Samsung provider
# This mapping is used for runtime provider substitution
PROVIDER_MAPPINGS: Dict[str, str] = {
    PIXEL_PROVIDERS["STEP_COUNT"]: SAMSUNG_PROVIDERS["STEP_COUNT"],
    PIXEL_PROVIDERS["HEART_RATE"]: SAMSUNG_PROVIDERS["HEART_RATE"],
    PIXEL_PROVIDERS["CALORIES"]: SAMSUNG_PROVIDERS["CALORIES"],
    PIXEL_PROVIDERS["DISTANCE"]: SAMSUNG_PROVIDERS["DISTANCE"],
    PIXEL_PROVIDERS["ACTIVE_MINUTES"]: SAMSUNG_PROVIDERS["ACTIVE_MINUTES"],
    PIXEL_PROVIDERS["FLOORS"]: SAMSUNG_PROVIDERS["FLOORS"],
}


# Complication type to provider mapping
# Maps complication type names to provider component names
COMPLICATION_TYPE_TO_PROVIDER: Dict[str, Tuple[str, str]] = {
    "STEP_COUNT": (PIXEL_PROVIDERS["STEP_COUNT"], SAMSUNG_PROVIDERS["STEP_COUNT"]),
    "HEART_RATE": (PIXEL_PROVIDERS["HEART_RATE"], SAMSUNG_PROVIDERS["HEART_RATE"]),
    "CALORIES": (PIXEL_PROVIDERS["CALORIES"], SAMSUNG_PROVIDERS["CALORIES"]),
    "DISTANCE": (PIXEL_PROVIDERS["DISTANCE"], SAMSUNG_PROVIDERS["DISTANCE"]),
    "ACTIVE_MINUTES": (PIXEL_PROVIDERS["ACTIVE_MINUTES"], SAMSUNG_PROVIDERS["ACTIVE_MINUTES"]),
    "FLOORS": (PIXEL_PROVIDERS["FLOORS"], SAMSUNG_PROVIDERS["FLOORS"]),
    "SLEEP": (PIXEL_PROVIDERS["SLEEP"], SAMSUNG_PROVIDERS["SLEEP"]),
    "BLOOD_OXYGEN": (PIXEL_PROVIDERS["BLOOD_OXYGEN"], SAMSUNG_PROVIDERS["BLOOD_OXYGEN"]),
    "STRESS": (None, SAMSUNG_PROVIDERS["STRESS"]),  # Samsung-only
    "WATER": (None, SAMSUNG_PROVIDERS["WATER"]),  # Samsung-only
}


def get_samsung_provider(complication_type: str) -> Optional[str]:
    """
    Get the Samsung Health provider for a given complication type.
    
    Args:
        complication_type: Type of complication (e.g., "STEP_COUNT", "HEART_RATE")
        
    Returns:
        Optional[str]: Samsung Health provider component name, or None if not found
        
    Example:
        >>> get_samsung_provider("STEP_COUNT")
        'com.samsung.android.wear.shealth/com.samsung.android.wear.shealth.complications.steps.StepsComplicationProviderService'
    """
    return SAMSUNG_PROVIDERS.get(complication_type)


def get_pixel_provider(complication_type: str) -> Optional[str]:
    """
    Get the Pixel Watch provider for a given complication type.
    
    Args:
        complication_type: Type of complication (e.g., "STEP_COUNT", "HEART_RATE")
        
    Returns:
        Optional[str]: Pixel Watch provider component name, or None if not found
        
    Example:
        >>> get_pixel_provider("STEP_COUNT")
        'com.google.android.apps.fitness/com.google.android.apps.fitness.complications.StepCountComplicationProviderService'
    """
    return PIXEL_PROVIDERS.get(complication_type)


def get_provider_mapping(pixel_provider: str) -> Optional[str]:
    """
    Get the Samsung Health provider that corresponds to a Pixel provider.
    
    Args:
        pixel_provider: Pixel Watch provider component name
        
    Returns:
        Optional[str]: Corresponding Samsung Health provider component name,
                      or None if no mapping exists
        
    Example:
        >>> pixel = "com.google.android.apps.fitness/com.google.android.apps.fitness.complications.StepCountComplicationProviderService"
        >>> get_provider_mapping(pixel)
        'com.samsung.android.wear.shealth/com.samsung.android.wear.shealth.complications.steps.StepsComplicationProviderService'
    """
    return PROVIDER_MAPPINGS.get(pixel_provider)


def get_all_mappings() -> List[Tuple[str, str, str]]:
    """
    Get all provider mappings as a list of tuples.
    
    Returns:
        List[Tuple[str, str, str]]: List of (complication_type, pixel_provider, samsung_provider) tuples
        
    Example:
        >>> mappings = get_all_mappings()
        >>> for comp_type, pixel, samsung in mappings:
        ...     print(f"{comp_type}: {pixel} → {samsung}")
    """
    mappings = []
    for comp_type, (pixel, samsung) in COMPLICATION_TYPE_TO_PROVIDER.items():
        if pixel and samsung:  # Only include types with both providers
            mappings.append((comp_type, pixel, samsung))
    return mappings


def is_samsung_provider(provider: str) -> bool:
    """
    Check if a provider component name is a Samsung Health provider.
    
    Args:
        provider: Provider component name to check
        
    Returns:
        bool: True if provider is a Samsung Health provider, False otherwise
        
    Example:
        >>> is_samsung_provider("com.samsung.android.wear.shealth/...")
        True
        >>> is_samsung_provider("com.google.android.apps.fitness/...")
        False
    """
    return provider.startswith("com.samsung.android.wear.shealth/")


def is_pixel_provider(provider: str) -> bool:
    """
    Check if a provider component name is a Pixel Watch provider.
    
    Args:
        provider: Provider component name to check
        
    Returns:
        bool: True if provider is a Pixel Watch provider, False otherwise
        
    Example:
        >>> is_pixel_provider("com.google.android.apps.fitness/...")
        True
        >>> is_pixel_provider("com.samsung.android.wear.shealth/...")
        False
    """
    return provider.startswith("com.google.android.apps.fitness/")


def get_complication_type_from_provider(provider: str) -> Optional[str]:
    """
    Get the complication type from a provider component name.
    
    Args:
        provider: Provider component name (Pixel or Samsung)
        
    Returns:
        Optional[str]: Complication type, or None if provider not recognized
        
    Example:
        >>> provider = "com.samsung.android.wear.shealth/com.samsung.android.wear.shealth.complications.steps.StepsComplicationProviderService"
        >>> get_complication_type_from_provider(provider)
        'STEP_COUNT'
    """
    # Check Pixel providers
    for comp_type, pixel_provider in PIXEL_PROVIDERS.items():
        if provider == pixel_provider:
            return comp_type
    
    # Check Samsung providers
    for comp_type, samsung_provider in SAMSUNG_PROVIDERS.items():
        if provider == samsung_provider:
            return comp_type
    
    return None


def format_provider_for_smali(provider: str) -> str:
    """
    Format a provider component name for use in smali code.
    
    This function converts a provider component name from the format:
        "package/class"
    to the smali format:
        "Lpackage/class;"
    
    Args:
        provider: Provider component name in "package/class" format
        
    Returns:
        str: Provider component name in smali format
        
    Example:
        >>> provider = "com.samsung.android.wear.shealth/com.samsung.android.wear.shealth.complications.steps.StepsComplicationProviderService"
        >>> format_provider_for_smali(provider)
        'Lcom/samsung/android/wear/shealth/com/samsung/android/wear/shealth/complications/steps/StepsComplicationProviderService;'
    """
    # Replace dots with slashes and add L prefix and ; suffix
    smali_format = provider.replace(".", "/")
    return f"L{smali_format};"


def parse_provider_from_smali(smali_provider: str) -> str:
    """
    Parse a provider component name from smali format.
    
    This function converts a provider component name from smali format:
        "Lpackage/class;"
    to the standard format:
        "package/class"
    
    Args:
        smali_provider: Provider component name in smali format
        
    Returns:
        str: Provider component name in standard format
        
    Example:
        >>> smali = "Lcom/samsung/android/wear/shealth/com/samsung/android/wear/shealth/complications/steps/StepsComplicationProviderService;"
        >>> parse_provider_from_smali(smali)
        'com.samsung.android.wear.shealth/com.samsung.android.wear.shealth.complications.steps.StepsComplicationProviderService'
    """
    # Remove L prefix and ; suffix, then replace slashes with dots
    if smali_provider.startswith("L") and smali_provider.endswith(";"):
        smali_provider = smali_provider[1:-1]
    
    # Convert back to standard format (dots instead of slashes)
    return smali_provider.replace("/", ".")


def main() -> None:
    """
    Main function to demonstrate provider mapping functionality.
    
    This function prints all provider mappings and demonstrates the
    various utility functions provided by this module.
    """
    print("=" * 70)
    print("Provider Mapping Module - Samsung Health Complication Substitution")
    print("=" * 70)
    print()
    
    print("Pixel Watch Providers:")
    print("-" * 70)
    for comp_type, provider in PIXEL_PROVIDERS.items():
        print(f"  {comp_type:20s} → {provider}")
    print()
    
    print("Samsung Health Providers:")
    print("-" * 70)
    for comp_type, provider in SAMSUNG_PROVIDERS.items():
        print(f"  {comp_type:20s} → {provider}")
    print()
    
    print("Provider Mappings (Pixel → Samsung):")
    print("-" * 70)
    for comp_type, pixel, samsung in get_all_mappings():
        print(f"  {comp_type}:")
        print(f"    Pixel:   {pixel}")
        print(f"    Samsung: {samsung}")
        print()
    
    print("Example Usage:")
    print("-" * 70)
    
    # Example 1: Get Samsung provider for a complication type
    comp_type = "STEP_COUNT"
    samsung_provider = get_samsung_provider(comp_type)
    print(f"1. Get Samsung provider for {comp_type}:")
    print(f"   {samsung_provider}")
    print()
    
    # Example 2: Get provider mapping
    pixel_provider = PIXEL_PROVIDERS["HEART_RATE"]
    mapped_provider = get_provider_mapping(pixel_provider)
    print(f"2. Map Pixel provider to Samsung provider:")
    print(f"   Pixel:   {pixel_provider}")
    print(f"   Samsung: {mapped_provider}")
    print()
    
    # Example 3: Check provider type
    test_provider = SAMSUNG_PROVIDERS["CALORIES"]
    print(f"3. Check provider type:")
    print(f"   Provider: {test_provider}")
    print(f"   Is Samsung: {is_samsung_provider(test_provider)}")
    print(f"   Is Pixel: {is_pixel_provider(test_provider)}")
    print()
    
    # Example 4: Get complication type from provider
    test_provider = SAMSUNG_PROVIDERS["DISTANCE"]
    comp_type = get_complication_type_from_provider(test_provider)
    print(f"4. Get complication type from provider:")
    print(f"   Provider: {test_provider}")
    print(f"   Type: {comp_type}")
    print()
    
    # Example 5: Format provider for smali
    test_provider = SAMSUNG_PROVIDERS["FLOORS"]
    smali_format = format_provider_for_smali(test_provider)
    print(f"5. Format provider for smali:")
    print(f"   Standard: {test_provider}")
    print(f"   Smali:    {smali_format}")
    print()


if __name__ == "__main__":
    main()

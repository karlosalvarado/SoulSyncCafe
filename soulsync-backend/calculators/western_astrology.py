# calculators/western_astrology.py

from datetime import datetime

def get_sun_sign(birth_date: datetime) -> str:
    """
    Returns the Western zodiac Sun sign based on birth date.
    """
    signs = [
        (1, 20, "Capricorn"), (2, 19, "Aquarius"), (3, 20, "Pisces"),
        (4, 20, "Aries"), (5, 20, "Taurus"), (6, 21, "Gemini"),
        (7, 22, "Cancer"), (8, 23, "Leo"), (9, 23, "Virgo"),
        (10, 23, "Libra"), (11, 22, "Scorpio"), (12, 21, "Sagittarius")
    ]
    month, day = birth_date.month, birth_date.day

    for end_month, end_day, sign in signs:
        if (month == end_month and day <= end_day) or (month < end_month):
            return sign
    return "Capricorn"  # Fallback

# Element mapping for each sign
ELEMENTS = {
    "Aries": "Fire", "Leo": "Fire", "Sagittarius": "Fire",
    "Taurus": "Earth", "Virgo": "Earth", "Capricorn": "Earth",
    "Gemini": "Air", "Libra": "Air", "Aquarius": "Air",
    "Cancer": "Water", "Scorpio": "Water", "Pisces": "Water"
}

def element_compatibility(sign1: str, sign2: str) -> int:
    """
    Returns a compatibility score (0–10) based on elemental harmony.
    """
    elem1 = ELEMENTS.get(sign1)
    elem2 = ELEMENTS.get(sign2)
    if not elem1 or not elem2:
        return 5  # Neutral if unknown

    # Strong compatibility
    if elem1 == elem2:
        return 10
    elif (elem1 == "Fire" and elem2 == "Air") or (elem1 == "Air" and elem2 == "Fire"):
        return 9  # Fire fuels Air
    elif (elem1 == "Water" and elem2 == "Earth") or (elem1 == "Earth" and elem2 == "Water"):
        return 9  # Earth contains Water

    # Clashes
    elif (elem1 == "Fire" and elem2 == "Water") or (elem1 == "Water" and elem2 == "Fire"):
        return 3  # Fire extinguishes Water
    elif (elem1 == "Earth" and elem2 == "Air") or (elem1 == "Air" and elem2 == "Earth"):
        return 3  # Air erodes Earth

    # Neutral
    return 6
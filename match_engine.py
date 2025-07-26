from datetime import datetime
from calculators.western_astrology import get_sun_sign, element_compatibility
from calculators.chinese_zodiac import get_chinese_zodiac, animal_compatibility
from calculators.numerology import get_life_path_number, numerology_compatibility
from calculators.feng_shui import calculate_kua, kua_compatibility

def calculate_compatibility(user1_data: dict, user2_data: dict) -> dict:
    try:
        b1 = datetime.strptime(user1_data['birth_date'], "%Y-%m-%d")
        b2 = datetime.strptime(user2_data['birth_date'], "%Y-%m-%d")

        # 1. Western Astrology (40 pts)
        sun1 = get_sun_sign(b1)
        sun2 = get_sun_sign(b2)
        astro_score = element_compatibility(sun1, sun2) * 4

        # 2. Chinese Zodiac (25 pts)
        animal1, _ = get_chinese_zodiac(b1.year)
        animal2, _ = get_chinese_zodiac(b2.year)
        zodiac_score = animal_compatibility(animal1, animal2) * 2.5

        # 3. Numerology (20 pts)
        lp1 = get_life_path_number(user1_data['birth_date'])
        lp2 = get_life_path_number(user2_data['birth_date'])
        num_score = numerology_compatibility(lp1, lp2) * 2

        # 4. Feng Shui Kua (15 pts)
        kua1, _ = calculate_kua(b1.year, user1_data['gender'])
        kua2, _ = calculate_kua(b2.year, user2_data['gender'])
        feng_score = kua_compatibility(kua1, kua2) * 1.875

        total = round(astro_score + zodiac_score + num_score + feng_score, 1)
        total = min(total, 100)

        insight = generate_insight(sun1, sun2, animal1, animal2, lp1, lp2)

        return {
            "total_score": total,
            "breakdown": {
                "astrology": round(astro_score, 1),
                "chinese_zodiac": round(zodiac_score, 1),
                "numerology": round(num_score, 1),
                "feng_shui": round(feng_score, 1)
            },
            "insight": insight,
            "cosmic_profile": {
                "sun_sign": sun1,
                "chinese_animal": animal1,
                "life_path": lp1,
                "kua_number": kua1
            }
        }
    except Exception as e:
        return {"error": str(e)}

def generate_insight(sun1, sun2, animal1, animal2, lp1, lp2):
    if lp1 == lp2:
        return f"✨ Destiny aligned! Both are Life Path {lp1} — natural growth partners."
    if animal2 in ["Dragon", "Monkey", "Rat"] and animal1 in ["Dragon", "Monkey", "Rat"]:
        return f"🐉🐒🐀 You're part of the powerful Air Trio — dynamic and lucky together!"
    if "Fire" in [sun1, sun2] and "Air" in [sun1, sun2]:
        return "🔥🌬️ Fire fuels Air — your passion lifts their ideas into action!"
    return "Your energies balance like moon and tide."
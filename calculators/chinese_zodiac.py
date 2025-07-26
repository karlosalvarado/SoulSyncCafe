CHINESE_ANIMALS = [
    "Rat", "Ox", "Tiger", "Rabbit", "Dragon", "Snake",
    "Horse", "Goat", "Monkey", "Rooster", "Dog", "Pig"
]

ELEMENTS_CYCLE = ["Wood", "Fire", "Earth", "Metal", "Water"]

def get_chinese_zodiac(year: int) -> tuple:
    animal_idx = (year - 4) % 12
    animal = CHINESE_ANIMALS[animal_idx]
    element_idx = (year - 4) // 2 % 5
    element = ELEMENTS_CYCLE[element_idx]
    return animal, element

COMPATIBILITY_MAP = {
    "Rat": ["Dragon", "Monkey", "Ox"],
    "Ox": ["Snake", "Rooster", "Rat"],
    "Tiger": ["Horse", "Dog", "Rabbit"],
    "Rabbit": ["Goat", "Pig", "Tiger"],
    "Dragon": ["Rat", "Monkey", "Rooster"],
    "Snake": ["Ox", "Rooster", "Dragon"],
    "Horse": ["Tiger", "Dog", "Goat"],
    "Goat": ["Rabbit", "Pig", "Horse"],
    "Monkey": ["Rat", "Dragon", "Snake"],
    "Rooster": ["Ox", "Snake", "Dragon"],
    "Dog": ["Tiger", "Rabbit", "Horse"],
    "Pig": ["Rabbit", "Goat", "Tiger"]
}

def animal_compatibility(animal1: str, animal2: str) -> int:
    if animal2 in COMPATIBILITY_MAP.get(animal1, []):
        return 10
    elif animal2 == animal1:
        return 7
    else:
        return 3
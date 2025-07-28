def reduce_number(num: int) -> int:
    while num > 9 and num not in [11, 22, 33]:
        num = sum(int(digit) for digit in str(num))
    return num if num in [11, 22, 33] else min(num, 9)

def get_life_path_number(birth_date_str: str) -> int:
    date_clean = birth_date_str.replace("-", "")
    total = sum(int(d) for d in date_clean)
    return reduce_number(total)

def name_to_number(name: str) -> int:
    letter_map = {chr(i): (i - ord('A')) % 9 + 1 for i in range(ord('A'), ord('Z')+1)}
    letter_map['S'] = 1; letter_map['T'] = 2; letter_map['U'] = 3
    letter_map['V'] = 4; letter_map['W'] = 5; letter_map['X'] = 6
    letter_map['Y'] = 7; letter_map['Z'] = 8
    total = sum(letter_map.get(char.upper(), 0) for char in name if char.isalpha())
    return reduce_number(total)

def soul_urge_number(name: str) -> int:
    vowels = 'AEIOU'
    vowel_name = ''.join(c for c in name if c.upper() in vowels)
    return name_to_number(vowel_name)

def numerology_compatibility(lp1: int, lp2: int) -> int:
    diff = abs(lp1 - lp2)
    if diff == 0:
        return 10
    elif diff <= 2:
        return 8
    elif diff <= 4:
        return 6
    elif diff <= 6:
        return 4
    else:
        return 2
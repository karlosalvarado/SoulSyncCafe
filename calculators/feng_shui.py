def calculate_kua(birth_year: int, gender: str) -> tuple:
    y = birth_year % 100
    total = sum(int(d) for d in str(y))
    
    if gender.lower() == "female":
        kua = total + 5
    else:
        kua = 10 - total
    
    while kua > 9:
        kua = sum(int(d) for d in str(kua))
    
    group = "East" if kua in [1, 3, 4, 9] else "West"
    return kua, group

def kua_compatibility(kua1: int, kua2: int) -> int:
    east_group = {1, 3, 4, 9}
    west_group = {2, 6, 7, 8}
    
    if (kua1 in east_group and kua2 in east_group) or \
       (kua1 in west_group and kua2 in west_group):
        return 8
    return 4
with open("input") as f:
    lines = f.readlines() + ["\n"]

max_cal = 0
i = 0
while i < len(lines):
    cal = 0
    while x := lines[i].strip():
        cal += int(x)
        i += 1
    if cal > max_cal:
        max_cal = cal
    i += 1

print(max_cal)

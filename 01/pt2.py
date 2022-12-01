with open("input") as f:
    lines = f.readlines() + ["\n"]

top_cal = [0, 0, 0]
i = 0
while i < len(lines):
    cal = 0
    while x := lines[i].strip():
        cal += int(x)
        i += 1
    if cal > top_cal[0]:
        top_cal.pop(0)
        top_cal.insert(0, cal)
        top_cal.sort()
    i += 1

print(sum(top_cal))

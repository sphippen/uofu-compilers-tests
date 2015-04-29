print([a for a in range(10) if y > 3])
print({a for a in range(10) if y % 2})
print(list(sorted(tuple({a : b for a in range(10) if a * 2 < 15 for b in range(3) if b % 2}))))

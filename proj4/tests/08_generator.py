t = (x * 2 for x in range(100))
print(list(tuple(list(t))))

def id(x): return x

maybe_sum = lambda a, b: (a + b) if a > b else b - a

d = (maybe_sum(*id((z, y))) for z in range(100) if z % 2 if z > 5 for y in range(30) if z < y * 2)
print(list(d))

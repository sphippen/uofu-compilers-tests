def id(x): return x

f = lambda x: x + x

print(f(1))
print(id((lambda x: x * x))(1))

def decorator(func):
    return lambda: "decorated!"

@decorator
class A:
    foo = 10

print(A())

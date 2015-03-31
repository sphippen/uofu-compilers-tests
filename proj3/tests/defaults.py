def foo(a = 10, b = 30, *c, quux = "hello"):
    return (a, b, quux)

def tar(a : int = 10, b = 30, *c, quux : foo = "hello"):
    return (a, b, quux)

print(foo())
print(tar())

print(foo(a = "can", b = "forty", quux = "tan"))
print(tar("tang", b = None, quux = "77"))

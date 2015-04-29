import os
from os import path

def id(x): return x

v = 10
v += id(10 + 10)
print("v:", v)

print(id("A"))
print(id(("B",)))
print(id(["C"]))
print(id(b"D"))

class empty:
    pass

e = empty()
e.f = empty()
e.f.g = empty()
e.f.g.X = 2
e.f.g.h = empty()
e.f.g.h.i = empty()
e.f.g.h.i.j = "E"
print(id(e.f.g.h.i.j))

foo = [1,2,3,4]
foo[1:2] = (99,100)
print(id(foo))

foo[(2 // 1) * 2 // 4:id((100 // 10) - 7)] = ["1", "2", "3"]
print(id(foo))

foo[:e.f.g.X] = [1, 2, 3]
print(id(id(id(id(id(foo))))))

foo[0] += 1
print(foo)

BAR = 10

def quux():
    global BAR
    BAR += 10

quux()
print(BAR)

def rax():
    a = 10
    def ducks():
        nonlocal a
        a += id(50)
    ducks()
    print(a)

rax()

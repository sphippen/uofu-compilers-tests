a = [1,2,3]
del a[1+1]

class empty():
    pass

try:
   x = a[2]
   print("Failed 1")
except IndexError:
   print("Passed 1")

b = empty()
b.c = empty()
b.c.e = 1
del b.c.e

try:
    print(b.c.e)
    print("Failed 2")
except AttributeError:
    print("Passed 2")



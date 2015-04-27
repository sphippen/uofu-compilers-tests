def id(x): return x

class foo():

    def __init__(self, num):
        self.num = num

    def __add__(self, what):
        return self.__class__(what(self.num))

class empty():
    pass

f = foo(1)
f += id((lambda x: x + 1))
print(id(id(id(f.num))))

e = empty()
e.a = empty()
e.a.b = empty()
e.a.b.c = foo(10)
e.a.b.c += id(id(id(id((lambda r: id(id(r - 10)))))))
print(e.a.b.c.num)

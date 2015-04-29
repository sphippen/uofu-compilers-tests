class empty:
    pass

class tester:

    def __init__(self, foo):
        self.order = 0
        self._foo = foo

    def foo_get(self):
        self.order += 1
        print("From tester foo get:", self.order)
        return self._foo

    def foo_set(self, x):
        self.order += 1
        print("From tester foo set:", self.order)
        self._foo = x

    foo = property(foo_get, foo_set)

def foo():
    print("From foo")
    return 0

def bar():
    print("From bar")
    return "B"

def print_id(printable, val):
    print(printable)
    return val

x = ["A"]
print(x)
x[foo()] = bar()
print(x)

a = empty()
a.b = empty()
a.b.t = tester("A2")
print(a.b.t._foo)
a.b.t.foo = print_id("Setting B2", "B2")
print(a.b.t._foo)

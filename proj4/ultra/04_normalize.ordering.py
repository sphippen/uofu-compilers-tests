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

def print_id(printable, val):
    print(printable)
    return val

x = ["A"]
print(x)
x[print_id("A1 LHS", 0)] = print_id("A1 RHS", "B")
print(x)

a = empty()
a.b = empty()
a.b.t = tester("A2")
print(a.b.t._foo)
a.b.t.foo = print_id("Setting B2", "B2")
print(a.b.t._foo)

t=[55]
def quux():
    return t
print("A3", t)
print_id("Getting t", quux())[print_id("Setting t LHS", 0)] += print_id("Setting t RHS + 1", 10)
print("B3", t)

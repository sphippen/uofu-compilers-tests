class Foo:
    a = 10
    def test(self): 
        a = 54
        return a
    def metaclass(self):
        return "metaclass!"
    def __dict__(self):
        return "__dict__!"

print(Foo.a)
f = Foo()
print(f.test())
print(f.test())
print(f.metaclass())
print(f.__dict__())

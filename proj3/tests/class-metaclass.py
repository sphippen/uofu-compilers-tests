def fix(d): return list(sorted(d.items()))

def test_meta(name, bases, dict, **kwargs):
    return name, bases, fix(kwargs) 


nargs = (5, 4, 3, 2, 1)
dargs = {"a": 10, "b": 20, "c": 30}
class Bang:
    class Foo(10, 11, *nargs, metaclass=test_meta, other_arg="hello", **dargs):
        pass

print(Bang.Foo)


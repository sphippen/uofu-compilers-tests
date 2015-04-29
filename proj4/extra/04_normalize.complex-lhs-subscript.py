class singleton_list:
    singleton = []

    def __add__(self, rhs):
        self.singleton.extend(rhs)
        return self.singleton

    def __radd__(self, lhs):
        for i in lhs:
            self.singleton.insert(0, i)
        return self.singleton

    def __repr__(self):
        return repr(self.singleton)

    def __setitem__(self, index, value):
        print("Calling setitem!")
        self.singleton[index] = value

a = []
b = [1]
c = singleton_list()

def foo(x): return x

(a + b + c)[0] = foo(1 + 2 + 3)
print(singleton_list.singleton)

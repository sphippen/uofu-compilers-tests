class A:
    def methodA(self): return "A"

class B:
    def methodB(self): return "B"

class C(A, B):
    def methods(self):
        return (self.methodA(), self.methodB())

c = C()
print(c.methods())

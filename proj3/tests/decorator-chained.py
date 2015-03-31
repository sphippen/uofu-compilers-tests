def decoratorA(func):
    def wrapped():
        return "from decorator A!"
    return wrapped

def decoratorB(func):
    def wrapped():
        return "from decorator B!"
    return wrapped

@decoratorB
@decoratorA
def decorated():
    return "from decorated"

print(decorated())

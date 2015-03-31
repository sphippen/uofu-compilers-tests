def gendec(name):
    def decorator(func):
        def wrapped():
            return "from decorator: {}".format(name)
        return wrapped
    return decorator

@gendec("myname!")
def decorated():
    return "from decorated"

print(decorated())

try:
    print("Hello Try")
    raise TypeError("")
    print("after raise")
except AttributeError:
    print("Shouldn't Print")
except:
    print("Caught general except")

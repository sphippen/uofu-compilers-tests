class test_ctxt:
    
    def __init__(self, enter, binding, exit_ok, exit_err):
        self.enter = enter
        self.binding = binding
        self.exit_ok = exit_ok
        self.exit_err = exit_err

    def __enter__(self):
        print(self.enter)
        return self.binding

    def __exit__(self, type, value, traceback):
        print("value:", value)
        if (type is not None) and (value is not None) and (traceback is not None):
            print(self.exit_ok)
        elif (type is None) and (value is None) and (traceback is None):
            print(self.exit_err)
        else:
            raise RuntimeError("__exit__ called with invalid args")
    
with test_ctxt("enter A", "bind A", "exit_ok A", "exit_err A") as foo:
    print(foo)

try:
    with test_ctxt("enter B", "bind B", "exit_ok B", "exit_err B") as foo:
        print(foo)
        raise TypeError("test exn")
        print("after raise")
except BaseException as e:
    print("caught exn:", e)

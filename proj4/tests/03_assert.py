assert True
assert 1 + 1 == 2
assert (lambda: 2 / 1)() == 2
assert True, "Asserting true with message"

try:
    assert False, "Asserting false with message"
except AssertionError:
    print("Assert properly raised")

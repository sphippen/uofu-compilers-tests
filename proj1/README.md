Project 1 Tests
===============

Tests go in the ```tests``` folder.

Each test input must have a ```.py``` extension. If a test input file is supposed to be valid input, there should be a matching ```.out``` file containing the appropriate ```pylex``` output. The ```test.sh``` script assumes that any file without a matching ```.out``` file is supposed to generate an error.

Error test cases are checked via the return code of the ```pylex``` test program - any return other than ```0``` indicates an error.

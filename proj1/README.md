Project 1 Tests
===============

#### Test Script Usage

The provided shell script runs all the tests against a provided binary.
Run it like

```$ test.sh <pathtopylex> <outdiffdir>```

The ```<outdiffdir>``` parameter is a directory where the program's output is written, along with diffs between the expected and actual output.

Error test cases are checked via the return code of the ```<pathtopylex>``` program - any return other than ```0``` indicates an error.

#### Test Cases

Now accepting test cases via pull request.

Test cases go in the ```tests``` folder.

Each test input must have a ```.py``` extension. If a test input file is supposed to be valid input, there should be a matching ```.out``` file containing the appropriate ```pylex``` output. The ```test.sh``` script assumes that any file without a matching ```.out``` file is supposed to generate an error.

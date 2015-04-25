Project 4 Tests
===============

## Usage

One of the provided scripts runs all the tests against a provided binary.
Run it as follows 

    $ ./test-cases <path-to-sxpy> <path-to-pydesugar2> <test-dir>

The reference pylex, pyparse, and sxpy are in the top-level 'ref' directory.
As a shorthand you can run:

    $ ./test-default <path-to-pydesugar2>

Which will automatically use the reference sxpy and the standard test-directory. 
You should be able to run the `test-default` command from any directory.

## Understanding Test-Runner Output

There's more than one right answer to each project 4 test-case, so we can't just
store a list of true output and check them against the output of your program.
Instead, we have to verify two things: 1) That your output matches the semantics
of python and 2) that your output is within the restricted grammar. In the
tester we call 1. the "Pre/Post Output Equivalent" test, and 2. the "In 
Restricted Grammar" test. The tests can be passed and failed independently,
when they fail they will appear red, when the succeed they will appear green.
Details for why the test was failed will appear underneath the test's name.

The "In Restricted Grammar" displays what sections of the desugarer's output
are within the expected output grammer, and outside of the grammar. Lines
that are "OK" will be marked with a green check, lines that are outside
of the grammar will be marked with a red "x".

To evaluate the "Pre/Post Output Equivalent" test we run `python3` on the
original file and save it's output. Then, we run the desugarer on the input
file, convert the ouptut back to python and run `python3` on that file and
collect it's output. If the outputs match, the test succeeds. If the test fails
we display three things: 1) the exit code and stderr output of `python3` when
invoked on the original file, 2) the exit code and stderr ouptut of `python3` when
invoked on the desugared file, and 3) the difference between the stdout of `python3`
invoked on the desugared and original files.

## Test Format

Please keep test-cases that throw exceptions out of the repo since exceptions
won't necessarily be thrown by desugared code. The only really standard property
is that a valid python file should have the same output before and after
desugaring.

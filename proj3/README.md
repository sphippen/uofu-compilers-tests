Project 3 Tests
===============

## Usage

One of the provided shell scripts runs all the tests against a provided binary.
Run it as follows 

    $ ./test-cases <path-to-pylex> <path-to-pyparse> <path-to-sxpy> <path-to-pydesugar1> <test-dir>

The reference pylex, pyparse, and sxpy are in the top-level 'ref' directory.
As a shorthand you can run:

    $ ./test-default <path-to-pydesugar1>

Which will automatically use the reference pylex, pyparse, sxpy, as well as
the standard test-directory. You should be able to run `test-default` from
any directory.

## Test Format

There's only `.py` files this time since the output is different for different
students. We have to use some weaker tests this time. We check two properties
of the desugared output:

    1. It conforms to the new AST. The AST has been simplified for this assignment
       so we have a few heuristic checks to make sure you're not violating it.
    2. The output of the desugared file is the same as the output of the 
       original. We'll try and make test-cases where the output is mostly
       dependent on the desugaring.

Please keep test-cases that throw exceptions out of the repo since exceptions
won't necessarily be thrown by desugared code. The only really standard property
is that a valid python file should have the same output before and after
desugaring.


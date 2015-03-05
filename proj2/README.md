Project 2 Tests
===============

## Usage

One of the provided shell scripts runs all the tests against a provided binary.
Run it as follows 

    $ ./test-cases <path-to-pylex> <path-to-pyparse> <test-dir>

The `test-cases` program loads all test cases from the given `<test-dir>` an
evaluates each against the pylex binary located at `<path-to-pylex>`, the
output of pylex is then sent to the pyparse binary located at <path-to-pyparse>. 
If any test case fails, test-cases will exit with a non-zero status code, and
a failure message will be printed that specifies which test-case failed.

For example, if you had copied your pylex and pyparse binaries into this directory, and you
wanted to run our tests against it you could do so using this command:

    $ ./test-cases ./pylex ./pyparse ./tests


### Using Reference `pylex`

The `helpers` directory contains a script that will act like the reference
pylex. To use that script as the pylex implementation run:

    $ ./test-cases ./helpers/ref-lex <path-to-pyparse> <test-dir>

### Running Tests Against reference `pysx` or `pyparse`

If you want to see if `pyparse` or `pysx` fails a given test-case, you can
use the following commands. For reference `pyparse`:

    $ ./test-cases ./helpers/ref-lex ./helpers/ref-parse  <test-dir>

For reference `pysx`:

    $ ./test-cases `which cat` ./helpers/pysx  <test-dir>

## Extra Tests

If you have tests that are not in this repository, you can supply any directory
with tests following the convention described below. If you come up with any
additional test cases, we'd love to add them to this repository so other
can test against them as well. You can add tests to this repo the "github way"
by [submitting a pull request][pull-request] (which is the easiest way for us), 
or you can just email your test cases to Josh at `josh@kunz.xyz`, or Spencer
at `spencer.phippen@gmail.com`. 
We'll also be watching the mailing list for any test cases we can add.

### Test Case Format

Test cases are specified using a test directory. There are two types of tests,
positive tests that we think pyparse should parse correctly, negative tests that we 
expect pyparse should fail to parse, and generate an error. 

Positive cases are
specified by two files, a `.py` file, and a `.out` file. The `.py` file is
the input to the lexer, and the `.out` file is what we expect pyparse should 
produce when given the lexed form of the file of the same name as input. If the output
pyparse produces when given a file `<test-name>.py` does not match
the contents of the file `<test-name>.out` (using `equal?`), we report that 
pyparse has failed the test.

If we expect that pyparse shouldn't be able to parse a particular `.py` file, we
don't supply a `.out` file that matches the `.py` file. This tells the test-runner
that pylex should incited exit with a non-zero status indicating failure.

Additional test cases can be added by putting files in the `./tests` directory
following the above convention. If the convention is still a little confusing
the `./tests` directory already has a number of test cases you can model
additional cases on.

  [pull-request]: https://help.github.com/articles/creating-a-pull-request/

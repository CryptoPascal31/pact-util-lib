#!/usr/bin/python3
import sys
import re
import argparse
from subprocess import Popen, PIPE

PACT_EXECUTABLE="/usr/local/bin/pact-5"

EXPECT_RE = re.compile('^"(Expect|Expect-that):')
EXPECT_FAILURE = re.compile('^"Expect failure:')
FAILURE = re.compile('^"FAILURE:')

parser = argparse.ArgumentParser(prog='pact_wrapper', description='Pact core wrapper')

parser.add_argument("script")
parser.add_argument("--print-all", action="store_true")
parser.add_argument("--print-expects", action="store_true")
parser.add_argument("--print-failures", action="store_true")
parser.add_argument("--disable-summary", action="store_true")
args = parser.parse_args()

print_expects = args.print_all or args.print_expects
print_failures = args.print_all or args.print_failures

def do_print(x, cond):
    if cond:
        print(x.strip())

expected = 0
expected_failure = 0
failures = 0;

with Popen([PACT_EXECUTABLE], bufsize=0, stdin=PIPE, stdout=PIPE,encoding="ascii") as pact:
    pact.stdin.write('(load "{!s}" true)\n\n\n'.format(args.script))
    pact.stdin.close()
    for line in pact.stdout:
        if EXPECT_RE.match(line):
            expected += 1
            do_print(line, print_expects)

        elif EXPECT_FAILURE.match(line):
            expected_failure += 1
            do_print(line, print_expects)

        elif FAILURE.match(line):
            failures += 1;
            do_print(line, print_failures)

        else:
            do_print(line, args.print_all)

    if not args.disable_summary:
        print("Expect Tests: {:d}".format(expected))
        print("Expect Failure Tests: {:d}".format(expected_failure))
        print("Failed tests: {:d}".format(failures))

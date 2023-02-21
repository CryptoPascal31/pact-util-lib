#!/bin/sh
PACT="pact"


cd "$(dirname "$0")"

$PACT tests_repl/util-lists-test.repl
echo ""
$PACT tests_repl/util-strings-test.repl
echo ""
$PACT tests_repl/util-math-test.repl
echo ""
$PACT tests_repl/util-time-test.repl
echo ""
$PACT tests_repl/util-random-test.repl
echo ""
$PACT tests_repl/util-zk-test.repl

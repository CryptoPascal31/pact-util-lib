#!/bin/sh
PACT="pact"

$PACT tests_repl/util-lists-test.repl
echo ""
$PACT tests_repl/util-strings-test.repl
echo ""
$PACT tests_repl/util-math-test.repl
echo ""
$PACT tests_repl/util-random-test.repl

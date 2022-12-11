PACT = pact

all: test

test-util-lists:
	$(PACT) tests_repl/util-lists-test.repl
	@echo ""

test-util-strings:
	$(PACT) tests_repl/util-strings-test.repl
	@echo ""

test-util-math:
	$(PACT) tests_repl/util-math-test.repl
	@echo ""

test-util-time:
	$(PACT) tests_repl/util-time-test.repl
	@echo ""

test-util-random:
	$(PACT) tests_repl/util-random-test.repl
	@echo ""

test: test-util-lists test-util-strings test-util-math test-util-time test-util-random


hashes:
	$(PACT) print-mod-hashs.repl

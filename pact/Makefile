PACT = pact

POST =

all: test

test-util-chain-data:
	$(PACT) tests_repl/util-chain-data.repl $(POST)
	@echo ""

test-util-lists:
	@echo $(POST)
	$(PACT) tests_repl/util-lists-test.repl $(POST)
	@echo ""

test-util-strings:
	$(PACT) tests_repl/util-strings-test.repl $(POST)
	@echo ""

test-util-math:
	$(PACT) tests_repl/util-math-test.repl $(POST)
	@echo ""

test-util-time:
	$(PACT) tests_repl/util-time-test.repl $(POST)
	@echo ""

test-util-random:
	$(PACT) tests_repl/util-random-test.repl $(POST)
	@echo ""

test-util-zk:
	$(PACT) tests_repl/util-zk-test.repl $(POST)
	@echo ""

test-util-fungible:
	$(PACT) tests_repl/util-fungible-test.repl $(POST)
	@echo ""

test: test-util-chain-data test-util-lists test-util-strings test-util-math test-util-time test-util-random test-util-zk test-util-fungible


hashes:
	$(PACT) print-mod-hashs.repl

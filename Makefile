all: test doc

doc:
	$(MAKE) -C docs html

clean:
		$(MAKE) -C docs clean

hashes:
	$(MAKE) -C pact hashes

test:
	$(MAKE) -C pact test

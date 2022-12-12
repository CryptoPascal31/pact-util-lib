all: test doc

.PHONY: deploy

doc:
	$(MAKE) -C docs html

clean:
		$(MAKE) -C docs clean
		$(MAKE) -C deploy clean

deploy:
		$(MAKE) -C deploy deploy

hashes:
	$(MAKE) -C pact hashes

test:
	$(MAKE) -C pact test

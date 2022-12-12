TEMP_PACT_FILES = .pact/util-lists.pact \
                  .pact/util-strings.pact \
                  .pact/util-math.pact \
									.pact/util-time.pact \
									.pact/util-random.pact

TESTNET_KEYS = keys/testnet-gas.key.yaml \
               keys/testnet-gov.key.yaml

MAINNET_KEYS = keys/mainnet-gas.key.yaml \
               keys/mainnet-gov.key.yaml

SUFFIXES = lists \
           strings \
           math \
					 time \
					 random

KDA_TOOL = kda


TESTNET_NODE = api.testnet.chainweb.com

MAINNET_NODE = api.chainweb.com


.PHONY:  testnet testnet-local testnet-gen mainnet mainnet-local mainnet-gen deploy

.pact/%.pact : ../pact/contracts/%.pact
	@mkdir -p .pact/
	echo "(namespace 'free)" | cat - $< > $@

testnet-gen: $(TEMP_PACT_FILES)  $(TESTNET_KEYS)
	kda gen -t util-lists.tkpl -d testnet.yaml -o tx-testnet-util-lists-{{chain}}.yaml
	kda gen -t util-strings.tkpl -d testnet.yaml -o tx-testnet-util-strings-{{chain}}.yaml
	kda gen -t util-math.tkpl -d testnet.yaml -o tx-testnet-util-math-{{chain}}.yaml
	kda gen -t util-time.tkpl -d testnet.yaml -o tx-testnet-util-time-{{chain}}.yaml
	kda gen -t util-random.tkpl -d testnet.yaml -o tx-testnet-util-random-{{chain}}.yaml
	kda sign -k keys/testnet-gas.key.yaml tx-testnet-*.yaml
	kda sign -k keys/testnet-gov.key.yaml tx-testnet-*.yaml


testnet-local: testnet-gen
	$(foreach suffix,$(SUFFIXES), $(KDA_TOOL) local tx-testnet-util-$(suffix)-*.json -n $(TESTNET_NODE) | jq ;)


testnet: testnet-gen
	$(foreach suffix,$(SUFFIXES), $(KDA_TOOL) send tx-testnet-util-$(suffix)-*.json -n $(TESTNET_NODE) | jq ; \
	                              sleep 180; \
																$(KDA_TOOL) poll tx-testnet-util-$(suffix)-*.json -n $(TESTNET_NODE) | jq ; )

	kda poll tx-testnet-*.json -n $(TESTNET_NODE)| jq > testnet-deploy-log.json


mainnet-gen: $(TEMP_PACT_FILES)  $(MAINNET_KEYS)
	kda gen -t util-lists.tkpl -d mainnet.yaml -o tx-mainnet-util-lists-{{chain}}.yaml
	kda gen -t util-strings.tkpl -d mainnet.yaml -o tx-mainnet-util-strings-{{chain}}.yaml
	kda gen -t util-math.tkpl -d mainnet.yaml -o tx-mainnet-util-math-{{chain}}.yaml
	kda gen -t util-time.tkpl -d mainnet.yaml -o tx-mainnet-util-time-{{chain}}.yaml
	kda gen -t util-random.tkpl -d mainnet.yaml -o tx-mainnet-util-random-{{chain}}.yaml
	kda sign -k keys/mainnet-gov.key.yaml tx-mainnet-*.yaml
	kda sign -k keys/mainnet-gas.key.yaml tx-mainnet-*.yaml


mainnet-local: mainnet-gen
	$(foreach suffix,$(SUFFIXES), $(KDA_TOOL) local tx-mainnet-util-$(suffix)-*.json -n $(MAINNET_NODE) | jq ;)

mainnet: mainnet-gen
	$(foreach suffix,$(SUFFIXES), $(KDA_TOOL) send tx-mainnet-util-$(suffix)-*.json -n $(MAINNET_NODE) | jq ; \
	                              sleep 180; \
																$(KDA_TOOL) poll tx-mainnet-util-$(suffix)-*.json -n $(MAINNET_NODE) | jq ; )
	kda poll tx-mainnet-*.json -n $(MAINNET_NODE)| jq > mainnet-deploy-log.json


deploy: testnet mainnet

clean:
	rm -f $(TEMP_PACT_FILES)
	rm -rf .pact
	rm -f tx-testnet-*.yaml
	rm -f tx-testnet-*.json
	rm -f tx-mainnet-*.yaml
	rm -f tx-mainnet-*.json

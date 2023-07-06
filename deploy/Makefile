TEMP_PACT_FILES = .pact/util-chain-data.pact \
                  .pact/util-lists.pact \
                  .pact/util-strings.pact \
                  .pact/util-math.pact \
                  .pact/util-time.pact \
                  .pact/util-random.pact \
                  .pact/util-zk.pact

TESTNET_KEYS = keys/testnet-gas.key.yaml \
               keys/testnet-gov.key.yaml

MAINNET_KEYS = keys/mainnet-gas.key.yaml \
               keys/mainnet-gov.key.yaml

SUFFIXES = chain-data \
           lists \
           strings \
           math \
           time \
           random \
           zk

KDA_TOOL = kda


TESTNET_NODE = api.testnet.chainweb.com

MAINNET_NODE = api.chainweb.com

TESTNET_DATA = testnet.yaml

MAINNET_DATA = mainnet.yaml


.PHONY:  testnet testnet-local testnet-gen mainnet mainnet-local mainnet-gen deploy

define \n


endef

.pact/%.pact : ../pact/contracts/%.pact
	@mkdir -p .pact/
	echo "(namespace 'free)" | cat - $< > $@

testnet-gen: $(TEMP_PACT_FILES)  $(TESTNET_KEYS) $(TESTNET_DATA)
	$(foreach suffix,$(SUFFIXES), $(KDA_TOOL) gen -t util-$(suffix).tkpl -d $(TESTNET_DATA) -o tx-testnet-util-$(suffix)-{{chain}}.yaml${\n})
	$(KDA_TOOL) sign -k keys/testnet-gas.key.yaml tx-testnet-*.yaml
	$(KDA_TOOL) sign -k keys/testnet-gov.key.yaml tx-testnet-*.yaml


testnet-local: testnet-gen
	$(foreach suffix,$(SUFFIXES), $(KDA_TOOL) local tx-testnet-util-$(suffix)-*.json -n $(TESTNET_NODE) | jq ;)


testnet: testnet-gen
	$(foreach suffix,$(SUFFIXES), $(KDA_TOOL) send tx-testnet-util-$(suffix)-*.json -n $(TESTNET_NODE) | jq ; \
	                              sleep 180; \
	                              $(KDA_TOOL) poll tx-testnet-util-$(suffix)-*.json -n $(TESTNET_NODE) | jq ; )

	$(KDA_TOOL) poll tx-testnet-*.json -n $(TESTNET_NODE)| jq > testnet-deploy-log.json


mainnet-gen: $(TEMP_PACT_FILES)  $(MAINNET_KEYS) $(MAINNET_DATA)
	$(foreach suffix,$(SUFFIXES), $(KDA_TOOL) gen -t util-$(suffix).tkpl -d $(MAINNET_DATA) -o tx-mainnet-util-$(suffix)-{{chain}}.yaml${\n})
	$(KDA_TOOL) sign -k keys/mainnet-gov.key.yaml tx-mainnet-*.yaml
	$(KDA_TOOL) sign -k keys/mainnet-gas.key.yaml tx-mainnet-*.yaml


mainnet-local: mainnet-gen
	$(foreach suffix,$(SUFFIXES), $(KDA_TOOL) local tx-mainnet-util-$(suffix)-*.json -n $(MAINNET_NODE) | jq ;)

mainnet: mainnet-gen
	$(foreach suffix,$(SUFFIXES), $(KDA_TOOL) send tx-mainnet-util-$(suffix)-*.json -n $(MAINNET_NODE) | jq ; \
	                              sleep 180; \
	                              $(KDA_TOOL) poll tx-mainnet-util-$(suffix)-*.json -n $(MAINNET_NODE) | jq ; )
	$(KDA_TOOL) poll tx-mainnet-*.json -n $(MAINNET_NODE)| jq > mainnet-deploy-log.json


deploy: testnet mainnet

clean:
	rm -f $(TEMP_PACT_FILES)
	rm -rf .pact
	rm -f tx-testnet-*.yaml
	rm -f tx-testnet-*.json
	rm -f tx-mainnet-*.yaml
	rm -f tx-mainnet-*.json

SUFFIXES = chain-data \
           lists \
           strings \
           math \
           time \
           random \
           fungible \
           zk

TESTNET_KEYS = keys/testnet-gas.key.yaml \
               keys/testnet-gov.key.yaml

MAINNET_KEYS = keys/mainnet-gas.key.yaml \
               keys/mainnet-gov.key.yaml

TEMP_PACT_FILES = $(foreach suffix,$(SUFFIXES),.pact/util-${suffix}.pact)

KDA_TOOL = kda

TESTNET_NODE = api.testnet.chainweb.com

MAINNET_NODE = api.chainweb.com

TESTNET_DATA = testnet.yaml

MAINNET_DATA = mainnet.yaml


.PHONY: all testnet-deploy testnet-local testnet-gen mainnet-deploy mainnet-local mainnet-gen deploy

define \n


endef

all: testnet-gen mainnet-gen

DESTDIR = transactions

.pact/%.pact : ../pact/contracts/%.pact
	@mkdir -p .pact/
	echo "(namespace 'free)" | cat - $< > $@

testnet-gen: $(TEMP_PACT_FILES)  $(TESTNET_KEYS) $(TESTNET_DATA)
	mkdir -p ${DESTDIR}
	$(foreach suffix,$(SUFFIXES), $(KDA_TOOL) gen -t util-$(suffix).tkpl -d $(TESTNET_DATA) -o ${DESTDIR}/tx-testnet-util-$(suffix)-{{chain}}.yaml${\n})
	$(foreach key_f, ${TESTNET_KEYS}, $(KDA_TOOL) sign -k ${key_f} ${DESTDIR}/tx-testnet-*.yaml;${\n})


testnet-local: testnet-gen
	$(foreach suffix,$(SUFFIXES), $(KDA_TOOL) local ${DESTDIR}/tx-testnet-util-$(suffix)-*.json -n $(TESTNET_NODE) | jq ;)


testnet-deploy: testnet-gen
	$(foreach suffix,$(SUFFIXES), $(KDA_TOOL) send ${DESTDIR}/tx-testnet-util-$(suffix)-*.json -n $(TESTNET_NODE) | jq ; \
	                              sleep 180; \
	                              $(KDA_TOOL) poll ${DESTDIR}/tx-testnet-util-$(suffix)-*.json -n $(TESTNET_NODE) | jq ; )

	$(KDA_TOOL) poll ${DESTDIR}/tx-testnet-*.json -n $(TESTNET_NODE)| jq > testnet-deploy-log.json


mainnet-gen: $(TEMP_PACT_FILES)  $(MAINNET_KEYS) $(MAINNET_DATA)
	mkdir -p ${DESTDIR}
	$(foreach suffix,$(SUFFIXES), $(KDA_TOOL) gen -t util-$(suffix).tkpl -d $(MAINNET_DATA) -o ${DESTDIR}/tx-mainnet-util-$(suffix)-{{chain}}.yaml${\n})
	$(foreach key_f, ${MAINNET_KEYS}, $(KDA_TOOL) sign -k ${key_f} ${DESTDIR}/tx-mainnet-*.yaml;${\n})


mainnet-local: mainnet-gen
	$(foreach suffix,$(SUFFIXES), $(KDA_TOOL) local ${DESTDIR}/tx-mainnet-util-$(suffix)-*.json -n $(MAINNET_NODE) | jq ;)

mainnet-deploy: mainnet-gen
	$(foreach suffix,$(SUFFIXES), $(KDA_TOOL) send ${DESTDIR}/tx-mainnet-util-$(suffix)-*.json -n $(MAINNET_NODE) | jq ; \
	                              sleep 180; \
	                              $(KDA_TOOL) poll ${DESTDIR}/tx-mainnet-util-$(suffix)-*.json -n $(MAINNET_NODE) | jq ; )
	$(KDA_TOOL) poll ${DESTDIR}/tx-mainnet-*.json -n $(MAINNET_NODE)| jq > mainnet-deploy-log.json


deploy: testnet mainnet

clean:
	rm -f $(TEMP_PACT_FILES)
	rm -rf .pact
	rm -rf ${DESTDIR}

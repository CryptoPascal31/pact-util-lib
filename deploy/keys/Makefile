all: decrypt

decrypt: mainnet-gas.key.yaml  mainnet-gov.key.yaml  testnet-gas.key.yaml  testnet-gov.key.yaml

%.yaml: %.yaml.gpg
	gpg --output $@ -d  $<

clean:
	rm -f *.yaml

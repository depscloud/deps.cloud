clean:
	rm -rf bin/ node_modules/ public/ resources/_gen/ tmp/

bin: bin.yaml
	bin-vendor

deps:
	git submodule update --init --recursive
	npm install

build: bin
	bin/hugo

test: bin
	bin/htmltest
#	bin/htmltest --conf .htmltest.external.yml

serve: bin
	bin/hugo serve -D

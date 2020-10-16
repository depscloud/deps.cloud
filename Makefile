clean:
	rm -rf bin/ node_modules/ public/ resources/_gen/ tmp/

bin/htmltest:
	curl https://raw.githubusercontent.com/wjdp/htmltest/master/godownloader.sh | bash

deps:
	git submodule update --init --recursive
	npm install

build:
	hugo

test: bin/htmltest
	bin/htmltest
#	bin/htmltest --conf .htmltest.external.yml

serve:
	hugo serve -D

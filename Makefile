deps:
	cabal-dev install --only-dependencies --enable-tests

configure: deps
	cabal-dev configure --enable-tests

clean:
	rm -rf cabal-dev dist

.PHONY: deps configure clean

init:
	cabal-dev install --only-dependencies --enable-tests
	cabal-dev configure --enable-tests

clean:
	rm -rf cabal-dev dist

.PHONY: init clean

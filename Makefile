deps:
	cabal-dev install --only-dependencies

clean:
	rm -rf cabal-dev dist

.PHONY: deps clean

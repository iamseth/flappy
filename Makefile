SHELL := /bin/bash
NAME ?= $(shell grep 't.window.title' src/conf.lua | cut -d\" -f2)


package: clean test
	@cd src
	@zip -9 -r ../${NAME}.love ./

test:
	@luacheck --std love --codes --no-max-line-length .

clean:
	@rm -f ${NAME}.love

run: package
	@love ${NAME}.love


.PHONY: build test clean run
.ONESHELL: package

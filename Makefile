.PHONY: build all clean test

ifneq ($(shell which docker),)
ENGINE := docker
else ifneq ($(shell which podman),)
ENGINE := podman
else
$(error Container engine can't be found)
endif

build:
	${ENGINE} build -t ghcr.io/platform-engineering-org/helper:latest .

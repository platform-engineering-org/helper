.PHONY: build

ifdef CI
ENGINE := docker
else
ENGINE := podman
endif

build:
	${ENGINE} build -t ghcr.io/platform-engineering-org/helper:latest .

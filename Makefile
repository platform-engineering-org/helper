.PHONY: build

ifdef CI
ENGINE := docker
else
ENGINE := podman
endif

build:
	${ENGINE} build -t platform-engineering-org/helper .

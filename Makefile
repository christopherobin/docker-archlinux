DATE ?= $(shell date +%Y.%m)
VERSION ?= $(shell date +%Y.%m.01)
BUILD_ARGS ?= 

build:
	docker build --build-arg version=$(VERSION) $(BUILD_ARGS) -t crobin/archlinux:latest .
	docker tag crobin/archlinux:latest crobin/archlinux:$(DATE)
.PHONY: build

push:
	docker push crobin/archlinux:$(DATE)
	docker push crobin/archlinux:latest
.PHONY: push

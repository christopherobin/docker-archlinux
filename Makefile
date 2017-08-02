DATE=$(shell date +%Y.%m)
VERSION=$(shell date +%Y.%m.01)

build:
	docker build --build-arg=version=$(VERSION) -t crobin/archlinux:latest .
	docker tag crobin/archlinux:latest crobin/archlinux:$(DATE)
.PHONY: build

push:
	docker push crobin/archlinux:$(DATE)
	docker push crobin/archlinux:latest
.PHONY: push

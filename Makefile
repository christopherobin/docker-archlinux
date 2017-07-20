DATE=$(shell date +%Y.%m)

build:
	docker build -t crobin/archlinux:latest .
	docker tag crobin/archlinux:latest crobin/archlinux:$(DATE)
.PHONY: build

push:
	docker push crobin/archlinux:$(DATE)
	docker push crobin/archlinux:latest
.PHONY: push

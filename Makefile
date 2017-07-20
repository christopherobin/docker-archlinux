DATE=$(shell date +%Y.%m)

build:
	docker build -t crobin/archlinux:latest .
	docker tag crobin/archlinux:latest crobin/archlinux:$(DATE)
.PHONY: build

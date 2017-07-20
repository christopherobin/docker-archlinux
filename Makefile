DATE=$(date +%Y.%m)

build:
	docker build -t crobin/archlinux:latest .
	docker build -t crobin/archlinux:$(DATE) .
.PHONY: build

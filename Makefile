PKG_LIST=archlinux-keyring bash coreutils filesystem pacman pacman-mirrorlist
BUILD_DIR=$(shell pwd)
DATE=$(date +%Y.%m)

.PHONY: build clean

all: build

check-deps:
	hash pacman 2>/dev/null

clean:
	sudo rm -Rf fs cache || true
	rm archlinux-root.tar.gz || true

build: check-deps clean
	mkdir fs/var/lib/pacman -p || true
	mkdir cache || true
	sudo pacman -Sy --config $(BUILD_DIR)/pacman.conf --dbpath fs/var/lib/pacman -r fs/ --cachedir cache/ --noconfirm --noprogressbar $(PKG_LIST)
	sudo chown -R ${USER}:${USER} fs
	cp mirrorlist fs/etc/pacman.d/mirrorlist
	cd fs && tar czvf ../archlinux-root.tar.gz .
	sudo rm -Rf fs cache
	docker build -t crobin/archlinux:latest .
	docker build -t crobin/archlinux:$(DATE) .

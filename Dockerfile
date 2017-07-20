# Start from alpine, download the bootstrap from archlinux
FROM alpine:latest as alpine

# Allows us to build any version
ARG version=2017.07.01
ARG arch=x86_64
ARG base=http://mirror.rackspace.com/archlinux/iso/${version}/

# Extract the bootstrap to /
ADD ${base}archlinux-bootstrap-${version}-${arch}.tar.gz /arch.tar.gz
RUN ls -l / && tar xf /arch.tar.gz && rm /root.x86_64/README

# Default to rackspace global mirror
RUN echo 'Server = http://mirror.rackspace.com/archlinux/$repo/os/$arch' >> /root.x86_64/etc/pacman.d/mirrorlist

# Then from there we want to pacstrap only a small set of packages to make the image as small as possible
FROM scratch as bigarch

ARG pkglist="archlinux-keyring bash coreutils filesystem pacman pacman-mirrorlist"

COPY --from=alpine /root.x86_64 /
RUN pacman-key --init && pacman-key --populate archlinux
RUN mkdir /strap/var/lib/pacman -p \
    && mkdir /tmp/cache \
    && pacman -Sy --dbpath /strap/var/lib/pacman -r /strap/ --cachedir /tmp/cache/ --noconfirm --noprogressbar ${pkglist} \
    && echo 'Server = http://mirror.rackspace.com/archlinux/$repo/os/$arch' >> /strap/etc/pacman.d/mirrorlist

# Final image, just copy what was installed in strap, then init the keyring
FROM scratch

COPY --from=bigarch /strap /
RUN pacman-key --init && pacman-key --populate archlinux


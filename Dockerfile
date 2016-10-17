FROM scratch

# Create base directories
ADD archlinux-root.tar.gz /
RUN pacman-key --init && pacman-key --populate archlinux; yes | pacman -Sc

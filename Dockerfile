FROM manjarolinux:latest
RUN echo 'Server = https://mirrors.kernel.org/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist
RUN pacman -Syyu --noconfirm \
        git sudo python3 \
        base-devel cmake ninja qt5-base \
        archiso arch-install-scripts pyalpm
COPY . /uhuruos
WORKDIR /uhuruos
RUN pacman-key --init
RUN pacman-key --populate manjaro
RUM pacman-key --populate blackarch
ENTRYPOINT ["./build.sh -c lz4 xfce"]
CMD []

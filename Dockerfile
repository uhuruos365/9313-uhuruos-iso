FROM manjarolinux/base:latest

RUN pacman -Syyu --noconfirm \
        git sudo python3 \
        base-devel cmake ninja qt5-base \
        archiso arch-install-scripts pyalpm wget squashfs-tools libisoburn

RUN wget https://www.ftp.ne.jp/Linux/packages/blackarch/blackarch/os/x86_64/blackarch-keyring-20180925-5-any.pkg.tar.zst && pacman -U blackarch-keyring-20180925-5-any.pkg.tar.zst
COPY . /uhuruos
WORKDIR /uhuruos
RUN pacman-key --init
RUN pacman-key --populate manjaro blackarch

ENTRYPOINT ["./build.sh -c lz4 xfce"]

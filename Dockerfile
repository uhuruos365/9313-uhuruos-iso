FROM manjarolinux/base:latest

RUN wget 
RUN pacman -Syyu --noconfirm \
        git sudo python3 \
        base-devel cmake ninja qt5-base \
        archiso arch-install-scripts pyalpm wget

RUN wget https://www.ftp.ne.jp/Linux/packages/blackarch/blackarch/os/x86_64/blackarch-keyring-20180925-5-any.pkg.tar.zst
RUN pacman -U blackarch-keyring-20180925-5-any.pkg.tar.zst
COPY . /uhuruos
WORKDIR /uhuruos
RUN pacman-key --init
RUN pacman-key --populate manjaro
RUN pacman-key --populate blackarch
RUN pacman -Sy

ENTRYPOINT ["./build.sh -c lz4 xfce"]

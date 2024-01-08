#!/bin/bash

apt update && apt install -y libglu1-mesa-dev mesa-utils xterm xauth x11-xkb-utils xfonts-base xkb-data libxtst6 libxv1 icewm gsettings-desktop-schemas

export TURBOVNC_VERSION=2.2.5
export LIBJPEG_VERSION=2.0.90
wget http://aivc.ks3-cn-beijing.ksyun.com/packages/libjpeg-turbo/libjpeg-turbo-official_${LIBJPEG_VERSION}_amd64.deb
wget http://aivc.ks3-cn-beijing.ksyun.com/packages/turbovnc/turbovnc_${TURBOVNC_VERSION}_amd64.deb
dpkg -i libjpeg-turbo-official_${LIBJPEG_VERSION}_amd64.deb
dpkg -i turbovnc_${TURBOVNC_VERSION}_amd64.deb
rm -rf *.deb

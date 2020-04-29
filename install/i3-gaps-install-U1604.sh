#!/bin/bash
# Install i3-gaps on Ubuntu 16
# set -e
# set -x
sudo apt-get update && sudo apt-get -y upgrade && \

sudo apt-get install -y libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev \
 libxcb-util0-dev libxcb-icccm4-dev libyajl-dev \
 libstartup-notification0-dev libxcb-randr0-dev \
 libev-dev libxcb-cursor-dev libxcb-xinerama0-dev \
 libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev \
 autoconf  
 
mkdir -p $HOME/repos
cd $HOME/repos

if cd xcb-util-xrm; then \
 git pull;
else
 git clone --recursive https://github.com/Airblader/xcb-util-xrm.git xcb-util-xrm; cd xcb-util-xrm;
fi

git submodule update --init
./autogen.sh --prefix=/usr
make
sudo make install

sudo apt-get install libxcb-shape0*


# sudo ldconfig
# sudo ldconfig -p

cd $HOME/repos

if cd i3-gaps; then
 git pull
else 
 git clone https://www.github.com/Airblader/i3 i3-gaps; cd i3-gaps;
fi

# compile & install
autoreconf --force --install
rm -rf build/
mkdir -p build && cd build/

# Disabling sanitizers is important for release versions!
# The prefix and sysconfdir are, obviously, dependent on the distribution.
../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
make
sudo make install

#
sudo apt-get install suckless-tools i3status




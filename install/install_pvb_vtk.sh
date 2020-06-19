#!/bin/bash

set -e
set -x

# updata system
sudo apt update
sudo apt upgrade -y

# install dependencies

sudo apt install -y gcc cmake qt5-default tcl8.5 tcl8.5-dev libtcl8.5 \
    tk8.5 tk8.5-dev libtk8.5 tcl-tclreadline git libxt-dev \
    libreadline-dev qtcreator* libqt5webenginewidgets5 qtwebengine5-dev \
    qtmultimedia5-dev libqt5multimediawidgets5 libqt5multimedia5-plugins \
    libqt5multimedia5 libqt5designer5 qttools5-dev libqt5svg5* xterm

# make repos dir
cd

if [ -d repos ]; then
    echo "repos exists"
  else
    mkdir repos
fi

cd repos

if [ -d vtk5 ]; then
    cd vtk5
    git checkout v5_fix
    cd ../
else
    # clone from github
    git clone -b v5_fix https://github.com/williamwanjia/VTK.git vtk5
fi

if [ -d vtk5_build ]; then
    echo "build folder exists"
  else
    mkdir vtk5_build
fi

cd vtk5_build
rm -rf *

cmake -Wno-dev -DBUILD_SHARED_LIBS:BOOL=ON \
      -DVTK_WRAP_TCL:BOOL=ON \
      -DCMAKE_CXX_FLAGS:STRING=-std=c++03 \
      -DTCL_INCLUDE_PATH:PATH=/usr/include/tcl8.5 \
      -DTCL_LIBRARY:FILEPATH=/usr/lib/x86_64-linux-gnu/libtcl8.5.so \
      -DTCL_TCLSH:FILEPATH=/usr/bin/tclsh8.5 \
      -DTK_INCLUDE_PATH:PATH=/usr/include/tcl8.5 \
      -DTK_INTERNAL_PATH:PATH=../vtk5/Utilities/TclTk/internals/tk8.5 \
      -DTK_LIBRARY:FILEPATH=/usr/lib/x86_64-linux-gnu/libtk8.5.so \
      ../vtk5

make -j3

sudo make install

cd ~/repos

# pvb

git clone -b withVTK https://github.com/williamwanjia/pvb.git

cd pvb

./build.sh

./build.sh

sudo ./install.sh

echo LD_LIBRARY_PATH=/usr/local/lib/vtk-5.10/ >> ~/.bashrc
echo TCLLIBPATH=/usr/local/lib/vtk-5.10/ >> ~/.bashrc

source ~/.bashrc


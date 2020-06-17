#!/bin/bash

set -e
set -x

# updata system
sudo apt updata
sudo apt upgrade -y

# install dependencies

sudo apt install gcc cmake qt5-default tcl8.5 tcl8.5-dev libtcl8.5 \
    tk8.5 tk8.5-dev libtk8.5 tcl-tclreadline git

# make repos dir
cd

if [ -d "repos"]; then
  echo "repos exists"
else
  mkdir repos
fi

cd repos

# clone from github
git clone -b v5_fix https://github.com/williamwanjia/VTK.git vtk_5

if [-d "vtk5_build"]; then
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



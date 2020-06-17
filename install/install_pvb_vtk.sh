#!/bin/bash

set -e
set -x

# updata system
sudo apt updata
sudo apt upgrade -y

# install dependencies

sudo apt install gcc cmake qt5-default tcl tk tcl-tclreadline git

# make repos dir
cd

if [ -d "repos"]; then
  echo "repos exists"
else
  mkdir repos
fi

cd repos

# clone from github
git clone https://github.com/williamwanjia/VTK.git VTK_5.10

cd VTK_5.10
git checkout v5.10.1


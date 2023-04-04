#!/usr/bin/bash

set -e
set -x
y
sudo apt-get update
 
sudo apt-get upgrade -y

sudo apt-get install -y axel dpkg

# install google-chrome
cd ~/Downloads

axel -a https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

sudo dpkg -i google-chrome-stable_current_amd64.deb 

cd -

sudo apt-get install -y ubuntu-restricted-extras smplayer conky-all \
        terminator default-jre fcitx \
        gcc g++ fcitx-googlepinyin autojump make \
        perl volumeicon-alsa wget axel xcompmgr git curl \
        okular fonts-font-awesome fonts-powerline awesome rofi gitg \
	openssh-client openssh-server nautilus qutebrowser \
	python-is-python3 python3-pip


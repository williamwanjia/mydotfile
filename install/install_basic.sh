set -e
set -x

sudo apt-get update
 
sudo apt-get upgrade -y

sudo apt-get install -y axel dpkg

# install google-chrome
cd ~/Downloads

axel -a https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

sudo dpkg -i google-chrome-stable_current_amd64.deb 

# install vim 8
sudo add-apt-repository ppa:jonathonf/vim

sudo apt update
 
sudo apt-get install -y ubuntu-restricted-extras smplayer conky-all \
        vim-gnome disper gedit vim terminator dolphin default-jre fcitx \
        gcc g++ fcitx-googlepinyin pcmanfm autojump make \
        perl volumeicon-alsa wget axel fcitx-sunpinyin xcompmgr git curl \
        autojump okular lightdm
  
# latex
# sudo apt-get install -y texlive-full kile latex-cjk-all

sudo apt-get upgrade -y


# Install Typora
# sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys BA300B7755AFCFAE
wget -qO - https://typora.io/linux/public-key.asc | sudo apt-key add -
# add Typora's repository
sudo add-apt-repository 'deb https://typora.io/linux ./'
sudo apt-get update

sudo apt-get install typora

# fonts
sudo apt-get install fonts-font-awesome fonts-powerline



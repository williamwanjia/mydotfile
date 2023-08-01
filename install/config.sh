set -x
set -e

# Git-------------------------------------------------
git config --global user.email "williamwanjia@gmail.com"
git config --global user.name "Jia Wan"
git config --global core.editor "nvim"


# awesome

cd ~/.config
git clone git@github.com:williamwanjia/awesome_cfg.git awesome

cd awesome
git submodule init
git submodule update --recursive

# Conky
cd ~/.config

git clone git@github.com:williamwanjia/JConky.git conky conky

# I3-------------------------------------------------

# if [ -d $HOME/.config/i3 ];


# NEOVIM ---------------------------------------------
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

cd ~/.config
mkdir nvim
cd nvim
ln -s ~/Documents/Repos/mydotfile/nvim/init.vim

pip3 install jedi-language-server

curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash - &&\
sudo apt-get install -y nodejs

# ctags

# install tools for building
sudo apt install -y \
    gcc make \
    pkg-config autoconf automake \
    python3-docutils \
    libseccomp-dev \
    libjansson-dev \
    libyaml-dev \
    libxml2-dev

cd ~/Downloads
git clone https://github.com/universal-ctags/ctags.git
cd ctags
./autogen.sh
./configure
make
sudo make install 

nvim --headless +PlugInstall +qa


# VIM-------------------------------------------------
# curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
#     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
     
# vim

# cd ~/repos
# 
# if [ -d ctags ];
# then
#     cd ctags
#     git pull
# else
#     git clone https://github.com/universal-ctags/ctags.git
#     cd ctags
# fi

# sudo apt install \
#     gcc make \
#     pkg-config autoconf automake \
#     python3-docutils \
#     libseccomp-dev \
#     libjansson-dev \
#     libyaml-dev \
#     libxml2-devu
# 
# ./autogen.sh
# ./configure
# make
# sudo make install 

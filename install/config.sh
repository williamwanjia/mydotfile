set +x
set +e

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

# I3-------------------------------------------------

# if [ -d $HOME/.config/i3 ];



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

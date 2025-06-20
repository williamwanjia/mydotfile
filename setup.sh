# basic
#

sudo apt update
sudo apt upgrade -y

sudo apt install -y tmux vim git curl wget axel python3-venv zsh \
    quake xcompmgr


# qtile
#

sudo apt install libiw-dev

# i3lock

# rofi

# font
#

# zsh
#
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Starship
#
curl -sS https://starship.rs/install.sh | sh

# kitty
#
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

ln -s ~/.local/kitty.app/kitty ~/.local/bin/kitty

# nvim
#
# needed by Mason

# check https://github.com/nvm-sh/nvm?tab=readme-ov-file#installing-and-updating for 
# the latest version
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
source ~/.bashrc
nvm install --lts

# spf
#
bash -c "$(curl -sLo- https://superfile.netlify.app/install.sh)"


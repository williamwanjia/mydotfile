#!/bin/bash
set -eo pipefail
set -x

CURRENT_DIR="$(pwd)"


LOG_FILE="$HOME/.sys_install_log.sh"
touch "$LOG_FILE"

log_done() {
    echo "$1" >> "$LOG_FILE"
}

already_done() {
    grep -Fxq "$1" "$LOG_FILE"
}

safe_link() {
    local src=$1
    local dest=$2

    if [[ -L $dest ]]; then
        echo "Symlink $dest exists. Replacing..."
        rm "$dest"
    elif [[ -e $dest ]]; then
        echo "File or directory $dest exists. Backing up to $dest.bak"
        mv "$dest" "$dest.bak"
    fi

    ln -sf "$src" "$dest"
    echo "Linked $dest → $src"
}


install_apt_packages() {
    local step="apt_packages_installed"
    if already_done "$step"; then echo "✓ Apt packages already installed"; return; fi

    sudo apt update
    sudo apt upgrade -y

    sudo apt install -y \
        tmux vim git curl wget axel python3-venv zsh \
        xcompmgr libiw-dev terminator guake zsh autojump \
        fcitx5 fcitx5-config-qt fcitx5-frontend-qt5 fcitx5-chinese-addons \
        kde-config-fcitx5 blueman libfuse2 ffmpeg

    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install

    wget -q -O /tmp/bat.deb \
        https://github.com/sharkdp/bat/releases/download/v0.25.0/bat_0.25.0_amd64.deb

    sudo dpkg -i /tmp/bat.deb
    rm /tmp/bat.deb

    log_done "$step"
    echo "✓ Apt packages installed"

}

install_nerd_font() {
    local step="nerd_fonts_installed"
    if already_done "$step"; then echo "✓ Nerd Fonts already installed"; return; fi

    mkdir -p ~/.local/share/fonts
    wget -qO /tmp/Meslo.zip \
        https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Meslo.zip

    unzip -qo /tmp/Meslo.zip -d ~/.local/share/fonts/
    fc-cache -fv > /dev/null

    log_done "$step"
    echo "✓ Nerd Font installed"
}

install_oh_my_zsh() {
    local step="ohmyzsh_installed"
    if already_done "$step"; then echo "✓ Oh My Zsh already installed"; return; fi

    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    rm ~/.zshrc

    safe_link ~/mydotfile/zshrc ~/.zshrc

    log_done "$step"
    echo "✓ Oh My Zsh installed"
}

install_starship() {
    local step="starship_installed"
    if already_done "$step"; then echo "✓ Starship already installed"; return; fi

    curl -sS https://starship.rs/install.sh | sh -s -- -y

    safe_link ~/mydotfile/starship.toml ~/.config/starship.toml

    log_done "$step"
    echo "✓ Starship installed"
}

install_kitty() {
    local step="kitty_installed"
    if already_done "$step"; then echo "✓ Kitty already installed"; return; fi

    curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
    mkdir -p ~/.local/bin
    safe_link ~/.local/kitty.app/bin/kitty ~/.local/bin/kitty

    safe_link ~/mydotfile/kitty ~/.config/kitty
    log_done "$step"
    echo "✓ Kitty installed"
}

install_nvm_and_node() {
    local step="nvm_node_installed"
    if already_done "$step"; then echo "✓ NVM & Node already installed"; return; fi

    wget https://github.com/neovim/neovim/releases/download/v0.11.2/nvim-linux-x86_64.appimage \
        -O ~/.local/bin/nvim
    chmod u+x ~/.local/bin/nvim

    # check https://github.com/nvm-sh/nvm?tab=readme-ov-file#installing-and-updating for 
    # the latest version
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

    nvm install --lts

    safe_link ~/mydotfile/nvim ~/.config/nvim

    # ctags
    git clone https://github.com/universal-ctags/ctags.git
    cd ctags
    ./autogen.sh
    ./configure
    make
    sudo make install
    rm -rf ctags

    log_done "$step"
    echo "✓ NVM and Node.js installed"
}

install_spf() {
    local step="spf_installed"
    if already_done "$step"; then echo "✓ SPF already installed"; return; fi

    bash -c "$(curl -sLo- https://superfile.netlify.app/install.sh)"

    safe_link ~/mydotfile/superfile ~/.config/superfile

    log_done "$step"
    echo "✓ SPF installed"
}

install_google_chrome() {
    local step="chrome_installed"
    if already_done "$step"; then echo "✓ Google Chrome already installed"; return; fi

    wget -q -O /tmp/google-chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo apt install -y /tmp/google-chrome.deb
    log_done "$step"
    echo "✓ Google Chrome installed"
}

install_lazygit() {
    local step="lazygit_installed"
    if already_done "$step"; then echo "✓ LazyGit already installed"; return; fi

    LAZYGIT_VERSION=$(curl -s https://api.github.com/repos/jesseduffield/lazygit/releases/latest | grep tag_name | cut -d '"' -f 4)
    wget -qO /tmp/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION#v}_Linux_x86_64.tar.gz"
    tar xf /tmp/lazygit.tar.gz -C /tmp
    sudo install /tmp/lazygit /usr/local/bin
    log_done "$step"
    echo "✓ LazyGit installed"
}

install_docker() {
    local step="docker_installed"
    if already_done "$step"; then echo "✓ Docker already installed"; return; fi

    sudo apt-get remove -y docker docker-engine docker.io containerd runc || true
    sudo apt-get update
    sudo apt-get install -y \
        ca-certificates curl gnupg lsb-release

    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    # Add current user to docker group
    sudo groupadd -f docker
    sudo usermod -aG docker "$USER"

    log_done "$step"
    echo "✓ Docker installed (log out and back in to use without sudo)"
}

install_qtile() {
    local step="qtile_installed"
    if already_done "$step"; then echo "✓ Qtile already installed"; return; fi

    sudo apt install -y xserver-xorg xinit libpangocairo-1.0-0 python3-pip \
        python3-xcffib python3-cairocffi

    pip3 install -r ~/mydotfile/qtile/requirements.txt

    safe_link ~/mydotfile/qtile ~/.config/qtile

    sudo cp ~/mydotfile/qtile/qtile.desktop /usr/share/xsessions/qtile.desktop

    log_done "$step"
    echo "✓ Qtile installed"
}

install_rofi() {
    local step="rofi_installed"
    if already_done "$step"; then echo "✓ Rofi already installed"; return; fi

    sudo apt install -y \
        meson make ninja-build pkg-config flex bison check \
        libglib2.0-dev libpango1.0-dev libcairo2-dev \
        libxkbcommon-dev libxkbcommon-x11-0 \
        libxcb1-dev libxcb-xkb-dev libxcb-randr0-dev \
        libxcb-xinerama0-dev libxcb-util0-dev libxcb-ewmh-dev \
        libxcb-icccm4-dev libxcb-cursor-dev libgdk-pixbuf-2.0-dev \
        libstartup-notification0-dev libxcb-imdkit-dev \
        libglib2.0-dev libxkbcommon-x11-dev
        # libgmodule-2.0-dev libgio-unix-2.0-dev those two not found
        #
    wget -O /tmp/rofi.tar.gz \
        https://github.com/davatorium/rofi/releases/download/1.7.9.1/rofi-1.7.9.1.tar.gz

    cd /tmp
    tar -xf rofi.tar.gz
    cd rofi-1.7.9.1

    meson setup build
    sudo ninja -C build install

    cd /tmp
    rm -rf rofi-*

    cd "$CURRENT_DIR"

    log_done "$step"
    echo "✓ Rofi installed"
}

install_ros2() {
    local step="ros2_installed"
    if already_done "$step"; then echo "✓ ROS2 already installed"; return; fi

    sudo apt install -y \
        software-properties-common \
        curl gnupg2 lsb-release

    sudo add-apt-repository universe
    sudo apt update

    sudo apt update && sudo apt install curl -y
    export ROS_APT_SOURCE_VERSION=$(curl -s https://api.github.com/repos/ros-infrastructure/ros-apt-source/releases/latest | grep -F "tag_name" | awk -F\" '{print $4}')
    curl -L -o /tmp/ros2-apt-source.deb "https://github.com/ros-infrastructure/ros-apt-source/releases/download/${ROS_APT_SOURCE_VERSION}/ros2-apt-source_${ROS_APT_SOURCE_VERSION}.$(. /etc/os-release && echo $VERSION_CODENAME)_all.deb" # If using Ubuntu derivates use $UBUNTU_CODENAME
    sudo apt install /tmp/ros2-apt-source.deb

    sudo apt update
    sudo apt upgrade -y

    sudo apt install -y ros-humble-desktop \
        python3-rosdep \
        ros-humble-rosbag2-storage-mcap \
        ros-humble-rmw-cyclonedds-cpp \
        python3-colcon-common-extensions

    sudo rosdep init
    rosdep update

    # create workspace for extension
    mkdir -p $HOME/ros2_ws/src
    # clone extension package
    cd $HOME/ros2_ws/src
    git clone git@github.com:tier4/ros2bag_extensions.git

    # build workspace
    cd $HOME/ros2_ws

    source /opt/ros/humble/setup.bash
    rosdep install --from-paths . --ignore-src --rosdistro=humble
    colcon build --symlink-install --catkin-skip-building-tests --cmake-args \
        -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_BUILD_TYPE=Release

    cd "$CURRENT_DIR"

    log_done "$step"
    echo "✓ ROS2 installed"
}

main() {
    install_apt_packages
    install_google_chrome
    install_nerd_font
    install_oh_my_zsh
    install_starship
    install_kitty
    install_nvm_and_node
    install_spf
    install_lazygit
    install_docker
    install_qtile
    install_rofi
    install_ros2
}

main "$@"


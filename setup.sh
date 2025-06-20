#!/bin/bash
set -euo pipefail

LOG_FILE="$HOME/.sys_install_log.sh"
touch "$LOG_FILE"

log_done() {
    echo "$1" >> "$LOG_FILE"
}

already_done() {
    grep -Fxq "$1" "$LOG_FILE"
}

install_apt_packages() {
    local step="apt_packages_installed"
    if already_done "$step"; then echo "✓ Apt packages already installed"; return; fi

    sudo apt update
    sudo apt upgrade -y

    sudo apt install -y \
        tmux vim git curl wget axel python3-venv zsh \
        xcompmgr libiw-dev terminator quake zsh

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

    ln -s ~/mydotfile/zshrc ~/.zshrc

    log_done "$step"
    echo "✓ Oh My Zsh installed"
}

install_starship() {
    local step="starship_installed"
    if already_done "$step"; then echo "✓ Starship already installed"; return; fi

    curl -sS https://starship.rs/install.sh | sh -s -- -y

    ln -sf ~/mydotfile/starship.toml ~/.config/starship.toml

    log_done "$step"
    echo "✓ Starship installed"
}

install_kitty() {
    local step="kitty_installed"
    if already_done "$step"; then echo "✓ Kitty already installed"; return; fi

    curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
    mkdir -p ~/.local/bin
    ln -sf ~/.local/kitty.app/kitty ~/.local/bin/kitty

    ln -sf ~/mydotfile/kitty ~/.config/kitty/kitty
    log_done "$step"
    echo "✓ Kitty installed"
}

install_nvm_and_node() {
    local step="nvm_node_installed"
    if already_done "$step"; then echo "✓ NVM & Node already installed"; return; fi

    wget https://github.com/neovim/neovim/releases/download/v0.11.2/nvim.appimage \
        -O ~/.local/bin/nvim
    chmod u+x ~/.local/bin/nvim

    # check https://github.com/nvm-sh/nvm?tab=readme-ov-file#installing-and-updating for 
    # the latest version
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

    nvm install --lts

    ln -sf ~/mydotfile/nvim ~/.config/nvim

    log_done "$step"
    echo "✓ NVM and Node.js installed"
}

install_spf() {
    local step="spf_installed"
    if already_done "$step"; then echo "✓ SPF already installed"; return; fi

    bash -c "$(curl -sLo- https://superfile.netlify.app/install.sh)"

    ln -sf ~/mydotfile/superfile ~/.config/superfile

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
}

main "$@"


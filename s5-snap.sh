#!/bin/bash
set -e
target="Ubuntu 24.04"
stage="Stage 5"
echo "$stage - Install $target vscode and snap packages"
display_header() {
    echo "=================================================="
    echo -e "\n\033[1;34m($stage)>> $1\033[0m"
}
command_exists() {
    command -v "$1" >/dev/null 2>&1
}
display_header "Checking sudo access"
sudo -v

# ============================================================
display_header "Installing FUSE"
sudo apt install libfuse2 -y

# ============================================================
display_header "Installing snap packages"
sudo snap install btop --edge
sudo snap install okular
sudo snap install brave
sudo snap install chromium
sudo snap install bitwarden
# sudo snap install calibre
sudo snap install dbeaver-ce
sudo snap install gimp
sudo snap install obs-studio
sudo snap install obsidian
sudo snap install sqlitebrowser
sudo snap install telegram-desktop
sudo snap install vlc


# ============================================================
# VS Code Installation
display_header "Installing Visual Studio Code"
# Install dependencies
if ! command_exists code; then
    sudo apt install software-properties-common apt-transport-https wget gpg -y

    # Download and install the Microsoft GPG key
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    sudo install -D -o root -g root -m 644 microsoft.gpg /etc/apt/keyrings/microsoft.gpg
    rm microsoft.gpg

    # Add the VS Code repository
    echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list

    # Update package cache and install VS Code
    sudo apt update
    sudo apt install code -y

    # Install VS Code Python extensions
    display_header "Installing VS Code Python extensions"
    code --install-extension ms-python.python
    code --install-extension ms-python.vscode-pylance
    code --install-extension ms-toolsai.jupyter
    code --install-extension njpwerner.autodocstring
    code --install-extension kevinrose.vsc-python-indent
else
    echo "vscode already installed"
fi
# ============================================================

echo "✅"

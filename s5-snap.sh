#!/usr/bin/env bash
set -e
target="Ubuntu 24.04"
stage="Stage 5"
echo "$stage - Install $target snap apps"
display_header() {
    echo "=================================================="
    echo -e "\n\033[1;34m($stage)>> $1\033[0m"
}
command_exists() {
    command -v "$1" >/dev/null 2>&1
}
display_header "Checking sudo access"
sudo -v

sudo snap refresh

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
sudo snap install obsidian --classic
sudo snap install sqlitebrowser
sudo snap install telegram-desktop
sudo snap install vlc
sudo snap install sublime-text --classic
sudo snap install docker
sudo snap install tor
sudo snap install postman

# ============================================================

echo "✅ $stage"
echo "✅ $stage - $(date '+%Y-%m-%d %H:%M:%S')" >> log.info
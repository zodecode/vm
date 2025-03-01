#!/usr/bin/env bash
set -e
target="Ubuntu 24.04"
stage="Stage 7"
echo "$stage - $target Install flatpak"
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
display_header "Installing tor"
# Install dependencies
if ! command_exists flatpak; then
    echo "installing"
    
flatpak install flathub org.torproject.torbrowser-launcher
    
else
    echo "already installed"
fi

# ============================================================


# ============================================================
echo "✅ $stage"
echo "✅ $stage - $(date '+%Y-%m-%d %H:%M:%S')" >> log.info

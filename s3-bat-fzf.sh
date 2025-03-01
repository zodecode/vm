#!/bin/bash
set -e
target="Ubuntu 24.04"
stage="Stage 3"
echo "$stage - $target - installing: rust apps"
display_header() {
    echo "=================================================="
    echo -e "\n\033[1;34m($stage)>> $1\033[0m"
    # echo "=================================================="
}
# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}
display_header "Checking sudo access"
sudo -v

# ============================================================
# Bat and fd Installation via Cargo
display_header "Installing bat and fd-find"
cargo install --locked bat
cargo install fd-find
# ============================================================
# fzf Installation
display_header "Installing fzf"
if [ ! -d "$HOME/.fzf" ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all
fi
# ============================================================
# tldr Installation via npm
display_header "Installing tldr"
npm install -g tldr

echo "✅"

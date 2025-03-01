#!/usr/bin/env bash
set -e
target="Ubuntu 24.04"
stage="Stage 3"
echo "$stage - $target - installing utilities"
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
# Bat and fd Installation via Cargo
display_header "Installing bat and fd-find"
cargo install --locked bat
cargo install fd-find
# ============================================================
display_header "Installing glow"
go install github.com/charmbracelet/glow@latest

# ============================================================
# fzf Installation
display_header "Installing fzf"
if [ ! -d "$HOME/.fzf" ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all
fi
# ============================================================
# JDK Installation via sdkman
# display_header "Installing JDK"
# [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
# sdk install java 21.0.6-zulu

# ============================================================
display_header "Installing tldr"
npm install -g tldr

# ============================================================
echo "✅ $stage"
echo "✅ $stage - $(date '+%Y-%m-%d %H:%M:%S')" >> log.info
echo "restart terminal"
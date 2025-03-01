#!/usr/bin/env bash
set -e
target="Ubuntu 24.04"
stage="Stage 7"
echo "$stage - $target Install flatpack"
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
display_header "Installing Visual Studio Code"
# Install dependencies
if ! command_exists code; then
    echo "vscode already installed"
else
    echo "vscode already installed"
fi

# ============================================================


# ============================================================
echo "✅ $stage"
echo "✅ $stage - $(date '+%Y-%m-%d %H:%M:%S')" >> log.info
#!/bin/bash
set -e
target="Ubuntu 24.04"
stage="Stage 2"
echo "$stage - $target - installing: go, node, rust, sdkman"
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
# Rust Installation
display_header "Installing Rust"
if ! command_exists rustc; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
fi
# ============================================================
# Go Installation
display_header "Installing Go"
GO_VERSION="1.24.0"
GO_TAR="go${GO_VERSION}.linux-amd64.tar.gz"
wget "https://go.dev/dl/${GO_TAR}" && tar -C /usr/local -xzf "${GO_TAR}"
# sudo rm -rf /usr/local/go && tar -C /usr/local -xzf "${GO_TAR}"
# sudo tar -C /usr/local -xzf "${GO_TAR}"
rm "${GO_TAR}"

# Add Go to system-wide PATH using tee
display_header "Configuring Go in system PATH"
if ! grep -q "export PATH=\$PATH:/usr/local/go/bin" /etc/profile; then
    echo 'export PATH=$PATH:/usr/local/go/bin' | sudo tee -a /etc/profile
    echo "Added Go to system-wide PATH in /etc/profile"
fi
# ============================================================
# Node.js Installation via NVM
display_header "Installing Node.js via NVM"
    if ! command_exists nvm; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    nvm install node
fi
# ============================================================
# SDKMAN Installation
display_header "Installing SDKMAN"
if ! command_exists sdk; then
    curl -s "https://get.sdkman.io" | bash
    source "$HOME/.sdkman/bin/sdkman-init.sh"
fi
# ============================================================

echo "✅ $stage"


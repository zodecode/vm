#!/bin/bash
set -e
target="Ubuntu 24.04"
stage="Stage 2"
echo "$stage - $target - installing: go, node, rust, jdk"
display_header() {
    echo "=================================================="
    echo -e "\n\033[1;34m($stage)>> $1\033[0m"
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
GO_VERSION="1.24.0"
display_header "Installing Go $GO_VERSION"
GO_FILE="/usr/local/go/bin/go"
if [[ ! -e $GO_FILE ]]; then
    echo "installing version: $GO_VERSION"
    GO_TAR="go${GO_VERSION}.linux-amd64.tar.gz"
    wget "https://go.dev/dl/${GO_TAR}" && sudo tar -C /usr/local -xzf "${GO_TAR}"
    rm "${GO_TAR}"
    # Add Go to system-wide PATH using tee
    display_header "Configuring Go in system PATH"
    if ! grep -q "export PATH=\$PATH:/usr/local/go/bin" /etc/profile; then
        echo 'export PATH=$PATH:/usr/local/go/bin' | sudo tee -a /etc/profile
        echo "Added Go to system-wide PATH in /etc/profile"
    fi
else
    echo "GO already installed"
fi

# ============================================================
# Node.js Installation via NVM
NVM_VERSION="v0.40.1"
display_header "Installing NODE with nvm ($NVM_VERSION)"
    if ! command_exists nvm; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh | bash
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
echo "restart terminal"

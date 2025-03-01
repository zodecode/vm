#!/usr/bin/env bash
set -e
target="Ubuntu 24.04"
stage="Stage 6"
echo "$stage - $target Install gh, vscode and chorme"
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
    sudo apt install software-properties-common apt-transport-https wget gpg -y
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    sudo install -D -o root -g root -m 644 microsoft.gpg /etc/apt/keyrings/microsoft.gpg
    rm microsoft.gpg
    # Add the VS Code repository
    echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
    # Update package cache and install VS Code
    sudo apt update
    sudo apt install code -y
    
    echo "Installing VS Code Python extensions"    
    code --install-extension ms-python.python
    code --install-extension ms-python.vscode-pylance
    code --install-extension ms-toolsai.jupyter
    code --install-extension njpwerner.autodocstring
    code --install-extension kevinrose.vsc-python-indent
else
    echo "vscode already installed"
fi

# ============================================================
display_header "Installing google-chrome"
if ! command_exists google-chrome; then
    echo "Adding Google Chrome repository..."
    # Add Google’s signing key
    wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor -o /usr/share/keyrings/google-chrome-keyring.gpg
    # Add the Google Chrome repository to sources.list.d
    echo "deb [signed-by=/usr/share/keyrings/google-chrome-keyring.gpg] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
    sudo apt update
    sudo apt install -y google-chrome-stable
    # Verify installation
    if command -v google-chrome >/dev/null 2>&1; then
        echo "✅ chrome installed successfully!"
    else
        echo "❌ chrome installation failed."
    fi
else
    echo "✅ chrome is already installed."
fi

# ============================================================
display_header "Installing gh cli"
if ! command_exists gh; then
    echo "Adding GitHub CLI repository..."
    wget -q -O - https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /usr/share/keyrings/githubcli-archive-keyring.gpg > /dev/null
    echo "deb [signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
    sudo apt update
    sudo apt install -y gh
    # Verify installation
    if command -v gh >/dev/null 2>&1; then
        echo "✅ GitHub CLI installed successfully!"
    else
        echo "❌ Installation failed."
    fi
else
    echo "✅ GitHub CLI is already installed."
fi

# ============================================================
echo "✅ $stage"
echo "✅ $stage - $(date '+%Y-%m-%d %H:%M:%S')" >> log.info
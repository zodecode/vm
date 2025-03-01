#!/bin/bash
set -e
target="Ubuntu 24.04"
stage="Stage 4"
echo "$stage - Install $target pyenv"
display_header() {
    echo "=================================================="
    echo -e "\n\033[1;34m($stage)>> $1\033[0m"
    # echo "=================================================="
}
display_header "Checking sudo access"
sudo -v

# Install some common Python development tools using pipx
display_header "Installing Python development tools via pipx"
pipx install black
pipx install flake8
pipx install isort
pipx install mypy
pipx install pytest
pipx install ipython
pipx install pre-commit
pipx install jupyterlab

# ============================================================
# Python Development Tools Installation
display_header "Installing Python development tools"

# Install pyenv for Python version management
curl https://pyenv.run | bash

# Add pyenv to bash profile
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc

# Install Poetry using its official installer
display_header "Installing Poetry"
curl -sSL https://install.python-poetry.org | python3 -
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc

# Install UV package manager
display_header "Installing UV package manager"
curl -LsSf https://astral.sh/uv/install.sh | sh
echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.bashrc


# ============================================================
# Final message

echo "✅"

#!/bin/bash
set -e
target="Ubuntu 24.04"
stage="Stage 0"
SCRIPT_DIR="$(dirname $(realpath "$0"))"
echo "$stage - Init user home: $target"
display_header() {
    echo "=================================================="
    echo -e "\n\033[1;34m($stage)>> $1\033[0m"
}
# ============================================================
display_header "Create user home files"
cd "$HOME" && mkdir -p bin .fonts data Temp Softwares
cp "$SCRIPT_DIR/home/.bash_aliases" "$HOME/"
cp "$SCRIPT_DIR/home/.bashrc" "$HOME/"
cp "$SCRIPT_DIR/home/.vimrc" "$HOME/"
cp "$SCRIPT_DIR/home/sysapps" "$HOME/bin"
unzip -o "$SCRIPT_DIR/home/Pictures.zip" -d "$HOME/"

echo "✅ $stage"
echo "restart terminal"
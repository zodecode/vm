#!/bin/bash
set -e
target="Ubuntu 24.04"
stage="Stage 0"
echo "$stage - Init home: $target"
display_header() {
    echo "=================================================="
    echo -e "\n\033[1;34m($stage)>> $1\033[0m"
}
# ============================================================
display_header "Create user home files"
cd "$HOME" && mkdir bin .fonts data Temp Softwares
cp home/.bash_alias "$HOME/"
unzip -o ./home/Pictures.zip -d "$HOME/"
echo "✅ $stage"

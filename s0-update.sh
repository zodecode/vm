#!/bin/bash
set -e
target="Ubuntu 24.04"
stage="Stage 0"
echo "$stage - Update system: $target"
display_header() {
    echo "=================================================="
    echo -e "\n\033[1;34m($stage)>> $1\033[0m"
}
display_header "Checking sudo access"
sudo -v
# ============================================================
# APT Packages Installation
display_header "Updating system packages"
sudo apt-get update && sudo apt-get upgrade -y

display_header "Base utilities"
sudo apt install curl git wget tree -y

echo "✅ $stage"

#!/bin/bash
set -e
target="Ubuntu 24.04"
stage="Stage 1"
echo "$stage - $target - installing base packages"
display_header() {
    echo "=================================================="
    echo -e "\n\033[1;34m($stage)>> $1\033[0m"
}
display_header "Checking sudo access"
sudo -v
# ============================================================
display_header "Installing base utilities"
sudo apt install curl git wget -y

display_header "Installing build tools"
sudo apt install -y make build-essential \
    libssl-dev zlib1g-dev libbz2-dev \
    libreadline-dev libsqlite3-dev \
    llvm libncurses5-dev libncursesw5-dev \
    xz-utils tk-dev libffi-dev liblzma-dev -y

# ============================================================
display_header "Installing archive tools"
sudo apt install rar unrar p7zip-full p7zip-rar pigz -y

# ============================================================
display_header "Installing Python packages and dependencies"
sudo apt-get install python3-pip python3-venv python3-gpg \
  python3-dev python3-openssl python3-tk python3-wheel \
  python3-setuptools -y

# ============================================================
display_header "Installing search and utility tools"
sudo apt install silversearcher-ag jq sqlite3 -y
# ============================================================
display_header "Installing system monitoring and utility tools"
sudo apt install htop neofetch shellcheck figlet meld -y
# ============================================================
display_header "Installing document tools"
sudo apt install pandoc pdftk w3m -y
# ============================================================
display_header "Installing system utilities"
sudo apt install attr colordiff tree gparted net-tools httpie -y
# ============================================================
# Tilix Installation
display_header "Installing Tilix (deb package)"

# tilix_package="tilix_1.9.6-2build1_amd64.deb"
# tilix_url="http://mirrors.kernel.org/ubuntu/pool/universe/t/tilix/${tilix_package}"

tilix_package="tilix_1.9.6-2build2_amd64.deb"
tilix_url="http://mirrors.edge.kernel.org/ubuntu/pool/universe/t/tilix/${tilix_package}"

# wget http://mirrors.kernel.org/ubuntu/pool/universe/t/tilix/tilix_1.9.6-2build1_amd64.deb
wget $tilix_url
# sudo apt install ./tilix_1.9.6-2build1_amd64.deb -y
# rm tilix_1.9.6-2build1_amd64.deb
sudo apt install $tilix_package -y
rm $tilix_package

# ============================================================
#display_header "Installing pipx"
#sudo apt install pipx -y && pipx ensurepath && sudo pipx ensurepath --global

echo "✅ $stage"

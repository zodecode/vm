#!/usr/bin/env bash
set -e
target="Ubuntu 24.04"
stage="Stage 6"
echo "$stage - $target - installing databases"
display_header() {
    echo "=================================================="
    echo -e "\n\033[1;34m($stage)>> $1\033[0m"
}
display_header "Checking sudo access"
sudo -v

# ============================================================
display_header "Installing databases"
sudo apt install postgresql postgresql-contrib -y
sudo apt install mysql-server libmysqlclient-dev -y
sudo apt install redis-server -y
sudo apt install mongodb -y
# ============================================================

echo "✅"

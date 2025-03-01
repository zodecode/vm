#!/usr/bin/env bash
set -e
target="Ubuntu 24.04"
stage="Stage 7"
echo "$stage - $target - installing databases"
display_header() {
    echo "=================================================="
    echo -e "\n\033[1;34m($stage)>> $1\033[0m"
}
display_header "Checking sudo access"
sudo -v

# ============================================================
display_header "Installing postgresql"
sudo apt install postgresql postgresql-contrib -y

display_header "Installing mysql"
sudo apt install mysql-server libmysqlclient-dev -y

display_header "Installing redis"
sudo apt install redis-server -y

# display_header "Installing mongodb"
# sudo apt install mongodb -y

# ============================================================

echo "✅ $stage"
echo "✅ $stage - $(date '+%Y-%m-%d %H:%M:%S')" >> log.info

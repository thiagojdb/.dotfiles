#!/usr/bin/zsh

./symlink.sh
./aptinstall.sh

# Get all upgrades
sudo apt upgrade -y

# See our bash changes
source ~/.zshrc

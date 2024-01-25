#!/usr/bin/bash

mkdir ~/.local/bin

./font-setup.sh
./symlink.sh
./aptinstall.sh


# Get all upgrades
sudo apt upgrade -y


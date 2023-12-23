#!/usr/bin/zsh

mkdir ~/.local/bin

./symlink.sh
./aptinstall.sh

#Install the terminal font
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Mononoki.zip -P fonts
cd fonts
unzip Mononoki.zip
mkdir ~/.local/share/fonts
fdfind -t f -e ttf -X cp {} ~/.local/share/fonts/
cd ../
rm -rf fonts



# Get all upgrades
sudo apt upgrade -y



# See our bash changes
source ~/.zshrc



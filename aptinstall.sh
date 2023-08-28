#!/usr/bin/zsh

sudo apt update

function install {
  which $1 &> /dev/null

  if [ $? -ne 0 ]; then
    echo "Installing: ${1}..."
    sudo apt install -y $1
  else
    echo "Already installed: ${1}"
  fi
}

# Basics
install curl
install chromium-browser
install firefox
install git
install htop
install nmap
install openvpn
install tmux

# Fun stuff
install figlet
install lolcat

# Brave thinks it needs to be longer than everyone else
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

sudo apt update
install brave-browser


# Rustlang
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Golang
goVersion=$(curl "https://go.dev/VERSION?m=text" | sed -n '1p;')
echo ${goVersion}
wget "https://dl.google.com/go/${goVersion}.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf ${goVersion}.linux-amd64.tar.gz
rm ${goVersion}.linux-amd64.tar.gz

# Fast node manager
curl -fsSL https://fnm.vercel.app/install | bash

# Sdkman
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"





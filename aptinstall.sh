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
install gcc
install pkg-config
install openssl 
install libasound2-dev 
install cmake 
install build-essential 
install python3 
install libfreetype6-dev 
install libexpat1-dev 
install libxcb-composite0-dev 
install libssl-dev 
install libx11-dev 
install libfontconfig1-dev
install curl
install chromium-browser
install firefox
install git
install htop
install nmap
install openvpn
install tmux
install libfreetype6-dev
install pass

# Fun stuff
install figlet
install lolcat

# Rustlang
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh  -s -- -y
source "$HOME/.cargo/env"

function install_golang {
    goVersion=${1}
    wget "https://dl.google.com/go/${goVersion}.linux-amd64.tar.gz"
    sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf ${goVersion}.linux-amd64.tar.gz
    rm ${goVersion}.linux-amd64.tar.gz
}

# Golang
goVersion=$(curl "https://go.dev/VERSION?m=text" | sed -n '1p;')
if ! type "go" > /dev/null; then
    install_golang ${goVersion}
else
    ## TODO - logic to check if is latest version and install again
fi 

# Fast node manager
cargo install fnm
cargo install gitui

# Sdkman
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

if ! type "alacritty" > /dev/null; then
    git clone https://github.com/alacritty/alacritty.git
    cd alacritty
    cargo build --release
    infocmp alacritty
    sudo tic -xe alacritty,alacritty-direct extra/alacritty.info
    sudo cp target/release/alacritty /usr/local/bin
    sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
    sudo desktop-file-install extra/linux/Alacritty.desktop
    sudo update-desktop-database
    cd ../
    rm -rf alacritty
else
    ## TODO - logic to check if is latest version and install again
fi 

if ! type "git-credential-manager" > /dev/null; then
    wget https://github.com/git-ecosystem/git-credential-manager/releases/download/v2.3.2/gcm-linux_amd64.2.3.2.deb
    sudo dpkg -i gcm-linux_amd64.2.3.2.deb 
    rm gcm-linux_amd64.2.3.2.deb 
fi 

if ! type "brave-browser" > /dev/null; then
    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
    sudo apt update
    install brave-browser
fi

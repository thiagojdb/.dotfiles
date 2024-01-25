#!/usr/bin/bash

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
install fzf
install figlet
install lolcat
install fd-find
install ripgrep

# Rustlang
if ! foobar_loc="$(type -p "cargo")" || [[ -z $foobar_loc ]]; then
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh  -s -- -y
	source "$HOME/.cargo/env"
fi

cargo install fnm
cargo install bat

# Sdkman
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

tee "$HOME/.sdkman/etc/config" <<EOF
sdkman_auto_answer=true
sdkman_selfupdate_feature=false
sdkman_insecure_ssl=false
sdkman_curl_connect_timeout=5
sdkman_curl_continue=true
sdkman_curl_max_time=10
sdkman_beta_channel=false
sdkman_debug_mode=false
sdkman_colour_enable=true
sdkman_auto_env=true
sdkman_auto_complete=true
EOF

sdk install java 20.0.1-amzn
sdk install java 17.0.8-amzn
sdk install java 11.0.20-amzn
sdk install java 8.0.382-amzn


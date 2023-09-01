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
install fzf
install figlet
install lolcat
install fd-find
install ripgrep

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Rustlang
if ! foobar_loc="$(type -p "cargo")" || [[ -z $foobar_loc ]]; then
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh  -s -- -y
	source "$HOME/.cargo/env"
fi

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Golang
if ! foobar_loc="$(type -p "go")" || [[ -z $foobar_loc ]]; then
    goVersion=$(curl "https://go.dev/VERSION?m=text" | sed -n '1p;')
    wget "https://dl.google.com/go/${goVersion}.linux-amd64.tar.gz"
    sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf ${goVersion}.linux-amd64.tar.gz
    rm ${goVersion}.linux-amd64.tar.gz
fi

if ! foobar_loc="$(type -p "alacritty")" || [[ -z $foobar_loc ]]; then
    git clone https://github.com/alacritty/alacritty.git build/alacritty
    cd build/alacritty
    cargo build --release
    infocmp alacritty
    sudo tic -xe alacritty,alacritty-direct extra/alacritty.info
    sudo cp target/release/alacritty /usr/local/bin
    sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
    sudo desktop-file-install extra/linux/Alacritty.desktop
    sudo update-desktop-database
    cd ../
    rm -rf alacritty
fi 

if ! foobar_loc="$(type -p "git-credential-manager")" || [[ -z $foobar_loc ]]; then
    wget https://github.com/git-ecosystem/git-credential-manager/releases/download/v2.3.2/gcm-linux_amd64.2.3.2.deb
    sudo dpkg -i gcm-linux_amd64.2.3.2.deb 
    rm gcm-linux_amd64.2.3.2.deb 
fi 

if ! foobar_loc="$(type -p "nvim")" || [[ -z $foobar_loc ]]; then
	git clone https://github.com/neovim/neovim neovim-build
	cd neovim-build
	git checkout stable
	sudo apt-get install ninja-build gettext cmake unzip curl -y
	make CMAKE_BUILD_TYPE=Release
	sudo make install
	cd ../
	rm neovim-build -rf
fi

if ! foobar_loc="$(type -p "lazygit")" || [[ -z $foobar_loc ]]; then
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf lazygit.tar.gz lazygit
    sudo install lazygit /usr/local/bin
    rm lazygit.tar.gz lazygit
fi

# Fast node manager
cargo install fnm
cargo install gitui

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


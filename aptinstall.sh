#!/usr/bin/zsh

sudo apt update

sudo apt install -y gcc pkg-config openssl libasound2-dev cmake \n
build-essential python3 libfreetype6-dev libexpat1-dev libxcb-composite0-dev \n
libssl-dev libx11-dev libfontconfig1-dev curl chromium-browser firefox git \n
htop nmap openvpn tmux libfreetype6-dev pass fzf figlet lolcat fd-find \n
ripgrep

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


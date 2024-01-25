export ZSH="$HOME/.oh-my-zsh"


ZSH_THEME="robbyrussell"
source $ZSH/oh-my-zsh.sh

alias vim=nvim
alias sudovim="sudo -E nvim"

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export PATH="/home/thiago/.local/share/fnm:$PATH"
eval "`fnm env`"

bindkey -s ^f "tmux-sessionizer\n"


# bun completions
[ -s "/home/thiago/.bun/_bun" ] && source "/home/thiago/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH:/usr/local/go/bin:$HOME/.local/bin:$HOME/.local/bin/scripts"

export MOZ_USE_XINPUT2=1

alias icat="kitten icat"

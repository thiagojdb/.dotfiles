
export ZSH="$HOME/.oh-my-zsh"

export GCM_CREDENTIAL_STORE=gpg
export GPG_TTY=/dev/pts/2

export MOZ_USE_XINPUT2=1

ZSH_THEME="robbyrussell"
source $ZSH/oh-my-zsh.sh

alias vim=nvim

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export PATH="/home/thiago/.local/share/fnm:$PATH"
eval "`fnm env`"

bindkey -s ^f "$HOME/.local/bin/tmux-sessionizer\n"



# bun completions
[ -s "/home/thiago/.bun/_bun" ] && source "/home/thiago/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

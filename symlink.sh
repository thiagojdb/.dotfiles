#!/usr/bin/zsh

# Up from scripts dir
#
dotfilesDir=$(pwd)

echo $dotfilesDir

function linkDotfile {
  dest="${HOME}/${1}"
  customSrc=${2}
  if [[ $customSrc == "" ]]; then
      customSrc=${1} 
  fi

  dateStr=$(date +%Y-%m-%d-%H%M)

  if [ -h ~/${1} ]; then
    # Existing symlink 
    echo "Removing existing symlink: ${dest}"
    rm ${dest} 

  elif [ -f "${dest}" ]; then
    # Existing file
    echo "Backing up existing file: ${dest}"
    mv ${dest}{,.${dateStr}}

  elif [ -d "${dest}" ]; then
    # Existing dir
    echo "Backing up existing dir: ${dest}"
    mv ${dest}{,.${dateStr}}
  fi

  echo "Creating new symlink: on ${dest} pointing to ${customSrc} "
  ln -s ${dotfilesDir}/${customSrc} ${dest}
}

linkDotfile .local/bin/tmux-sessionizer tmux-sessionizer/script.sh
linkDotfile .config/nvim nvim
linkDotfile .config/alacritty alacritty
linkDotfile .config/gitui gitui
linkDotfile .tmux.conf
linkDotfile .zshrc
linkDotfile .gitconfig

#!/usr/bin/bash

function setup_font {
    FONT_FILENAME=${1}
    echo "downloading and saving font: ${FONT_FILENAME}..."
    wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/${FONT_FILENAME}.zip"
    unzip -x -o ${FONT_FILENAME}.zip -d ~/.local/share/fonts/${FONT_FILENAME}
    rm ${FONT_FILENAME}.zip
}

setup_font Mononoki
setup_font Ubuntu
setup_font Agave


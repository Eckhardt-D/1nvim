#!/bin/bash

set -e

if [ "$(uname)" != "Darwin" ] && [ "$(uname)" != "Linux" ]
then
  echo "Platform not supported, yet."
  exit 1;
fi

CONFIG_OUT_DIR="$HOME/.config/nvim"

if [ -d "$CONFIG_OUT_DIR" ]; then
  echo "$CONFIG_OUT_DIR already exists."
  exit 1
fi

if which nvim >/dev/null; then
  echo "Neovim executable already exists."
  exit 1
fi

if [ -d "/squashfs-root" ]; then
  echo "/squashfs-root already exists."
  exit 1
fi

mkdir -p "$CONFIG_OUT_DIR"
cd "$CONFIG_OUT_DIR"

if [ "$(uname)" == "Darwin" ]
then
  if which brew >/dev/null; then
    echo "Installing Neovim with 1nvim on Mac requires brew."
    exit 1
  fi
  brew install neovim
elif [ "$(uname)" == "Linux" ]
then
  mkdir -p neovim
  cd neovim
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
  chmod u+x nvim.appimage
  ./nvim.appimage --appimage-extract
  ./squashfs-root/AppRun --version
  echo \n

  if which sudo >/dev/null; then
    sudo mv squashfs-root /
    sudo ln -s /squashfs-root/AppRun /usr/bin/nvim
    sudo rm -r neovim
  else
    mv squashfs-root /
    ln -s /squashfs-root/AppRun /usr/bin/nvim
    rm -r neovim
  fi
  cd ..
fi

cd "$CONFIG_OUT_DIR"

curl "https://raw.githubusercontent.com/nvim-lua/kickstart.nvim/master/init.lua" > init.lua

nvim ./init.lua




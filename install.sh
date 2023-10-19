#!/bin/bash

echo "Install dev tools"

xcode-select --install

echo "Install Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew upgrade

echo "Install packages using brewfile"
brew install rcmdnk/file/brew-file
export HOMEBREW_BREWFILE=$(pwd)/Brewfile
brew file install

echo "Copy dotfiles"
sudo cp -r .alacritty.yml .config .gitconfig .tmux.conf .tmux.conf.local .zshrc ~/

echo "Source files"
source ~/.zshrc


#!/bin/bash

echo "Install dev tools"

xcode-select --install

echo "Install Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew upgrade
brew doctor

echo "Install text formulae : terminal utils"
brew install coreutils zsh emacs fzf tmux starship tree bat tig htop rsync

echo "Install text formulae : web-dev"
brew install npm yarn redis wget

echo "Install ng with npm"
npm install -g @angular/cli

echo "Install cask formulae"
brew cask install alacritty visual-studio-code docker insomnia julia typora

echo "Install fast-highlight in ~/.zsh/fast-syntax-highlighting/
git clone https://github.com/zdharma/fast-syntax-highlighting ~/.zsh/fast-syntax-highlighting/

echo "Install Fira fonts"
brew install svn
brew tap homebrew/cask-fonts
brew cask install font-fira-code font-fira-mono font-fira-mono-for-powerline font-fira-sans

echo "Copy dotfiles"
sudo cp -r .emacs.d .alacritty.yml .config .gitconfig .tmux.conf .tmux.conf.local .zshrc ~/

echo "Source files"
source ~/.zshrc


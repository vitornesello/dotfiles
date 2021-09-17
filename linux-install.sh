#!/bin/bash

echo "Install dev tools"

echo "Install text formulae : terminal utils"
sudo apt-get install emacs tmux tree bat htop postgresql

echo "Install text formulae : web-dev"
sudo apt-get install npm yarn redis wget

echo "Install ng with npm"
npm install -g @angular/cli

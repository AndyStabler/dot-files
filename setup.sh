#!/usr/bin/env bash

read -p "⚠️     This will remove existing config files. Are you sure? [y|n]" -n 1 -r

if [[ ! $REPLY =~ ^[Yy]$ ]]
then
  [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 # handle exits from shell or function but don't exit interactive shell
fi

echo
echo

echo "Deleting existing config files 🧹"
rm ~/.gitconfig
rm ~/.tmux.conf
rm ~/.vimrc
echo "Done ✨"

echo "Creating links to new config files 🔨"
ln git/gitconfig ~/.gitconfig
ln tmux/tmux.conf ~/.tmux.conf
ln vim/vimrc ~/.vimrc
echo "Complete ✅"

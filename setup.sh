#!/usr/bin/env bash

read -p "⚠️     This will remove existing config files from the root directory. Are you sure? [y|n]" -n 1 -r

if [[ ! $REPLY =~ ^[Yy]$ ]]
then
  [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 # handle exits from shell or function but don't exit interactive shell
fi

echo
echo

echo "Deleting existing config files 🧹"
echo -e "Removing Git config . . .\t🔥"
# the -f is so we don't show a warning if the file doesn't already exist
rm -f ~/.gitconfig
echo -e "Removing Tmux config . . .\t🔥"
rm -f ~/.tmux.conf
echo -e "Removing vimrc . . .\t\t🔥"
rm -f ~/.vimrc

echo "Creating fresh links to config files 🪄  ✨ 🥰"
ln git/gitconfig ~/.gitconfig
ln tmux/tmux.conf ~/.tmux.conf
ln vim/vimrc ~/.vimrc
echo "Complete ✅"

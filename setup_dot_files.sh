#!/usr/bin/env bash

safety_check() {
  read -p "⚠️     This will alter existing config files from the root directory. Are you sure? [y|n]" -n 1 -r

  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 # handle exits from shell or function but don't exit interactive shell
  fi

  echo
  echo
}

set_up_dot_file() {
  local source_file_path="$1"
  local destination_file_path="$2"

  if [ -f "$destination_file_path" ]; then
    local tmp_path="${destination_file_path}_backup"
    echo "Backing up $destination_file_path to $tmp_path"
    # mv overwrites without prompting by default so use -i to be safe
    mv -i $destination_file_path $tmp_path
  fi
  echo "Creating a link from $destination_file_path to $source_file_path"
  ln -f $source_file_path $destination_file_path
}

clean_up_backup() {
  local backup_file_path="${1}_backup"
  echo "Removing ${backup_file_path}"
  rm $backup_file_path
}

# Check for the --clean-up flag
if [[ "$#" -eq 1 && "$1" == "--clean-up" ]]; then
  clean_up_backup "${HOME}/.gitconfig"
  clean_up_backup "${HOME}/.tmux.conf"
  clean_up_backup "${HOME}/.vimrc"
  clean_up_backup "${HOME}/.zshrc"
else
  safety_check
  echo -e "====\n Setting up git config\n====="
  set_up_dot_file "$(pwd)/git/gitconfig" "${HOME}/.gitconfig"

  echo -e "====\n Setting up tmux\n====="
  set_up_dot_file "$(pwd)/tmux/tmux.conf" "${HOME}/.tmux.conf"

  echo -e "====\n Setting up vim\n====="
  set_up_dot_file "$(pwd)/vim/vimrc" "${HOME}/.vimrc"

  echo -e "====\n Setting up zshrc\n====="
  set_up_dot_file "$(pwd)/zshrc/zshrc" "${HOME}/.zshrc"

  echo
  echo
  echo "✅ All done!"
  echo
  echo


  echo "====="
  echo "Check everything looks OK, then run ./setup_dot_files.sh --clean-up to remove backed-up files"
  echo "====="
  echo
  echo
fi

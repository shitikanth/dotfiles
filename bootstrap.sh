#!/usr/bin/env bash

git pull

DIR=$(pwd)
FIND=find


if [ "$(uname -s)" = "Darwin" ]
then FIND="gfind"
fi

function create_symlinks() {
  for file_name in $($FIND . -maxdepth 1 -name '_*' -printf '%f\n')
  do ln -sTf $PWD/$file_name $HOME/$(echo $file_name | sed s/_/./1)
  done
}

function vim_plugin_install() {
    vim +PluginInstall +qall
}

function emacs_plugin_install() {
    # spacemacs automatically installs plugins on install
    emacs --eval "(if (functionp 'spacemacs/kill-emacs) (spacemacs/kill-emacs) (kill-emacs))"
}

git submodule update --init --recursive
create_symlinks
vim_plugin_install
emacs_plugin_install

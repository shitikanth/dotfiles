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

git submodule update --init --recursive
create_symlinks

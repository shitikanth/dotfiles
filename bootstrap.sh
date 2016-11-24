#!/usr/bin/env bash

git pull origin master

DIR=`pwd`

function create_symlinks() {
  for file_name in $(find . -maxdepth 1 -name '_*' -printf '%f\n')
  do ln -sf $PWD/$file_name $HOME/$(echo $file_name | sed s/_/./1)
  done
}

git submodule update --init --recursive
create_symlinks

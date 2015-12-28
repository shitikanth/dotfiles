#!/usr/bin/env bash

git pull origin master

DIR=`pwd`

function create_symlinks() {
    for file_name in `ls -A | egrep -v '.git*|bootstrap.sh|tmp'`; do ln -s $DIR/$file_name ~; done
}

git submodule update --init --recursive
create_symlinks

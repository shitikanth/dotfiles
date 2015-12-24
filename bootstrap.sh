#!/usr/bin/env bash

git pull origin master

DIR=`pwd`

function create_symlinks() {
    for file_name in `la | egrep -v '.git*|bootstrap.sh|tmp'`; ln -s $DIR/$file_name ~
}

create_symlinks

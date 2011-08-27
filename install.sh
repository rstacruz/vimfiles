#!/usr/bin/env sh
ln -s "`pwd`/vimrc" ~/.vimrc
mkdir -p bundle
git clone http://github.com/gmarik/vundle.git bundle/vundle

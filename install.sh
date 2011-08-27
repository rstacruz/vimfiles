#!/usr/bin/env sh
if [ "$(basename `pwd`)" != ".vim" ]; then
  echo "Note: this repo must be checked out into ~/.vim."
  exit 61
fi

if [ -f ~/.vimrc ]; then
  echo " * Moving aside your .vimrc to .vimrc.old..."
  mv ~/.vimrc ~/.vimrc.old
fi

echo " * Installing ~/.vimrc..."
ln -s "`pwd -LP`/vimrc.vim" ~/.vimrc

if [ ! -e "./bundle/vundle" ]; then
  echo " * Adding Vundle..."
  mkdir -p bundle
  git clone http://github.com/gmarik/vundle.git bundle/vundle
else
  echo " * (Skipping Vundle checkout; you already have it.)"
fi

echo ""
echo "OK! Now run :BundleInstall in Vim."

Vim files!
==========

    git clone http://github.com/rstacruz/vimfiles.git ~/.vim
    cd ~/.vim
    rake setup

This is my Vim setup which is managed by [Vundle][vundle]. You may not like my setup,
but you may want to build from this skeleton. I've set this repo up in the 
cleanest way I can, just look at `vimrc.vim` :D

[vundle]: https://github.com/gmarik/vundle

Pro tip!
--------

You're probably using MacVIM on a Mac. Add this to your `~/.profile` to use a better
build of Vim that supports Ruby and Python (that is, Command-T, UltiSnip, etc):

    alias vim=/Applications/MacVim.app/Contents/MacOS/Vim

Usage
-----

    vimrc.vim         - Put your bundles here.
    plugin/           - Put your initializers here.
    after/ftplugin/   - Set your local options per filetype here, like tabstops and such.

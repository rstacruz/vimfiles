# My vim files

Install as symlinks:

    $ make install

Managed by [bower](http://bower.io). Use bower to fetch packages.

    $ bower install

You may need to also build some bundles:

    $ cd bundle/vimproc.vim && make

## File structure

    bower.json          - manifest
    vimrc.vim           - linked as ~/.vimrc
    plugin/
      customizations/   - customizations
      keys/             - key bindings
      options/          - vim options
      plugins/          - plugin settings

## Also see

* https://github.com/terryma/dotfiles/blob/master/.vimrc

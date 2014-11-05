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

## Checking for new versions

    $ bower list

## Version locking

Since bower still has no shrinkwrap feature ([#505]), there's a hackish way:

```sh
$ make lock    # lock dependency versions into .bowerlock.json
$ make bower   # install from locked versions in .bowerlock.json
```

[#505]: https://github.com/bower/bower/issues/505

## Also see

* https://github.com/terryma/dotfiles/blob/master/.vimrc

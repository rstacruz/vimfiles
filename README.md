# My vim files

The ultimate vim setup managed by [bower] and [pathogen].

* No messy git submodules
* Vim packages declared via [bower.json](bower.json)
* Bower downloads vim packages fast (gets tarballs instead of git-cloning)
* Bower alerts you of new package versions
* Super-modular (see [plugins/](plugins/))

## Let's go

Use bower to fetch packages.

```sh
$ bower install
```

Install as symlinks into `~`:

```sh
$ make install
```

You may need to also build some bundles:

```sh
$ cd bundle/vimproc.vim && make
```

## File structure

    bower.json          - manifest
    vimrc.vim           - linked as ~/.vimrc
    bundle/             - where plugins lie (managed by bower)
    extras/             - also where plugins lie
    plugin/
      customizations/   - customizations
      keys/             - key bindings
      options/          - vim options
      plugins/          - plugin settings

## Checking for new versions

```sh
$ bower list
```

## Version locking

Since bower still has no shrinkwrap feature ([#505]), there's a hackish way:

```sh
$ make lock    # lock dependency versions into .bowerlock.json
$ make bower   # install from locked versions in .bowerlock.json
```

## Also see

* https://github.com/terryma/dotfiles/blob/master/.vimrc

## Thanks

MIT license

[#505]: https://github.com/bower/bower/issues/505
[pathogen]: https://github.com/tpope/vim-pathogen
[bower]: http://bower.io

# My vim files

The ultimate vim setup managed by [bower] and [pathogen].

* No messy git submodules
* Vim packages declared via [bower.json](bower.json)
* Bower downloads vim packages fast (gets tarballs instead of git-cloning)
* Bower alerts you of new package versions
* Modular, options are categorized in [plugins/](plugins/)

<br>

## Let's go

Use bower to fetch packages. ([alt](#no-bower))

```sh
$ bower install
```

Install as symlinks into `~/.vimrc` and `~/.vim/`.
(NB: this will delete them if they exist!)

```sh
$ make link
```

You may need to also compile some bundles.

```sh
$ cd bundle/vimproc.vim && make
```

<br>

## Updating

Add new packages via:

```sh
$ bower install --save tpope/vim-haml
```

Check for new versions using bower.

```sh
$ bower update
```

<br>

## Version locking

Since bower still has no shrinkwrap feature ([#505]), there's a hackish way:

```sh
$ make lock      # lock dependency versions into .bowerlock
$ make install   # install from locked versions in .bowerlock
```

Use `make lock` after doing bower updates. You'll then be able to see what's
changed by inspecting the lockfile in `git diff`.

#### No bower

Stuck without bower (eg, a server deploy)? Use `make install`, it'll fetch via
git instead of bower. It won't manage updates though, but will do in a pinch.

<br>

## Tips

In OSX, use MacVim to use a better build of vim with support for Ruby, Python,
and other niceties.

```sh
$ brew install macvim --override-system-vim
```

<br>

## Thanks

MIT license

[#505]: https://github.com/bower/bower/issues/505
[pathogen]: https://github.com/tpope/vim-pathogen
[bower]: http://bower.io

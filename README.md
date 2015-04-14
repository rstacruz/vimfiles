# My vim files

vim setup managed by [vim-plug].

<br>

## Install

```
make link     # symlink to ~/.vim
make install  # install vim plugins
```

<br>

## Adding packages

```
# in vimrc.vim
Plug 'x/y'
:PlugInstall
```

```
make lock     # update ./bin/install
```

<br>

## Updating plugins

```
make update
```

<br>

## Tips

In OSX, use MacVim to use a better build of vim with support for Ruby, Python, Lua, and other niceties.

```sh
$ brew install macvim --override-system-vim --with-python3 --with-lua --with-luajit
```

<br>

## Thanks

MIT license

[vim-plug]: https://github.com/junegunn/vim-plug


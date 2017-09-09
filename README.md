# My vim files

vim setup managed by [vim-plug].

<br>

## Install

```sh
# Clone the repo anywhere. I like putting it in my ~/Config,
# but it can be anywhere you like.
git clone https://github.com/rstacruz/vimfiles.git
cd vimfiles
```

```sh
make link     # symlink to ~/.vim
make restore  # install vim plugins
```

<br>

## Adding packages

```sh
vim ~/.vimrc     # add 'Plug 'x/y''
make install     # update ./bin/install
```

<br>

## Updating plugins

```
make update
```

<br>

## Reference

```sh
make          # same as 'make install'
make install  # installs vim plugins and creates lockfile
make help     # show key bindings
make link     # link the config to ~/.vim and ~/.config/nvim
make upgrade  # updates plugins (dangerous)
make restore  # restore from lockfile
```
<br>

## Minimal mode

When Vim is started as the Git editor, it defaults to minimal mode where it doesn't load many of the plugins.

To force this behavior elsewhere, you can use `env GIT_DIR='.' vim`.

<br>

## Tips

In OSX, use MacVim to use a better build of vim with support for Ruby, Python, Lua, and other niceties.

```sh
brew install macvim ---with-override-system-vim --with-python3 --with-lua --with-luajit
```

Or use Neovim!

<br>

## Thanks

MIT license

[vim-plug]: https://github.com/junegunn/vim-plug


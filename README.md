# Rico's vim files

> [@rstacruz](https://ricostacruz.com)'s Vim setup managed by [vim-plug]

[vim-plug]: https://github.com/junegunn/vim-plug

## Installing

Clone the repo anywhere. _(I like putting it in my ~/Config,
but it can be anywhere you like.)_

```sh
git clone https://github.com/rstacruz/vimfiles.git
cd vimfiles
```

Symlink it to `~/.vim`.

```sh
make link
```

Install Vim plugins from the lockfile.

```sh
make restore
```

## How to use

There's magical documentation at:

```
make help
```

## Adding packages

```sh
vim ~/.vimrc     # add 'Plug 'x/y''
make install     # update ./bin/install
```

## Reference

```sh
make          # same as 'make install'
make install  # installs vim plugins and creates lockfile
make help     # show key bindings
make link     # link the config to ~/.vim and ~/.config/nvim
make upgrade  # updates plugins (dangerous)
make restore  # restore from lockfile
```

## Minimal mode

When Vim is started as the Git editor, it defaults to minimal mode where it doesn't load many of the plugins.

To force this behavior elsewhere, you can use `env GIT_DIR='.' vim`.

## Tips

In OSX, use MacVim to use a better build of vim with support for Ruby, Python, Lua, and other niceties.

```sh
brew install macvim ---with-override-system-vim --with-python3 --with-lua --with-luajit
```

Or use Neovim!

## Thanks

**vimfiles** © 2017+, Rico Sta. Cruz. Released under the [MIT] License.<br>
Authored and maintained by Rico Sta. Cruz with help from contributors ([list][contributors]).

> [ricostacruz.com](http://ricostacruz.com) &nbsp;&middot;&nbsp;
> GitHub [@rstacruz](https://github.com/rstacruz) &nbsp;&middot;&nbsp;
> Twitter [@rstacruz](https://twitter.com/rstacruz)

[![](https://img.shields.io/github/followers/rstacruz.svg?style=social&label=@rstacruz)](https://github.com/rstacruz) &nbsp;
[![](https://img.shields.io/twitter/follow/rstacruz.svg?style=social&label=@rstacruz)](https://twitter.com/rstacruz)

[MIT]: http://mit-license.org/
[contributors]: http://github.com/rstacruz/vimfiles/contributors

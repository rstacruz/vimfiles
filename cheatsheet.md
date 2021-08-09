# Vim customisations cheatsheet

### `Enter` - Nav layer bindings

| Key                    | Description                        |
| ---------------------- | ---------------------------------- |
| `<enter>` `x`          | Close window (`del`)               |
| `<enter>` `X`          | Close window (force) (`shift-del`) |
|                        |                                    |
| `<enter>` `← ↓ ↑ →`    | Focus window                       |
| `<enter>` `1 2 3 .. 8` | Focus window                       |
|                        |                                    |
| `<enter>` `t`          | New tab                            |
| `<enter>` `home/end`   | Change tab                         |
|                        |                                    |
| `<enter>` `<esc>`      | New terminal (float)               |
| `<enter>` `S/V/T`      | New terminal (split, vert, tab)    |
| `<enter>` `s/v`        | Split window (horiz, vert)         |

### `f` - File...

| Key             | Description             |
| --------------- | ----------------------- |
| `<leader>` `fa` | Save                    |
| `<leader>` `fs` | Save without formatting |
| `<leader>` `fr` | Revert                  |
|                 |                         |
| `<leader>` `fy` | Copy path               |
| `<leader>` `fY` | Copy path (full)        |
| `<leader>` `fb` | Browse (ranger)         |

### `g` - Git...

| Key              | Description         |
| ---------------- | ------------------- |
| `<leader>` `gs`  | Status              |
| `<leader>` `gc`  | Commit              |
| `<leader>` `gb`  | Blame               |
|                  |                     |
| `<leader>` `gp`  | Push                |
| `<leader>` `gP`  | Push (force)        |
|                  |                     |
| `<leader>` `gy`  | Copy GitHub link    |
| `<leader>` `ghh` | Open in GitHub      |
| `<leader>` `ghp` | Open pull request   |
| `<leader>` `ghP` | Create pull request |

### `fe` - Settings...

| Key              | Description         |
| ---------------- | ------------------- |
| `<leader>` `fec` | Edit customisations |
| `<leader>` `fei` | Edit init.vim       |
| `<leader>` `fek` | Edit key bindings   |

### `q` - Close...

| Key             | Description                 |
| --------------- | --------------------------- |
| `<leader>` `qq` | Quit vim                    |
| `<leader>` `qr` | Reset workspace (close all) |
| `<leader>` `qx` | Close window (force)        |

### `p` - Pick...

| Key             | Description             |
| --------------- | ----------------------- |
| `<leader>` `pf` | Files... (`ctrl-p`)     |
| `<leader>` `pb` | Buffers...              |
| `<leader>` `p*` | Search for this word... |
| `<leader>` `ps` | Git status...           |

### `k` - Editor...

| Key             | Description            |
| --------------- | ---------------------- |
| `<leader>` `ka` | Toggle autofold        |
| `<leader>` `kc` | Toggle showing context |
| `<leader>` `kz` | Zen mode               |

### Other...

| Key             | Description            |
| --------------- | ---------------------- |
| `<leader>` `*`  | Search word in project |
| `<leader>` `mp` | Markdown image paste   |

### `yo` - Toggle features

| Toggle | Description           |
| ------ | --------------------- |
| `yon`  | Line numbers          |
| `yor`  | Relative line numbers |
| `yow`  | Word wrap             |
| `yoc`  | Cursor line           |
| `yov`  | Virtual editing       |
| `yog`  | Git gutter (custom)   |

These features are provided by [vim-unimpaired](https://github.com/tpope/vim-unimpaired).

## Commands

```
:Vista ctags   - open outline sidebar (markdown)
:Vista coc     - open outline sidebar (js)
```

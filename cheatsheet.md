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

### `x` - Close...

| Key             | Description                 |
| --------------- | --------------------------- |
| `<leader>` `xx` | Close window (force)        |
| `<leader>` `xc` | Close window                |
| `<leader>` `xs` | Close window (save)         |
| `<leader>` `xq` | Quit vim                    |
| `<leader>` `xz` | Reset workspace (close all) |

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

### `h` - Hunks (gitsigns)

| Key             | Description                        |
| --------------- | ---------------------------------- |
| `<leader>` `hb` | Blame line (show previous version) |
| `<leader>` `hs` | Stage hunk                         |
| `<leader>` `hS` | Stage all                          |
| `<leader>` `hu` | Undo stage hunk                    |

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

## `,` - Localleader

| Filetype   | Key  | Description    |
| ---------- | ---- | -------------- |
| `markdown` | `,p` | Paste image    |
| `vim`      | `,s` | Load this file |

## Insert mode shortcuts

| Toggle | Description                   |
| ------ | ----------------------------- |
| `;di`  | Date ISO (2021-09-02)         |
| `;dl`  | Date local (Wed 15 Sep)       |
| `;dw`  | Date weekday (2021-09-15 Wed) |
|        |                               |
| `;ok`  | ✓                             |
| `;::`  | ∷                             |

## Commands

```sh
# Vista
:Vista ctags   - open outline sidebar (markdown)
:Vista coc     - open outline sidebar (js)

# Close buffers
:Bdelete! hidden

# ALE
:ALEHover
:ALEFindReferences
:ALERename
:ALECodeAction
:ALEGoToDefinition
:ALENext
:ALEPrevious

# Obsession
:Obsession .        # write session to ./Session.vim
:Obsession!         # stop writing session
vim -S Session.vim  # load the session

# todo.txt
,sd      # sort by date
,sdd     # sort by due date
,s+      # sort by project
,s@      # sort by context
,x       # mark as done
,a ,b ,c # priority
,d       # update date
,D       # move done to done.txt
```

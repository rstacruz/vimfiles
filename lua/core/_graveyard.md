## Plugins

Some plugins I used to use, but don't anymore

```lua
  -- bufferline.nvim has more features
  use "romgrk/barbar.nvim"

  -- can just configure things manually instead
  use "williamboman/mason-lspconfig.nvim"

  -- Scrollbars. Works great but the scrollbars don't reposition well
  -- when using with &winwidth. `nvim-scrollview` is a great alternative
  use "Xuyuanp/scrollbar.nvim"

  -- Integration with zoxide dir changer. But I'd rather use fish's z
  use "nanotee/zoxide.vim"

  -- Searcheable directory of keymaps. I just don't use it
  use "mrjones2014/legendary.nvim"
```

## Indent blankline: different lines

```lua
-- Indent blankline
vim.g.indent_blankline_char_list = { "┊", "┆", "│" }
```

## Harpoon keybindings

```lua
require("which-key").register({
  ["<leader>m"] = { name = "[m]arks..." },
  ["<leader>ma"] = { "<cmd>lua require('harpoon.mark').add_file()<cr>", "[a]dd bookmark" },
  ["<leader>m."] = { "<cmd>lua require('harpoon.cmd-ui').toggle_quick_menu()<cr>", "Bookmark commands... [.]" },
})
```

## Window focus keybindings

```lua
-- Keybindings for switching around
require("which-key").register({
  ["<cr>1"] = { "<c-w>t", "Focus pane 1" },
  ["<cr>2"] = { ":2wincmd w<cr>", "Focus pane 2" },
  ["<cr>3"] = { ":3wincmd w<cr>", "Focus pane 3" },
  ["<cr>4"] = { ":4wincmd w<cr>", "Focus pane 4" },
  ["<cr>5"] = { ":5wincmd w<cr>", "Focus pane 5" },
  ["<cr>6"] = { ":6wincmd w<cr>", "Focus pane 6" },
  ["<cr>7"] = { ":7wincmd w<cr>", "Focus pane 7" },
  ["<cr>8"] = { ":8wincmd w<cr>", "Focus pane 8" },
  ["<cr>0"] = { "<c-w>b", "Focus last pane" },
})
```

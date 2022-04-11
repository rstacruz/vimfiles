local wk = require('which-key')
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- Keymap: general
map('n', [[gs]], [[:%s~~]], opts)
map('v', [[gs]], [[:s~~]], opts)
map('n', [[-]], [[:NvimTreeFindFile<cr>]], opts)
map('n', [[+]], [[za]], opts)

-- Keymap: ctrl
map('n', [[<c-s>]], [[:w<cr>]], opts)
map('i', [[<c-s>]], [[<esc>:w<cr>]], opts)
map('n', [[<c-p>]], [[:Telescope find_files<cr>]], opts)
map('i', [[<c-v>]], [[<esc>:set paste<cr>a<c-r>+<esc>:set nopaste<cr>a]], opts) -- Paste
map('v', [[<c-c>]], [["+y]], opts) -- Paste

-- Keymap: terminal
map('t', [[<esc>]], [[<c-\><c-n>]], opts) -- Terminal esc

map('n', [[<del>]], [[<c-w>q]], opts)

-- Keymap: cr
wk.register({
  ['<left>'] = { '<c-w>h', 'Focus left' },
  ['<right>'] = { '<c-w>h', 'Focus right' },
  ['<down>'] = { '<c-w>j', 'Focus down' },
  ['<up>'] = { '<c-w>k', 'Focus up' },
  t = { ':tabnew<cr>', 'New tab' }
}, { prefix = "<cr>" })

-- Keymap: leader
wk.register({
  ['.'] = { ":term<cr>", "Open terminal here" },
  ['*'] = { ":GG <c-r><c-w><cr>", "Search" },
  w = {
    name = 'Window...',
    H = { '<c-w>H', 'Move ←' },
    J = { '<c-w>J', 'Move ↓' },
    K = { '<c-w>K', 'Move ↑' },
    L = { '<c-w>L', 'Move →' },
    h = { '<c-w>h', 'Focus ←' },
    j = { '<c-w>j', 'Focus ↓' },
    k = { '<c-w>k', 'Focus ↑' },
    l = { '<c-w>l', 'Focus →' },
    s = { '<c-w>s', 'Split horizontal' },
    v = { '<c-w>v', 'Split vertical' },
    q = { '<c-w>q', 'Close' },
  },
  p = {
    name = "Pick...",
    b = { ":Telescope buffers<cr>", "Buffers" }
  },
  x = {
    name = "Exit...",
    s = { ":SClose<cr>", "Close session" }
  },
  f = {
    name = "File...",
    w = { ":w<cr>", "Save" },
    s = { ":noa w<cr>", "Save without formatting" },
    r = { ":e!<cr>", "Revert" }
  },
  o = {
    name = "Options...",
    f = { ":NvimTreeToggle<cr>", "Toggle file explorer" },
    s = { ":tab split ~/.config/nvim/init.lua<cr>", "Edit settings" },
    k = { ":tab split ~/.config/nvim/lua/keymaps.lua<cr>", "Edit keybindings" },
    i = { ":luafile ~/.config/nvim/init.lua<cr>:PaqSync<cr>", "Sync plugins" },
  },
  g = {
    name = "Git...",
    s = { ":Git<cr>", "Git status" }
  },
}, { prefix = "<Leader>" })

-- lcoalleader: lua
map('n', [[<localleader>s]], [[:w<cr>:luafile %<cr>]], opts)

-- Etc
map('n', [[co]], [[yo]], {}) -- Unimpaired

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- Keymap: general
map('n', [[gs]], [[:%s~~]], opts)
map('v', [[gs]], [[:s~~]], opts)
map('n', [[-]], [[:NvimTreeFocus<cr>]], opts)
map('n', [[+]], [[za]], opts)

-- Keymap: ctrl
map('n', [[<c-s>]], [[:w<cr>]], opts)
map('n', [[<c-p>]], [[:Telescope find_files<cr>]], opts)
map('i', [[<c-v>]], [[<esc>:set paste<cr>a<c-r>+<esc>:set nopaste<cr>a]], opts) -- Paste
map('v', [[<c-c>]], [["+y]], opts) -- Paste

-- Keymap: cr
map('n', [[<cr><right>]], [[<c-w>l]], opts)
map('n', [[<cr><left>]], [[<c-w>h]], opts)
map('n', [[<cr><up>]], [[<c-w>k]], opts)
map('n', [[<cr><down>]], [[<c-w>j]], opts)
map('n', [[<del>]], [[<c-w>q]], opts)

-- Keymap: leader
map('n', [[<leader>*]], [[:tabnew<cr>]], opts)

-- Keymap: leader w
map('n', [[<leader>wH]], [[<c-w>H]], opts)
map('n', [[<leader>wJ]], [[<c-w>J]], opts)
map('n', [[<leader>wK]], [[<c-w>]], opts)
map('n', [[<leader>wL]], [[<c-w>L]], opts)
map('n', [[<leader>ws]], [[<c-w>s]], opts)
map('n', [[<leader>wv]], [[<c-w>v]], opts)
map('n', [[<leader>wq]], [[<c-w>q]], opts)

-- Keymap: leader v [vim]
map('n', [[<leader>vs]], [[:tab split ~/.config/nvim/init.lua<cr>]], opts) -- [vs] :: Vim settings
map('n', [[<leader>vk]], [[:tab split ~/.config/nvim/lua/keymaps.lua<cr>]], opts) -- [vk] :: Vim keybindings
map('n', [[<leader>vr]], [[:luafile ~/.config/nvim/init.lua<cr>:PaqSync<cr>]], opts) -- [vr] :: Vim reload

-- Keymap: leader u [ui]
map('n', [[<leader>ub]], [[:NvimTreeToggle<cr>]], opts)
map('n', [[<leader>ue]], [[:NvimTreeToggle<cr>]], opts)

-- lcoalleader: lua
map('n', [[<localleader>s]], [[:w<cr>:luafile %<cr>]], opts)

-- Etc
map('n', [[co]], [[yo]], {}) -- Unimpaired

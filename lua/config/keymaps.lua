-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- find files (default: spc-spc)
vim.keymap.set("n", "<c-p>", "<cmd>Telescope find_files theme=dropdown<cr>", { desc = "Find Files (root dir)" })

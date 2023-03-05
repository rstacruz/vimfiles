local Util = require("lazyvim.util")

-- Keymaps are automatically loaded on the VeryLazy evenlt
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- +y to copy to clipboard
vim.keymap.set("n", "+", '"+')
vim.keymap.set("v", "+", '"+')
vim.keymap.set("n", "<Del>", "<cmd>bw!<cr>")

-- search-and-replace
vim.keymap.set("n", "gs", ":%s~~")
vim.keymap.set("v", "gs", ":s~~")
vim.keymap.set("n", "g1", "<cmd>wincmd t<cr>")
vim.keymap.set("n", "g2", "<cmd>wincmd t | wincmd w<cr>")
vim.keymap.set("n", "g3", "<cmd>wincmd t | 3wincmd w<cr>")
vim.keymap.set("n", "g4", "<cmd>wincmd t | 4wincmd w<cr>")
vim.keymap.set("n", "g5", "<cmd>wincmd t | 5wincmd w<cr>")
vim.keymap.set("n", "g6", "<cmd>wincmd t | 6wincmd w<cr>")

-- toggle fold
-- vim.keymap.set("n", "-", "za")
vim.keymap.set("n", "-", "<cmd>Neotree focus<cr>", { desc = "Focus on neotree" })

-- find files (default: spc-spc)
vim.keymap.set("n", "<c-p>", Util.telescope("files"), { desc = "Find Files (root dir)" })

-- Keymaps (default: leader-sk)
vim.keymap.set("n", "<f1>", "<cmd>Telescope keymaps<cr>", { desc = "Key Maps" })

-- More lazygit
vim.keymap.set("n", "<leader>gis", function()
  Util.float_term({ "lazygit", "status" }, { cwd = Util.get_root() })
end, { desc = "Lazygit status (root dir)" })

-- Scratchpad
vim.keymap.set("n", "<leader>!s", "<cmd>split ~/.scratchpad<cr><C-w>H", { desc = "Open scratchpad" })

-- I prefer these to navigate rather than resize
vim.keymap.set("n", "<C-Up>", "<C-w>j", { desc = "Go to upper window" })
vim.keymap.set("n", "<C-Down>", "<C-w>k", { desc = "Go to lower window" })
vim.keymap.set("n", "<C-Left>", "<C-w>h", { desc = "Go to left window" })
vim.keymap.set("n", "<C-Right>", "<C-w>l", { desc = "Go to right window" })

-- Substitute for H/L.
vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })

-- I don't know what to rebind these to lol
-- vim.keymap.set("n", "<C-Up>", "<cmd>resize +10<cr>", { desc = "Increase window height" })
-- vim.keymap.set("n", "<C-Down>", "<cmd>resize -10<cr>", { desc = "Decrease window height" })
-- vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -10<cr>", { desc = "Decrease window width" })
-- vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +10<cr>", { desc = "Increase window width" })

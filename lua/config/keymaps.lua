local Util = require("lazyvim.util")

-- Keymaps are automatically loaded on the VeryLazy evenlt
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- +y to copy to clipboard
vim.keymap.set("n", "+", '"+')
vim.keymap.set("v", "+", '"+')

-- toggle fold
vim.keymap.set("n", "-", "zo")

-- find files (default: spc-spc)
vim.keymap.set("n", "<c-p>", Util.telescope("files"), { desc = "Find Files (root dir)" })

-- Focus neotree (like spc-e)
vim.keymap.set("n", "-", "<cmd>Neotree focus<cr>", { desc = "Focus neotree" })

-- More lazygit
vim.keymap.set("n", "<leader>gis", function()
  Util.float_term({ "lazygit", "status" }, { cwd = Util.get_root() })
end, { desc = "Lazygit status (root dir)" })

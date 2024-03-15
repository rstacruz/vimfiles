local Util = require("lazyvim.util")

-- Keymaps are automatically loaded on the VeryLazy evenlt
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Paste over selection without updating the register
-- `_p` restores the default behaviour
vim.keymap.set("v", "p", '"_dP')
vim.keymap.set("v", "_p", "p")

vim.keymap.set("i", "<a-bs>", "<c-w>", { desc = "Delete word" })

vim.keymap.set("n", "<leader>fy", [[:let @+=@% | echo '→ ' . @%<cr>]], { desc = " Copy current path" })
vim.keymap.set(
  "n",
  "<leader>fYp",
  [[:let @+=expand('%:p') | echo '→ ' . expand('%:p')<cr>]],
  { desc = " Copy full path" }
)
vim.keymap.set(
  "n",
  "<leader>fYt",
  [[:let @+=expand('%:t') | echo '→ ' . expand('%:t')<cr>]],
  { desc = " Copy basename" }
)

-- Quicker shortcut than 'leader-qq'
vim.keymap.set("n", "<leader>Q", "<cmd>qa<cr>", { desc = "Quit all" })

-- Show full diagnostic, because virtual text can be too sparse
vim.keymap.set("n", "<leader>xk", "<cmd>lua vim.diagnostic.open_float()<cr>", { desc = "Show full diagnostic message" })

-- +y to copy to clipboard
vim.keymap.set("n", "+", '"+')
vim.keymap.set("v", "+", '"+')

-- close/destroy
vim.keymap.set("n", "<Del>", "<cmd>bw!<cr>")
vim.keymap.set("n", "<bs>", "<cmd>q<cr>")

-- search-and-replace
vim.keymap.set("n", "gs", ":%s~~")
vim.keymap.set("v", "gs", ":s~~")

-- code action (like leader-ca)
vim.keymap.set("n", "g.", vim.lsp.buf.code_action, { desc = "Code action" })

-- Terminal escape
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("t", "<Esc><Esc>", "<Esc>")
vim.keymap.set("t", "<a-`>", "<C-\\><C-n><cmd>ToggleTerm<cr>")
vim.keymap.set("n", "<a-`>", "<cmd>ToggleTerm<cr>")

-- Toggles
vim.keymap.set("n", "<leader>uV", function()
  vim.o.virtualedit = vim.o.virtualedit == "all" and "none" or "all"
  vim.notify("Virtual edit: " .. vim.o.virtualedit)
end, { desc = "Toggle virtualedit" })

vim.keymap.set("n", "<leader>uL", function()
  vim.o.cursorline = not vim.o.cursorline
end, { desc = "Toggle cursorline" })

vim.keymap.set("n", "<leader>ur", function()
  vim.o.relativenumber = not vim.o.relativenumber
end, { desc = "Toggle relativenumber" })

vim.keymap.set("n", "<leader>uc", function()
  local prev = vim.o.conceallevel
  local next_value = prev + 1
  vim.o.conceallevel = next_value == 4 and 0 or next_value
  local descriptions = {
    [0] = "0 (No conceal)",
    [1] = "1 (Replace with one char)",
    [2] = "2 (Replace with one char, or hide)",
    [3] = "3 (Completely hide)",
  }
  vim.notify("Conceal level: " .. descriptions[vim.o.conceallevel])
end, { desc = "Adjust conceal level" })

-- switch to pane
vim.keymap.set("n", "g1", "<cmd>wincmd t<cr>")
vim.keymap.set("n", "g2", "<cmd>wincmd t | wincmd w<cr>")
vim.keymap.set("n", "g3", "<cmd>wincmd t | 3wincmd w<cr>")
vim.keymap.set("n", "g4", "<cmd>wincmd t | 4wincmd w<cr>")
vim.keymap.set("n", "g5", "<cmd>wincmd t | 5wincmd w<cr>")
vim.keymap.set("n", "g6", "<cmd>wincmd t | 6wincmd w<cr>")

-- find files (default: spc-spc)
vim.keymap.set("n", "<c-p>", Util.telescope("files"), { desc = "Find Files (root dir)" })

-- Keymaps (default: leader-sk)
vim.keymap.set("n", "<f1>", "<cmd>Telescope keymaps<cr>", { desc = "Key Maps" })

-- Scratchpad
vim.keymap.set("n", "<leader>!s", "<cmd>split ~/.scratchpad.md<cr><C-w>H", { desc = "Open scratchpad" })
vim.keymap.set("n", "<leader>!b", "<cmd>split ~/.board.md<cr><C-w>H", { desc = "Open board" })

-- I prefer these to navigate rather than resize
vim.keymap.set("n", "<C-Up>", "<C-w>j", { desc = "Go to upper window" })
vim.keymap.set("n", "<C-Down>", "<C-w>k", { desc = "Go to lower window" })
vim.keymap.set("n", "<C-Left>", "<C-w>h", { desc = "Go to left window" })
vim.keymap.set("n", "<C-Right>", "<C-w>l", { desc = "Go to right window" })

-- Substitute for H/L
vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })

-- I don't know what to rebind these to lol
-- vim.keymap.set("n", "<C-Up>", "<cmd>resize +10<cr>", { desc = "Increase window height" })
-- vim.keymap.set("n", "<C-Down>", "<cmd>resize -10<cr>", { desc = "Decrease window height" })
-- vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -10<cr>", { desc = "Decrease window width" })
-- vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +10<cr>", { desc = "Increase window width" })

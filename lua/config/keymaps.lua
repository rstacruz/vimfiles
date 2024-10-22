-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- find files (default: spc-spc)
vim.keymap.set("n", "<c-p>", "<cmd>Telescope find_files theme=dropdown<cr>", { desc = "Find Files (root dir)" })

--- Keymaps (default: leader-sk)
vim.keymap.set("n", "<f1>", "<cmd>Telescope keymaps<cr>", { desc = "Key Maps" })

vim.keymap.set("n", "<leader>fya", function()
  local str = vim.fn.expand("%:p")
  vim.fn.setreg('"', str)
  vim.fn.setreg("+", str)
  vim.notify("→ " .. str)
end, { desc = " Copy absolute path" })

vim.keymap.set("n", "<leader>fyr", function()
  local str = vim.fn.expand("%:.")
  vim.fn.setreg('"', str)
  vim.fn.setreg("+", str)
  vim.notify("→ " .. str)
end, { desc = " Copy relative path" })

vim.keymap.set("n", "<leader>fyt", function()
  local str = vim.fn.expand("%:t")
  vim.fn.setreg('"', str)
  vim.fn.setreg("+", str)
  vim.notify("→ " .. str)
end, { desc = " Copy basename" })

vim.keymap.set("n", "<leader>fyw", function()
  local str = "[[" .. vim.fn.expand("%:t:r") .. "]]"
  vim.fn.setreg('"', str)
  vim.fn.setreg("+", str)
  vim.notify("→ " .. str)
end, { desc = " Copy wiki markdown link" })

-- search-and-replace
vim.keymap.set("n", "gs", ":%s~~")
vim.keymap.set("v", "gs", ":s~~")

-- Terminal escape
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("t", "<Esc><Esc>", "<Esc>")
vim.keymap.set("t", "<a-`>", "<C-\\><C-n><cmd>ToggleTerm<cr>")
vim.keymap.set("n", "<a-`>", "<cmd>ToggleTerm<cr>")

-- vscode
if vim.g.vscode then
  vim.keymap.set(
    "n",
    "]d",
    "<cmd>lua require('vscode').call('editor.action.marker.next')<cr>",
    { desc = "Next Diagnostic" }
  )
  vim.keymap.set(
    "n",
    "[d",
    "<cmd>lua require('vscode').call('editor.action.marker.previous')<cr>",
    { desc = "Prev Diagnostic" }
  )
  vim.keymap.set(
    "n",
    "gr",
    "<cmd>lua require('vscode').call('editor.action.goToReferences')<cr>",
    { desc = "Goto References" }
  )
  vim.keymap.set(
    "n",
    "gd",
    "<cmd>lua require('vscode').call('editor.action.revealDefinition')<cr>",
    { desc = "Goto Definition" }
  )
  vim.keymap.set(
    "n",
    "gy",
    "<cmd>lua require('vscode').call('editor.action.goToTypeDefinition')<cr>",
    { desc = "Goto Type Definition" }
  )
end

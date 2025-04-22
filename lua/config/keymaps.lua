-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
--
-- -- Scratchpad
vim.keymap.set("n", "<leader>!s", "<cmd>split ~/.scratchpad.md<cr><C-w>H", { desc = "Open scratchpad" })
vim.keymap.set("n", "<leader>!t", "<cmd>hi Normal guibg=NONE ctermbg=NONE", { desc = "Make window transparent" })

-- System clipboard
vim.keymap.set("v", "<C-c>", '"+y', { desc = "Copy to clipboard" })
vim.keymap.set("i", "<C-S-v>", '"+p', { desc = "Paste from clipboard" })

-- spelling
vim.keymap.set("i", "<C-l>", "<C-g>u<Esc>[s1z=`]a<C-g>u", { desc = "Correct spelling under cursor" })

-- Fix all the problems
vim.keymap.set("n", "<leader>cx", "<cmd>LspRestart<cr>", { desc = "Restart LSP" })

-- Code action (default: leader-ca)
vim.keymap.set({ "n", "v" }, "g.", vim.lsp.buf.code_action, { desc = "Code Action" })

-- Close
vim.keymap.set("n", "<bs>", "<cmd>:q<cr>", { desc = "Close" })

-- Fold level
vim.keymap.set("n", "z2", "zMzr", { desc = "Fold level 2" })
vim.keymap.set("n", "z3", "zMzrzr", { desc = "Fold level 3" })
vim.keymap.set("n", "zV", "zMzv", { desc = "Isolate fold" })
vim.keymap.set("n", "z.", "zczO", { desc = "Unfold siblings" })

-- Make `23,` go to line 23. Easier to type than `23G`
vim.keymap.set("n", ",", "G", { desc = "Go to line" })
vim.keymap.set("v", ",", "G", { desc = "Go to line" })

-- lazygit (default: leader-gg)
vim.keymap.set("n", "<leader>G", function()
  Snacks.lazygit({ cwd = LazyVim.root.git() })
end, { desc = "Lazygit (Root Dir)" })

-- find files (default: spc-spc)
vim.keymap.set("n", "<c-p>", function()
  Snacks.picker.git_files({ layout = { preset = "vscode" }, untracked = true })
end, { desc = "Find Files (root dir)" })

-- old files (default: leader-fR)
vim.keymap.set("n", "<leader>o", '<cmd>lua LazyVim.pick("oldfiles")()<cr>', { desc = "Find Files (root dir)" })

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

vim.keymap.set("n", "<leader>fyr", function()
  local str = vim.fn.expand("%:.")
  vim.fn.setreg('"', str)
  vim.fn.setreg("+", str)
  vim.notify("→ " .. str)
end, { desc = " Copy relative path" })

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
vim.keymap.set("n", "gS", ":%s~~")
vim.keymap.set("v", "gS", ":s~~")

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

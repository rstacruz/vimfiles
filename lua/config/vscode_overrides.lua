local M = {}

M.setup = function()
  if not vim.g.vscode then
    return
  end

  -- https://github.com/vscode-neovim/vscode-neovim/pull/502#issuecomment-831682643
  -- stylua: ignore start
  vim.api.nvim_set_keymap("n", "za", '<Cmd>call VSCodeNotify("editor.toggleFold")<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "zR", '<Cmd>call VSCodeNotify("editor.unfoldAll")<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "zM", '<Cmd>call VSCodeNotify("editor.foldAll")<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "zo", '<Cmd>call VSCodeNotify("editor.unfold")<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "zO", '<Cmd>call VSCodeNotify("editor.unfoldRecursively")<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "zc", '<Cmd>call VSCodeNotify("editor.fold")<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "zC", '<Cmd>call VSCodeNotify("editor.foldRecursively")<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "zM", '<Cmd>call VSCodeNotify("editor.foldAll")<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "zV", '<Cmd>call VSCodeNotify("editor.foldAllExcept")<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "z1", '<Cmd>call VSCodeNotify("editor.foldLevel1")<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "z2", '<Cmd>call VSCodeNotify("editor.foldLevel2")<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "z3", '<Cmd>call VSCodeNotify("editor.foldLevel3")<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "z4", '<Cmd>call VSCodeNotify("editor.foldLevel4")<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "z5", '<Cmd>call VSCodeNotify("editor.foldLevel5")<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "z6", '<Cmd>call VSCodeNotify("editor.foldLevel6")<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "z7", '<Cmd>call VSCodeNotify("editor.foldLevel7")<CR>', { noremap = true, silent = true })
  -- stylua: ignore end
end

return M

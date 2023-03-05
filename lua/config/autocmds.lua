-- Defaults: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
require("etc.autosize").setup()

-- Spectre: no line numbers
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("custom_spectre", { clear = true }),
  pattern = { "spectre_panel" },
  callback = function()
    vim.wo.number = false -- no line numbers
  end,
})

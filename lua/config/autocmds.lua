-- Defaults: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

vim.api.nvim_create_autocmd("FocusGained", {
  group = vim.api.nvim_create_augroup("autoreload_on_focus", { clear = true }),
  pattern = { "spectre_panel" },
  callback = function()
    vim.cmd("checktime")
  end,
})

-- Spectre: no line numbers
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("custom_spectre", { clear = true }),
  pattern = { "spectre_panel" },
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("custom_foldexpr", { clear = true }),
  pattern = { "typescript", "javascript", "markdown", "lua", "typescriptreact", "sh" },
  callback = function()
    -- https://github.com/nvim-treesitter/nvim-treesitter#folding
    vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
    vim.opt_local.foldmethod = "expr"
    vim.opt_local.foldenable = false
    -- vim.opt_local.formatoptions:remove({ "r", "o" })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("custom_markdown", { clear = true }),
  pattern = { "markdown" },
  callback = function()
    vim.opt_local.cursorline = false -- doesn't look good when used with headline.nvim. toggle with leader-uL
    vim.opt_local.spell = false -- I find spellcheck only useful when writing prose. toggle with leader-us
    vim.opt_local.wrap = false -- inline links make wrapping very weird. toggle with leader-uw
    vim.opt_local.number = false -- toggle with leader-ul
    vim.opt_local.relativenumber = false
  end,
})

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  group = vim.api.nvim_create_augroup("custom_terminal", { clear = true }),
  callback = function()
    -- something
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.cursorline = false
    vim.cmd("startinsert")
  end,
})

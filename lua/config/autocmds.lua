-- Defaults: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
require("etc.autosize").setup()

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
  pattern = { "typescript", "javascript" },
  callback = function()
    -- https://github.com/nvim-treesitter/nvim-treesitter#folding
    vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
    vim.opt_local.foldmethod = "expr"
  end,
})

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  group = vim.api.nvim_create_augroup("custom_terminal", { clear = true }),
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.cursorline = false
    vim.cmd("startinsert")
  end,
})

vim.defer_fn(function()
  require("etc.autotheme").setup(vim.tbl_extend("force", {
    mode = "auto", -- dark | light | auto
    dark = { colorscheme = "rosebones" },
    light = { colorscheme = "zenbones" },
  }, vim.g.theme or {}))
end, 0)

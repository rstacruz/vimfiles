-- Defaults: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
require("etc.autosize").setup()

-- Save colorscheme on change
require("etc.persist_colorscheme").setup()

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
    vim.opt_local.foldenable = false
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

local function persist_colorscheme()
  local current_colorscheme = vim.g.colors_name

  local cache_path = vim.fn.stdpath("cache")
  local cache_file = cache_path .. "/colorscheme.lua"
  local file = io.open(cache_file, "w")

  file:write("vim.opt.background = '" .. vim.o.background .. "'")
  file:write("vim.cmd('colorscheme " .. vim.g.colors_name .. "')")
  file:close()
end

local function load_persisted_colorscheme()
  local cache_path = vim.fn.stdpath("cache")
  local cache_file = cache_path .. "/colorscheme.lua"

  -- check if cache_file exists
  if vim.fn.filereadable(cache_file) == 1 then
    dofile(cache_file)
  end
end
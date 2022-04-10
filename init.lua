require 'paq' {
  -- Paq (package manager)
  'savq/paq-nvim';

  -- Language
  'nvim-treesitter/nvim-treesitter';
  'hrsh7th/nvim-compe';
  'neovim/nvim-lspconfig';
  'mhartington/formatter.nvim';
  'williamboman/nvim-lsp-installer';

  -- Themes
  'rstacruz/vim-microtone';

  -- Goodies
  'tpope/vim-unimpaired'; -- Toggle key bindings
  'tpope/vim-commentary'; -- Comments
  'tpope/vim-sleuth'; -- Detect indents automatically
  'thinca/vim-visualstar';
  'mhinz/vim-startify';
  'nvim-lua/plenary.nvim'; -- for Telescope
  'nvim-telescope/telescope.nvim';
}

function plugin(module_name, callback)
  local status, mod = pcall(require, module_name)
  if status then callback(mod) end
end

-- Plugin: treesitter
plugin('nvim-treesitter.configs', function(mod)
  mod.setup {
    ensure_installed = { 'c', 'cpp', 'javascript', 'css', 'lua', },
    highlight = {
      enable = true,
      use_languagetree = true
    },
  }
end)

-- Plugin: formatter
plugin('formatter', function(mod)
  mod.setup {}
  vim.api.nvim_command([[
    augroup FormatAutogroup
    autocmd! BufWritePost *.js,*.ts,*.tsx FormatWrite
    augroup END
  ]])
end)

-- Plugin: compe
plugin('compe', function(mod)
  mod.setup {
    source = {
      path = true;
      buffer = true;
      nvim_lsp = true;
      nvim_lua = true;
    }
  }
end)

-- Plugin: startify
vim.api.nvim_set_var('startify_custom_indices', {'1', '2', '3', '4', '5', '6', '7', '8', '9'})
vim.api.nvim_set_var('startify_custom_header', {'    Neovim'})
vim.api.nvim_command([[
let g:startify_lists = [ { 'type': 'dir', 'header': startify#pad(['Recent files']) } ]
]])

-- Vim settings
vim.opt.gdefault = true
vim.opt.mouse = 'a'
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.cmd 'color microtone'

-- Vim: terminal (no line numbers)
vim.api.nvim_command([[
  augroup TerminalCustomisations
  au! TermOpen * setlocal nonumber norelativenumber nocursorline
  au! TermOpen * startinsert
  augroup END
]])

-- Etc
require 'keymaps'
require 'plugin-lspconfig'

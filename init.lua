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
  'tpope/vim-fugitive'; -- Git
  'thinca/vim-visualstar';
  'michaeljsmith/vim-indent-object';
  'Xuyuanp/scrollbar.nvim';
  'mhinz/vim-startify';
  'nvim-lua/plenary.nvim'; -- for Telescope
  'nvim-telescope/telescope.nvim';
  'kyazdani42/nvim-tree.lua'; -- File explorer
  'kyazdani42/nvim-web-devicons';
  'Darazaki/indent-o-matic'; -- Detect indentation automatically
  'nvim-lualine/lualine.nvim';
  'rstacruz/vim-gitgrep';
  'folke/which-key.nvim';
  'folke/lsp-colors.nvim';
}

local function plugin(module_name, callback)
  local status, mod = pcall(require, module_name)
  if status then callback(mod) end
end

cmd = vim.api.nvim_command

-- Plugin: treesitter {{{
plugin('nvim-treesitter.configs', function(mod)
  mod.setup {
    ensure_installed = { 'c', 'cpp', 'javascript', 'css', 'lua', },
    highlight = {
      enable = true,
      use_languagetree = true
    },
  }
end)
-- }}}

-- Plugin: formatter {{{
plugin('formatter', function(mod)
  mod.setup {}
  vim.api.nvim_command([[
    augroup FormatAutogroup
    autocmd! BufWritePost *.js,*.ts,*.tsx FormatWrite
    augroup END
  ]])
end)
-- }}}

-- Plugin: compe {{{
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
-- }}}

-- Plugin: scrollbar {{{
plugin('scrollbar', function(mod)
  vim.api.nvim_command([[
    let g:scrollbar_max_size = 12
    let g:scrollbar_shape = { 'head': '█', 'body': '█', 'tail': '█', }
    let g:scrollbar_highlight = { 'head': 'LineNr', 'body': 'LineNr', 'tail': 'LineNr', }
  ]])

  cmd([[augroup ScrollbarInit]])
  cmd([[au!]])
  cmd([[autocmd WinScrolled,VimResized,QuitPre * silent! lua require('scrollbar').show()]])
  cmd([[autocmd WinEnter,FocusGained,BufEnter  * silent! lua require('scrollbar').show()]])
  cmd([[autocmd WinLeave,BufLeave,BufWinLeave,FocusLost,QuitPre * silent! lua require('scrollbar').clear()]])
  cmd([[augroup END]])
end)
-- }}}

-- Plugin: tree {{{
plugin('nvim-tree', function(mod)
  mod.setup { }
end)
-- }}}

-- Plugin: startify {{{
if vim.api.nvim_eval('exists(":Startify")') then
  vim.api.nvim_set_var('startify_custom_indices', {'1', '2', '3', '4', '5', '6', '7', '8', '9'})
  vim.api.nvim_set_var('startify_custom_header', {'    Neovim'})
  vim.api.nvim_set_var('startify_enable_unsafe', 1)
  vim.api.nvim_command([[
  let g:startify_lists = [ { 'type': 'dir', 'header': ['Recent files'] } ]
  ]])
end
-- }}}

-- Plugin: indent-o-matic {{{
plugin('indent-o-matic', function(mod)
  mod.setup { }
end)
-- }}}

-- Plugin: lualine {{{
plugin('lualine', function(mod)
  mod.setup {
    options = {
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
    },
    sections = {
      lualine_a = {
        {
          'mode',
          separator = { left = '' },
          right_padding = 2,
          fmt = function(str) return str:sub(1,3) end
        }
      },
      lualine_b = { 'filename' },
      lualine_c = {},
      lualine_x = {'filetype'},
      lualine_y = {'progress'},
      lualine_z = {
        { 'location', separator = { right = '' }, left_padding = 2 },
      },
    },
    tabline = {}
  }
end)
-- }}}

-- Plugin: which-key {{{
plugin('which-key', function(mod)
  mod.setup { }
end)
-- }}}

-- Plugin: LSP installer {{{
plugin('nvim-lsp-installer', function(lsp_installer)
  vim.api.nvim_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  lsp_installer.on_server_ready(function(server)
      local opts = {}
      -- (optional) Customize the options passed to the server
      -- if server.name == "tsserver" then
      --     opts.root_dir = function() ... end
      -- end

      server:setup(opts)
  end)
end)
-- }}}

-- Vim settings {{{
vim.opt.gdefault = true
vim.opt.mouse = 'a'
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.swapfile = false
vim.opt.showmode = false -- Don't show "-- INSERT --" in status line
vim.opt.timeoutlen = 200 -- For which-key
vim.opt.fillchars = { eob = '┄', vert = '┃' }
vim.cmd 'color microtone'
-- }}}

-- Customisation: terminal (no line numbers) {{{
cmd([[augroup TerminalCustomisations]])
cmd([[au!]])
cmd([[au TermOpen * setlocal nonumber norelativenumber nocursorline]])
cmd([[au TermOpen * startinsert]])
cmd([[augroup END]])
-- }}}

-- Etc
require 'keymaps'

-- vim:foldmethod=marker

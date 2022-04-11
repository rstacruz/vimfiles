PKGS = {
  "savq/paq-nvim", -- Paq package manager

  -- Language
  "nvim-treesitter/nvim-treesitter",
  "hrsh7th/nvim-compe",
  "neovim/nvim-lspconfig",
  "williamboman/nvim-lsp-installer",

  -- Themes
  "rstacruz/vim-microtone",

  -- File types
  "preservim/vim-markdown", -- Markdown

  -- Goodies
  "Darazaki/indent-o-matic", -- Detect indentation automatically
  "Xuyuanp/scrollbar.nvim",
  "folke/lsp-colors.nvim", -- Infer some colours needed for LSP
  "folke/which-key.nvim", -- Menu when pressing [space]
  "jrudess/vim-foldtext", -- Improve appearance of fold text
  "kyazdani42/nvim-tree.lua", -- File explorer
  "kyazdani42/nvim-web-devicons",
  "lewis6991/gitsigns.nvim", -- Git indicators on the gutter
  "lewis6991/impatient.nvim", -- Improve startup time by optimising Lua cache
  "lukas-reineke/indent-blankline.nvim", -- Indent indicators
  "lukas-reineke/lsp-format.nvim",
  "mhinz/vim-startify", -- Show recent files on startup
  "michaeljsmith/vim-indent-object",
  "nathom/filetype.nvim", -- Improve startup time
  "nvim-lua/plenary.nvim", -- for Telescope
  "nvim-lualine/lualine.nvim", -- Status line
  "nvim-telescope/telescope.nvim",
  "rstacruz/vim-gitgrep",
  "thinca/vim-visualstar",
  "tpope/vim-commentary", -- Comments
  "tpope/vim-fugitive", -- Git
  "tpope/vim-rhubarb", -- Fugitive extension for GitHub commands
  "tpope/vim-surround",
  "tpope/vim-unimpaired", -- Toggle key bindings
  "voldikss/vim-floaterm", -- Floating terminals
}

-- Preamble {{{
pcall(require, "impatient") -- Cache Lua packages
local cmd = vim.api.nvim_command

-- Loads a module using require(), but does nothing if the module is not present
-- Used for conditionally configuring a plugin depending on whether it's installed
local function plugin(module_name, callback)
  local status, mod = pcall(require, module_name)
  if status then
    callback(mod)
  end
end

local function has_paq(name)
  local path = vim.fn.stdpath("data") .. "/site/pack/paqs/start/" .. name
  return vim.fn.empty(vim.fn.glob(path)) == 0
end

-- }}}

-- Bootstrap {{{
if not has_paq("paq-nvim") then
  local path = vim.fn.stdpath("data") .. "/site/pack/paqs/start/paq-nvim"
  local paq_url = "https://github.com/savq/paq-nvim.git"
  vim.fn.system({ "git", "clone", "--depth=1", paq_url, path })
  vim.cmd("packadd paq-nvim")
  vim.cmd("autocmd User PaqDoneInstall quit")
  local paq = require("paq")
  paq(PKGS)
  paq.install()
end

plugin("paq", function(paq)
  paq(PKGS)
  paq.install()
end)
-- }}}

plugin("nvim-treesitter.configs", function(mod) -- {{{
  mod.setup({
    ensure_installed = { "c", "cpp", "javascript", "css", "lua" },
    highlight = {
      enable = true,
      use_languagetree = true,
    },
  })
end) -- }}}

plugin("formatter", function(mod) -- {{{
  mod.setup({
    filetype = {
      lua = {
        function()
          return {
            exe = "stylua",
            args = {
              "--config-path " .. os.getenv("XDG_CONFIG_HOME") .. "/stylua/stylua.toml",
              "-",
            },
            stdin = true,
          }
        end,
      },
      ruby = {
        function()
          return {
            exe = "bundle exec rubocop", -- might prepend `bundle exec `
            args = {
              "--auto-correct",
              "--stdin",
              "%:p",
              "2>/dev/null",
              "|",
              "awk 'f; /^====================$/{f=1}'",
            },
            stdin = true,
          }
        end,
      },
    },
  })
  vim.api.nvim_command([[
    augroup FormatAutogroup
    autocmd! BufWritePost *.js,*.ts,*.tsx FormatWrite
    augroup END
  ]])
end) -- }}}

plugin("compe", function(mod) -- {{{
  mod.setup({
    source = {
      path = true,
      buffer = true,
      nvim_lsp = true,
      nvim_lua = true,
    },
  })
end) -- }}}

plugin("scrollbar", function() -- {{{
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
end) -- }}}

plugin("nvim-tree", function(mod) -- {{{
  mod.setup({})
end) -- }}}

plugin("indent-o-matic", function(mod) -- {{{
  mod.setup({})
end) -- }}}

plugin("indent_blankline", function(mod) -- {{{
  mod.setup({
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
  })
  vim.cmd([[
    let g:indent_blankline_show_first_indent_level = v:true
    let g:indent_blankline_char_list = ['│', '┊', '┆']
    let g:indent_blankline_context_char_list = ['┊']
    let g:indent_blankline_filetype_exclude += ['startify']
  ]])
end) -- }}}

plugin("lualine", function(mod) -- {{{
  mod.setup({
    options = {
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
    },
    sections = {
      lualine_a = {
        {
          "mode",
          separator = { left = "" },
          right_padding = 2,
          fmt = function(str)
            return str:sub(1, 3)
          end,
        },
      },
      lualine_b = { "filename" },
      lualine_c = {},
      lualine_x = { "filetype" },
      lualine_y = { "progress" },
      lualine_z = {
        { "location", separator = { right = "" }, left_padding = 2 },
      },
    },
    tabline = {
      lualine_a = {},
      lualine_b = {
        {
          "tabs",
          mode = 1,
          tabs_color = {
            -- Same values as the general color option can be used here.
            active = "lualine_a_normal",
            inactive = "lualine_b_inactive",
          },
        },
      },
      lualine_c = {},
      lualine_x = {},
      lualine_y = { "branch" },
      lualine_z = {},
    },
  })
end) -- }}}

plugin("which-key", function(mod) -- {{{
  mod.setup({
    window = {
      border = "shadow",
      margin = { 1, 15, 2, 15 },
    },
    key_labels = {
      ["<leader>"] = "∴",
    },
    icons = {
      breadcrumb = "›",
      separator = "┄",
      group = "",
    },
    layout = {
      align = "center",
      spacing = 7,
    },
  })
  require("keymaps")
end) -- }}}

plugin("gitsigns", function(mod) -- {{{
  mod.setup({})
end) -- }}}

plugin("nvim-lsp-installer", function(mod) --  {{{
  vim.api.nvim_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
  require('lsp-format').setup()

  mod.on_server_ready(function(server)
    local opts = {}
    -- (optional) Customize the options passed to the server
    -- if server.name == 'tsserver' then
    --     opts.root_dir = function() ... end
    -- end

    server:setup(opts)
  end)
end) -- }}}

if has_paq("vim-startify") then -- {{{
  vim.api.nvim_set_var("startify_custom_indices", { "1", "2", "3", "4", "5", "6", "7", "8", "9" })
  vim.api.nvim_set_var("startify_custom_header", { "    Neovim" })
  vim.api.nvim_set_var("startify_enable_unsafe", 1)
  vim.api.nvim_command([[
  let g:startify_lists = []
  let g:startify_lists += [ { 'type': 'dir', 'header': ['  Recent files'] } ]
  let g:startify_lists += [ { 'type': 'sessions', 'header': ['  Sessions'] } ]
  ]])
end -- }}}

if has_paq("vim-floaterm") then -- {{{
  vim.api.nvim_set_var("floaterm_width", 0.95)
end -- }}}

if has_paq("vim-microtone") then -- {{{
  cmd([[color microtone]])
end -- }}}

-- Vim settings {{{
vim.opt.gdefault = true
vim.opt.mouse = "a"
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.swapfile = false
vim.opt.showmode = false -- Don't show '-- INSERT --' in status line
vim.opt.timeoutlen = 200 -- For which-key
vim.opt.fillchars = { eob = " ", vert = "▓" }
-- }}}

-- Customisation: terminal (no line numbers) {{{
cmd([[augroup TerminalCustomisations]])
cmd([[au!]])
cmd([[au TermOpen * setlocal nonumber norelativenumber nocursorline]])
cmd([[au TermOpen * startinsert]])
cmd([[augroup END]])
-- }}}

-- Customisation: git (close on ctrl-s) {{{
cmd([[augroup GitCustomisations]])
cmd([[au!]])
cmd([[au FileType gitcommit inoremap <silent> <buffer> <c-s> <esc>:w<cr>G:q<cr>]])
cmd([[au FileType gitcommit nnoremap <silent> <buffer> <c-s> :w<cr>G:q<cr>]])
cmd([[augroup END]])
-- }}}

-- vim:foldmethod=marker

PKGS = {
  "savq/paq-nvim", -- Paq package manager

  -- Language
  "nvim-treesitter/nvim-treesitter",
  "neovim/nvim-lspconfig",
  "williamboman/nvim-lsp-installer", -- Install LSP servers (:LspInstall)
  "sbdchd/neoformat", -- Formatting

  -- Completion
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/nvim-cmp",

  -- Themes
  "rstacruz/vim-microtone",
  "projekt0n/github-nvim-theme",
  "tomasiser/vim-code-dark",
  "rktjmp/lush.nvim", -- Required by zenbones
  "mcchrish/zenbones.nvim",

  -- File types
  "preservim/vim-markdown", -- Markdown (.md)
  "slim-template/vim-slim", -- Slim (.slim)

  -- UI
  "SmiteshP/nvim-gps", -- Breadcrumbs in the status line
  "Xuyuanp/scrollbar.nvim", -- Scrollbars
  "folke/lsp-colors.nvim", -- Infer some colours needed for LSP
  "folke/which-key.nvim", -- Menu when pressing [space]
  "kyazdani42/nvim-tree.lua", -- File explorer
  "kyazdani42/nvim-web-devicons",
  "lewis6991/gitsigns.nvim", -- Git indicators on the gutter
  "lukas-reineke/indent-blankline.nvim", -- Indent indicators
  "nvim-lua/plenary.nvim", -- for Telescope
  "nvim-lualine/lualine.nvim", -- Status line
  "nvim-telescope/telescope.nvim",
  "onsails/lspkind-nvim", -- Icons on LSP menus
  "stevearc/dressing.nvim", -- Improved appearance of vim.ui

  -- Optimisations
  "lewis6991/impatient.nvim", -- Improve startup time by optimising Lua cache
  "nathom/filetype.nvim", -- Improve startup time

  -- Goodies
  "Darazaki/indent-o-matic", -- Detect indentation automatically
  "akinsho/toggleterm.nvim", -- Terminal
  "jrudess/vim-foldtext", -- Improve appearance of fold text
  "michaeljsmith/vim-indent-object",
  "nvim-pack/nvim-spectre", -- Find files
  "phaazon/hop.nvim", -- Easymotion (gw)
  "rstacruz/vim-gitgrep",
  "thinca/vim-visualstar",
  "tpope/vim-commentary", -- Comments
  "tpope/vim-fugitive", -- Git
  "tpope/vim-rhubarb", -- Fugitive extension for GitHub commands
  "tpope/vim-surround",
  "dstein64/vim-startuptime", -- Profile startup
  "nanotee/zoxide.vim", -- Integration with zoxide dir changer

  -- "glepnir/dashboard-nvim",
  -- "mhinz/vim-startify", -- Show recent files on startup
  "rcarriga/nvim-notify"
}

-- Preamble {{{
pcall(require, "impatient") -- Cache Lua packages
local cmd = vim.api.nvim_command
local utils = require("utils")
local plugin = utils.plugin
utils.bootstrap_paq(PKGS)
-- }}}

-- Theme {{{
local function get_theme()
  local bg = utils.is_light() and "light" or "dark"

  if utils.has_paq("github-nvim-theme") then
    return bg == "light" and { "github_light", "auto", bg } or { "github_dark", "auto", bg }
  elseif utils.has_paq("zenbones.nvim") then
    return bg == "light" and { "rosebones", "auto", bg } or { "rosebones", "auto", bg }
  elseif utils.has_paq("vim-code-dark") then
    return { "codedark", "auto", "dark" }
  elseif utils.has_paq("vim-microtone") then
    return { "microtone", "dracula", bg }
  else
    return { "defualt", "auto", bg }
  end
end

local theme = get_theme()
vim.opt.background = theme[3]
cmd("color " .. theme[1])
-- }}}

plugin("nvim-treesitter.configs", function(mod) -- {{{
  mod.setup({
    ensure_installed = { "c", "cpp", "javascript", "css", "lua" },
    highlight = {
      enable = true,
      use_languagetree = true,
    },
  })
end, { defer = true }) -- }}}

plugin("cmp", function(cmp) -- {{{
  local _, lspkind = pcall(require, "lspkind")

  cmp.setup({
    mapping = {
      ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
      ["<C-y>"] = cmp.config.disable,
      ["<C-e>"] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
    },
    formatting = lspkind and {
      format = lspkind.cmp_format({
        mode = "symbol",
        maxwidth = 50,
      }),
    } or {},
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      -- { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = "buffer" },
    }),
  })
end, { defer = true }) -- }}}

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
end, { defer = true }) -- }}}

plugin("nvim-tree", function(mod) -- {{{
  mod.setup({
    view = { side = "left" },
    renderer = {
      indent_markers = {
        enable = true,
      },
    },
  })
end) -- }}}

plugin("indent-o-matic", function(mod) -- {{{
  mod.setup({})
end) -- }}}

plugin("indent_blankline", function(mod) -- {{{
  mod.setup({
    space_char_blankline = " ",
    show_current_context = true,
  })
  vim.cmd([[
    let g:indent_blankline_show_first_indent_level = v:true
    let g:indent_blankline_char_list = ['┊', '┆', '│']
    let g:indent_blankline_context_char_list = ['┊']
    let g:indent_blankline_filetype_exclude += ['startify']
    let g:indent_blankline_filetype_exclude += ['toggleterm']
  ]])
end, { defer = true }) -- }}}

plugin("lualine", function(lualine) -- {{{
  local opts = require("lualine-theme").get_theme({ theme = theme[2] })
  lualine.setup(opts)
end) -- }}}

plugin("which-key", function(mod) -- {{{
  mod.setup({
    window = {
      border = "shadow",
      margin = { 1, 10, 2, 10 },
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
end, { defer = true }) -- }}}

plugin("gitsigns", function(mod) -- {{{
  mod.setup({})
end, { defer = true }) -- }}}

plugin("telescope", function(mod) -- {{{
  local defaults = require("telescope.themes").get_dropdown()
  mod.setup({
    defaults = defaults,
  })
end, { defer = true }) -- }}}

plugin("nvim-gps", function(mod) -- {{{
  mod.setup({
    separator = " ╱ ",
  })
end, { defer = true }) -- }}}

plugin("hop", function(mod) -- {{{
  mod.setup({
    keys = "arstgmneiowfpyulcdh",
    -- keys = "1234567890",
  })
end, { defer = true }) -- }}}

plugin("notify", function(notify)
  notify.setup({
    stages = "static"
  })
  vim.notify = notify
end)

plugin("toggleterm", function(toggleterm) -- {{{
  toggleterm.setup({
    direction = "vertical",
    size = function(term)
      if term.direction == "horizontal" then
        return 24
      elseif term.direction == "vertical" then
        return 80 -- vim.o.columns * 0.4
      end
    end,
    shading_factor = 3,
  })
end, { defer = true }) -- }}}

plugin("nvim-lsp-installer", function(mod) --  {{{
  vim.api.nvim_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  mod.on_server_ready(function(server)
    local opts = {}
    -- (optional) Customize the options passed to the server
    -- if server.name == 'tsserver' then
    --     opts.root_dir = function() ... end
    -- end

    server:setup(opts)
  end)
end, { defer = true }) -- }}}

if utils.has_paq("neoformat") then -- {{{
  cmd([[augroup Neoformat]])
  cmd([[au!]])
  cmd([[au BufWritePre *.lua,*.js,*.ts,*.tsx Neoformat]])
  cmd([[augroup END]])
end -- }}}

-- Vim settings {{{
vim.opt.expandtab = true
vim.opt.fillchars = { eob = " ", vert = "░" } -- end-of-buffer and vertical split
vim.opt.gdefault = true -- Search/replace uses `g` flag by default
vim.opt.mouse = "a" -- Enable mouse support
vim.opt.shell = "/bin/bash"
vim.opt.shiftwidth = 2
vim.opt.showmode = false -- Don't show '-- INSERT --' in status line
vim.opt.termguicolors = theme[1] ~= "microtone" -- Full GUI colours in terminal
vim.opt.softtabstop = 2
vim.opt.swapfile = false -- Don't write swap files
vim.opt.timeoutlen = 400 -- For which-key
vim.opt.wrap = false -- Word wrap
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
cmd([[au FileType gitcommit startinsert]])
cmd([[au FileType gitcommit inoremap <silent> <buffer> <c-s> <esc>:w<cr>G:q<cr>]])
cmd([[au FileType gitcommit nnoremap <silent> <buffer> <c-s> :w<cr>G:q<cr>]])
cmd([[augroup END]])
-- }}}
-- vim:foldmethod=marker

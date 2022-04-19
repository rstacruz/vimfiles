pcall(require, "impatient") -- Cache Lua packages

PKGS = { -- {{{
  "savq/paq-nvim", -- Paq package manager

  -- Language
  "nvim-treesitter/nvim-treesitter",
  "neovim/nvim-lspconfig",
  "williamboman/nvim-lsp-installer", -- Install LSP servers (:LspInstall)
  "jose-elias-alvarez/null-ls.nvim", -- Formatting and diagnostics

  -- Completion
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/cmp-vsnip",
  "hrsh7th/nvim-cmp",
  "hrsh7th/vim-vsnip",

  -- Themes
  "rstacruz/vim-microtone",
  "projekt0n/github-nvim-theme",
  "tomasiser/vim-code-dark",
  "rktjmp/lush.nvim", -- Required by zenbones
  "mcchrish/zenbones.nvim",

  -- File types
  "preservim/vim-markdown", -- Markdown (.md)
  "slim-template/vim-slim", -- Slim (.slim)
  "vimwiki/vimwiki", -- Obsidian Markdown

  -- UI
  "SmiteshP/nvim-gps", -- Breadcrumbs in the status line
  "dstein64/nvim-scrollview",
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
  "rcarriga/nvim-notify",

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
  "tpope/vim-fugitive", -- Git
  "tpope/vim-rhubarb", -- Fugitive extension for GitHub commands
  "tpope/vim-surround",
  "dstein64/vim-startuptime", -- Profile startup
  "nanotee/zoxide.vim", -- Integration with zoxide dir changer
  "numToStr/Comment.nvim", -- Comments

  -- "mhinz/vim-startify", -- Show recent files on startup
  -- "liuchengxu/vista.vim", -- Tag explorer
  -- "tpope/vim-commentary", -- Comments
} -- }}}

-- Preamble {{{
local cmd = vim.api.nvim_command
local utils = require("core.utils")
local plugin = utils.plugin
utils.bootstrap_paq(PKGS)
-- }}}

-- Theme {{{
local function get_theme()
  local bg = utils.is_light() and "light" or "dark"

  if bg == "light" then
    return false
        or utils.has_paq("github-nvim-theme") and { "github_light", "auto", bg }
        or utils.has_paq("zenbones.nvim") and { "rosebones", "auto", bg }
        or utils.has_paq("vim-microtone") and { "microtone", "dracula", bg }
        or { "default", "auto", bg }
  else
    return false
        or utils.has_paq("github-nvim-theme") and { "github_dimmed", "auto", bg }
        or utils.has_paq("zenbones.nvim") and { "tokyobones", "auto", bg }
        or utils.has_paq("vim-microtone") and { "microtone", "dracula", bg }
        or { "default", "auto", bg }
  end
end

local theme = get_theme()
vim.opt.background = theme[3]
cmd("color " .. theme[1])
-- }}}

plugin("nvim-treesitter.configs", function(mod) -- {{{
  mod.setup({
    ensure_installed = { "c", "cpp", "javascript", "css", "lua", "markdown" },
    matchup = { enable = true },
    indent = { enable = true },
    autotag = { enable = true },
    highlight = {
      enable = true,
      use_languagetree = true,
    },
  })
  vim.o.foldmethod = "expr"
  vim.o.foldexpr = "nvim_treesitter#foldexpr()"
end) -- }}}

plugin("cmp", function(cmp) -- {{{
  local _, lspkind = pcall(require, "lspkind")
  local formatting = lspkind
      and {
        format = lspkind.cmp_format({
          mode = "symbol",
          maxwidth = 50,
        }),
      }
      or {}

  local mapping = cmp.mapping.preset.insert({
    ["<cr>"] = cmp.mapping.confirm(), -- add { select = true } to auto-select first item
    ["<c-f>"] = cmp.mapping.scroll_docs(4), -- scroll the help text
    ["<c-b>"] = cmp.mapping.scroll_docs(-4),
    ["<c-d>"] = cmp.mapping.scroll_docs(4),
    ["<c-u>"] = cmp.mapping.scroll_docs(4),
  })

  cmp.setup({
    mapping = mapping,
    formatting = formatting,
    completion = {
      keyword_length = 4,
    },
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "vsnip" },
    }, {
      { name = "buffer" },
    }),
  })

  cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" },
    },
  })

  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      { name = "cmdline" },
    }),
  })
end, { defer = true }) -- }}}

plugin("scrollview", function(scrollview) -- {{{
  scrollview.setup()
end, { defer = true }) -- }}}

plugin("nvim-tree", function(mod) -- {{{
  mod.setup({
    view = {
      side = "left",
      width = 20,
    },
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
  vim.g.indent_blankline_show_first_indent_level = true
  vim.g.indent_blankline_char_list = { "┊", "┆", "│" }
  vim.g.indent_blankline_context_char_list = { "┊" }
  vim.g.indent_blankline_filetype_exclude = {
    "lspinfo", -- arst
    "packer",
    "checkhealth",
    "",
    "startify",
    "toggleterm",
    "help",
    "spectre_panel",
  }
end, { defer = true }) -- }}}

plugin("lualine", function(lualine) -- {{{
  local opts = require("core.lualine-theme").get_theme({ theme = theme[2] })
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
  require("core.keymaps")
end, { defer = true }) -- }}}

plugin("gitsigns", function(mod) -- {{{
  mod.setup({
    signs = {
      changedelete = { text = "▌" }, -- Originally "~"
      change = { text = "▌" },
      add = { text = "▌" },
    },
  })
end, { defer = true }) -- }}}

plugin("telescope", function(mod) -- {{{
  local defaults = require("telescope.themes").get_dropdown()
  defaults.prompt_prefix = "› "
  defaults.selection_caret = "━ "
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
  })
end, { defer = true }) -- }}}

plugin("notify", function(notify) -- {{{
  notify.setup({
    stages = "static",
  })
  vim.notify = notify
end) -- }}}

plugin("null-ls", function(nullls) -- {{{
  -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
  nullls.setup({
    sources = {
      nullls.builtins.formatting.stylua,
      nullls.builtins.formatting.prettierd, -- volta install @fsouza/prettierd
      nullls.builtins.diagnostics.rubocop,
      nullls.builtins.diagnostics.eslint_d,
    },
  })
  cmd([[augroup Nullformat]])
  cmd([[au!]])
  cmd([[au BufWritePre *.lua,*.js,*.ts,*.tsx lua vim.lsp.buf.formatting_seq_sync()]])
  cmd([[augroup END]])
end, { defer = true }) -- }}}

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

plugin("nvim-lsp-installer", function(mod) -- {{{
  vim.api.nvim_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  mod.on_server_ready(function(server)
    local opts = {}

    -- I'm not sure if this does anything lol, but using `capabilities`
    local _, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    if cmp_nvim_lsp then
      opts["capabilities"] = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
    end

    server:setup(opts)
  end)
end, { defer = true }) -- }}}

plugin("spectre", function(spectre) -- {{{
  spectre.setup({
    line_sep_start = "",
    result_padding = "   ",
    line_sep = "",
  })
end, { defer = true }) -- }}}

plugin("Comment", function(comment)
  comment.setup()
end)

if utils.has_paq("vimwiki") then
  cmd([[
    let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
  ]])
end

if true then -- Vim settings {{{
  vim.opt.backup = false -- No backup files
  vim.opt.expandtab = true
  vim.opt.fillchars = { eob = " ", vert = "▐" } -- end-of-buffer and vertical split
  vim.opt.gdefault = true -- Search/replace uses `g` flag by default
  vim.opt.ignorecase = true -- Case insensitive search
  vim.opt.mouse = "a" -- Enable mouse support
  vim.opt.number = true -- Line numbers
  vim.opt.pumheight = 10 -- Popup menu height
  vim.opt.scrolloff = 4 -- Scroll padding
  vim.opt.shell = "/bin/bash"
  vim.opt.shiftwidth = 2
  vim.opt.showmode = false -- Don't show '-- INSERT --' in status line
  vim.opt.signcolumn = "yes" -- Always show sign column
  vim.opt.smartcase = true -- Case insensitive by default, unless there's uppercase
  vim.opt.softtabstop = 2
  vim.opt.splitbelow = true -- Vertical splits open below
  vim.opt.splitright = true -- Horizontal splits open to the right
  vim.opt.swapfile = false -- Don't write swap files
  vim.opt.termguicolors = theme[1] ~= "microtone" -- Full GUI colours in terminal
  vim.opt.wrap = false -- Word wrap
  vim.opt.winwidth = 85 -- Auto-resize windows
  vim.opt.winminwidth = 12
  vim.opt.foldlevel = 99 -- Don't fold everything on first load

  if utils.has_paq("which-key.nvim") then
    vim.opt.timeoutlen = 120 -- Show almost instantly
  end

  if vim.fn.has("nvim-0.7") == 1 then
    vim.opt.laststatus = 3 -- Global statusline
    vim.opt.fillchars = {
      eob = " ",
      vert = "▐",
      vertright = "▐",
      vertleft = "▐",
      verthoriz = "▐",
      horizup = "━",
      horizdown = "━",
      horiz = "━",
    } -- better vert characters for global statusline
  end
end -- }}}

-- Customisation: augroups {{{
-- No line numbers, insert mode, etc
cmd([[augroup FiletypeCustomisations]])
cmd([[au!]])
cmd([[au TermOpen * setlocal nonumber norelativenumber nocursorline]])
cmd([[au TermOpen * startinsert]])
cmd([[au FileType markdown,spectre_panel setlocal nonumber]])
cmd([[au BufWinEnter NvimTree* set cursorline]])
cmd([[augroup END]])

-- Git (close on ctrl-s)
cmd([[augroup GitCustomisations]])
cmd([[au!]])
cmd([[au FileType gitcommit startinsert]])
cmd([[au FileType gitcommit inoremap <silent> <buffer> <c-s> <esc>:w<cr>G:q<cr>]])
cmd([[au FileType gitcommit nnoremap <silent> <buffer> <c-s> :w<cr>G:q<cr>]])
cmd([[augroup END]])

-- Cursorline on insert mode
cmd([[augroup CursorLine]])
cmd([[au!]])
cmd([[au InsertEnter * set cursorline]])
cmd([[au InsertLeave * set nocursorline]])
cmd([[augroup END]])
-- }}}

-- vim:foldmethod=marker

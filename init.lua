pcall(require, "impatient") -- Cache Lua packages

-- Proxy for checking if it's a dev environment
local has_gcc = vim.fn.executable("gcc")

PKGS = { -- {{{
  "wbthomason/packer.nvim",

  -- Language
  (has_gcc and { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }),
  (has_gcc and "nvim-treesitter/nvim-treesitter-textobjects"),
  (has_gcc and "neovim/nvim-lspconfig"),
  (has_gcc and "williamboman/nvim-lsp-installer"), -- Install LSP servers (:LspInstall)
  (has_gcc and "jose-elias-alvarez/null-ls.nvim"), -- Formatting and diagnostics
  (has_gcc and "SmiteshP/nvim-gps"), -- Breadcrumbs in the status line

  -- Completion
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/cmp-vsnip",
  "hrsh7th/nvim-cmp",
  -- "hrsh7th/vim-vsnip",

  -- Themes
  "rstacruz/vim-microtone",
  "projekt0n/github-nvim-theme",
  "rktjmp/lush.nvim", -- Required by zenbones
  "mcchrish/zenbones.nvim",
  { "catppuccin/nvim", as = "catppuccin-nvim" },
  "EdenEast/nightfox.nvim",
  -- "navarasu/onedark.nvim",
  { "rose-pine/neovim", as = "rose-pine-nvim" },

  -- File types
  "preservim/vim-markdown", -- Markdown (.md)
  "slim-template/vim-slim", -- Slim (.slim)
  -- "vimwiki/vimwiki", -- Obsidian Markdown
  "mickael-menu/zk-nvim", -- Zk (.md)

  -- UI
  "dstein64/nvim-scrollview",
  "folke/lsp-colors.nvim", -- Infer some colours needed for LSP
  "folke/which-key.nvim", -- Menu when pressing [space]
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
  },
  "mrjones2014/legendary.nvim",
  "kyazdani42/nvim-web-devicons",
  "lewis6991/gitsigns.nvim", -- Git indicators on the gutter
  "lukas-reineke/indent-blankline.nvim", -- Indent indicators
  "nvim-lua/plenary.nvim", -- for Telescope
  "nvim-lualine/lualine.nvim", -- Status line
  "nvim-telescope/telescope.nvim",
  { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
  "onsails/lspkind-nvim", -- Icons on LSP menus
  "stevearc/dressing.nvim", -- Improved appearance of vim.ui
  "rcarriga/nvim-notify",
  "simrat39/symbols-outline.nvim",

  -- Optimisations
  "lewis6991/impatient.nvim", -- Improve startup time by optimising Lua cache
  "nathom/filetype.nvim", -- Improve startup time

  -- Goodies
  -- "Darazaki/indent-o-matic", -- Detect indentation automatically
  { "rstacruz/indent-o-matic", branch = "patch-1" }, -- Detect indentation automatically
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
  "numToStr/Comment.nvim", -- Comments
  "natecraddock/workspaces.nvim", -- Manage workspaces

  -- Still trying it out
  "ThePrimeagen/harpoon", -- Bookmark files
  "folke/twilight.nvim", -- Isolate (leader-ot)
  (vim.fn.executable("nnn") and "luukvbaal/nnn.nvim"), -- File manager
} -- }}}

-- Packer startup {{{
local has_packer, packer = pcall(require, "packer") -- Cache Lua packages
if not has_packer then
  vim.cmd([[echo "Packer was not found, installing..."]])
  local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
  vim.cmd([[echo "Done, restart now!"]])
  return
else
  packer.startup(function(use)
    for _, package in pairs(PKGS) do
      if package then
        use(package)
      end
    end
  end)
end
-- }}}

-- Preamble {{{
local cmd = vim.api.nvim_command
local utils = require("core.utils")
local plugin = utils.plugin
-- }}}

-- Theme {{{
Theme = { theme = { "default", "auto", "dark" }, mode = "dark" }

function Theme.get_theme(bg)
  if bg == "light" then
    return false
        or utils.has_pkg("zenbones.nvim") and { "seoulbones", "auto", bg }
        or utils.has_pkg("nightfox.nvim") and { "dayfox", "auto", bg }
        or utils.has_pkg("github-nvim-theme") and { "github_light", "auto", bg }
        or utils.has_pkg("vim-microtone") and { "microtone", "dracula", bg }
        or { "default", "auto", bg }
  else
    return false
        or utils.has_pkg("nightfox.nvim") and { "duskfox", "auto", bg }
        or utils.has_pkg("catppuccin-nvim") and { "catppuccin", "auto", bg }
        or utils.has_pkg("github-nvim-theme") and { "github_dimmed", "auto", bg }
        or utils.has_pkg("zenbones.nvim") and { "tokyobones", "auto", bg }
        or utils.has_pkg("vim-microtone") and { "microtone", "dracula", bg }
        or { "default", "auto", bg }
  end
end

function Theme:set_theme(mode)
  mode = mode or (utils.is_light() and "light" or "dark")
  self.theme = self.get_theme(mode)
  self.mode = mode
  vim.opt.background = self.theme[3]
  cmd("color " .. self.theme[1])
end

function Theme:toggle_theme()
  self:set_theme(self.mode == "dark" and "light" or "dark")
end

-- }}}

plugin("zk", function(zk) -- {{{
  if vim.fn.executable("zk") then
    zk.setup({
      picker = "telescope",
      auto_attach = {
        enabled = true,
        filetypes = { "markdown" },
      },
    })
  end
end) -- }}}

plugin("nvim-treesitter.configs", function(mod) -- {{{
  mod.setup({
    ensure_installed = {
      "c", "cpp", "javascript", "css", "lua", "markdown", "ruby", "yaml",
      "json", "html", "python", "svelte", "typescript", "fish", "dockerfile",
      "make", "jsdoc", "scss", "vim"
    },
    matchup = { enable = true },
    indent = { enable = true },
    autotag = { enable = true },
    highlight = {
      enable = true,
      use_languagetree = true,
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
    }
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
      expand = function()
        -- vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      -- { name = "vsnip" },
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
  vim.g.scrollview_excluded_filetypes = { "NvimTree" }
end, { defer = true }) -- }}}

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
  local opts = require("core.lualine-theme").get_theme({ theme = Theme.theme[2] })
  lualine.setup(opts)
end) -- }}}

plugin("legendary", function(legendary) -- {{{
  legendary.setup({ -- Do this before which-key
    select_prompt = "",
  })
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
end) -- }}}

plugin("gitsigns", function(mod) -- {{{
  mod.setup({
    signs = {
      changedelete = { text = "▌" }, -- Originally "~"
      change = { text = "▌" },
      add = { text = "▌" },
    },
  })
end, { defer = true }) -- }}}

plugin("telescope", function(telescope) -- {{{
  local defaults = require("telescope.themes").get_ivy({
    show_line = false,
    preview_title = false,
    prompt_prefix = "› ",
    selection_caret = "  ",
  })
  telescope.setup({
    defaults = defaults,
  })
end) -- }}}

plugin("telescope._extensions.fzf", function() -- {{{
  plugin("telescope", function(telescope)
    telescope.load_extension("fzf")
  end)
end) -- }}}

plugin("harpoon", function() -- {{{
  plugin("telescope", function(telescope)
    telescope.load_extension("harpoon") -- allow `:Telescope harpoon`
  end)
end) -- }}}

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

plugin("null-ls", function(null_ls) -- {{{
  local sources = {}
  if vim.fn.executable("ruby") then
    table.insert(sources, null_ls.builtins.diagnostics.rubocop)
  end
  if vim.fn.executable("stylua") then -- cargo install stylua
    table.insert(sources, null_ls.builtins.formatting.stylua)
  end
  if vim.fn.executable("prettierd") then -- volta install @fsouza/prettierd
    table.insert(sources, null_ls.builtins.formatting.prettierd)
  end
  if vim.fn.executable("eslint_d") then -- volta install eslint_d
    table.insert(sources, null_ls.builtins.diagnostics.eslint_d)
  end

  -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
  null_ls.setup({
    sources = sources,
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

plugin("nvim-lsp-installer", function(lsp_installer) -- {{{
  plugin("lspconfig", function(lspconfig)
    lsp_installer.setup({
      automatic_installation = true
    })

    if vim.fn.executable("ruby") then
      lspconfig.solargraph.setup({})
    end
    if vim.fn.executable("node") then
      lspconfig.tsserver.setup({})
      lspconfig.yamlls.setup({})
    end
    lspconfig.sumneko_lua.setup({})
  end)
end) -- }}}

plugin("spectre", function(spectre) -- {{{
  spectre.setup({
    line_sep_start = "",
    result_padding = "   ",
    line_sep = "",
  })
end, { defer = true }) -- }}}

plugin("nightfox", function(nightfox) -- {{{
  nightfox.setup({
    options = {
      styles = {
        comments = "italic",
        keywords = "bold",
      },
    },
  })
end) -- }}}

plugin("Comment", function(comment) -- {{{
  comment.setup()
end) -- }}}

plugin("workspaces", function(workspaces) -- {{{
  workspaces.setup({
    hooks = {
      open_pre = { "%bd!" },
      -- open = { "Telescope" },
      open = { "lua require('telescope.builtin').oldfiles({only_cwd=true})" },
      -- open = { "term fish" },
    },
  })

  plugin("telescope", function(telescope)
    telescope.load_extension("workspaces")
  end)
end) -- }}}

plugin("neo-tree", function(neo_tree) -- {{{
  vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
  neo_tree.setup({
    window = {
      position = "right",
    },
  })
end) -- }}}

plugin("nnn", function(nnn) -- {{{
  nnn.setup()
end) -- }}}

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
  vim.opt.shiftwidth = 2
  vim.opt.showmode = false -- Don't show '-- INSERT --' in status line
  vim.opt.signcolumn = "yes" -- Always show sign column
  vim.opt.smartcase = true -- Case insensitive by default, unless there's uppercase
  vim.opt.softtabstop = 2
  vim.opt.splitbelow = true -- Vertical splits open below
  vim.opt.splitright = true -- Horizontal splits open to the right
  vim.opt.swapfile = false -- Don't write swap files
  vim.opt.termguicolors = Theme.theme[1] ~= "microtone" -- Full GUI colours in terminal
  vim.opt.wrap = false -- Word wrap
  vim.opt.winwidth = 85 -- Auto-resize windows
  vim.opt.winminwidth = 12
  vim.opt.foldlevel = 99 -- Don't fold everything on first load

  if not vim.fn.has("windows") then
    vim.opt.shell = "/bin/bash"
  end

  if utils.has_pkg("which-key.nvim") then
    vim.opt.timeoutlen = 200
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

if true then -- Autocmds {{{
  local augroup = require("core.utils").augroup

  augroup("MyCustomisations", function(autocmd, group)
    -- Cursorline on insert mode
    autocmd("InsertEnter", "*", "set cursorline")
    autocmd("InsertLeave", "*", "set nocursorline")

    -- No line numbers, insert mode, etc
    autocmd("TermOpen", "*", "setlocal nonumber norelativenumber nocursorline")
    autocmd("TermOpen", "*", "startinsert")
    autocmd("FileType", "markdown,spectre_panel,neo-tree", "setlocal nonumber")

    -- Git: close on ctrl-s
    autocmd("FileType", "gitcommit", "startinsert")
    autocmd("FileType", "gitcommit", [[inoremap <silent> <buffer> <c-s> <esc>:w<cr>G:q<cr>]])
    autocmd("FileType", "gitcommit", [[nnoremap <silent> <buffer> <c-s> :w<cr>G:q<cr>]])

    -- Markdown stuff
    autocmd("FileType", "text,markdown", [[inoremap <buffer> +dw <C-r>=strftime('%d %b, %a')<CR>]])
    autocmd("FileType", "text,markdown", [[inoremap <buffer> +ds <C-r>=strftime('%Y-%m-%d')<CR>]])
    autocmd("FileType", "text,markdown", [[iabbrev <buffer> :star: ⭐]])
    autocmd("FileType", "text,markdown", [[iabbrev <buffer> -- —]])
    autocmd("FileType", "text,markdown", [[iabbrev <buffer> -> →]])
    autocmd("FileType", "text,markdown", [[inoremap <buffer> +co ``<left>]]) -- [co]de
    autocmd("FileType", "text,markdown", [[inoremap <buffer> +cd ```<cr>```<home><up><end>]]) -- [c]o[d]e block
    autocmd(
      "FileType",
      "text,markdown",
      [[iabbrev <buffer> *** * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *]]
    )

    autocmd("Colorscheme", "*", function()
      CustomiseTheme()
    end)
  end)
end

function CustomiseTheme()
  cmd([[hi! HopNextKey guibg=#ffddaa guifg=#000000]])
  cmd([[hi! HopNextKey1 guibg=#ffddaa guifg=#000000]])
  cmd([[hi! HopNextKey2 guibg=#ffddaa guifg=#000000]])

  local col = vim.g.colors_name
  local bg = vim.o.background

  if ({ seoulbones = 1, rosebones = 1, zenbones = 1, dayfox = 1 })[col] and bg == "light" then
    cmd([[hi! Normal guibg=#ffffff]])
    cmd([[hi! NormalNC guibg=#fafafc]])
  end
end -- }}}

-- Abbreviations
vim.defer_fn(function()
  require("core.abbreviations").setup()
end, 250)

-- Set theme after the customise theme hooks
Theme:set_theme()

-- vim:foldmethod=marker

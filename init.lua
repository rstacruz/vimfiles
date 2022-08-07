-- Packer startup {{{
-- Proxy for checking if it's a dev environment
local has_gcc = vim.fn.executable("gcc")

local function packages(use)
  use "wbthomason/packer.nvim"

  -- Language
  if has_gcc then use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" } end
  use "nvim-treesitter/nvim-treesitter-textobjects"
  use "neovim/nvim-lspconfig"
  use "williamboman/mason.nvim" -- Install LSP servers (:Mason)
  use "WhoIsSethDaniel/mason-tool-installer.nvim" -- Auto-install as needed
  use "jose-elias-alvarez/null-ls.nvim" -- Formatting and diagnostics
  use "SmiteshP/nvim-gps" -- Breadcrumbs in the status line

  -- Completion
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "hrsh7th/cmp-vsnip"
  use "hrsh7th/nvim-cmp"
  -- "hrsh7th/vim-vsnip"

  -- Themes
  use "rstacruz/vim-microtone"
  use "projekt0n/github-nvim-theme"
  use "rktjmp/lush.nvim" -- Required by zenbones
  use "mcchrish/zenbones.nvim"
  use { "catppuccin/nvim", as = "catppuccininvim" }
  use { "dracula/vim", as = "dracula-vim" }
  use "cmoscofian/nibble-vim"
  use "EdenEast/nightfox.nvim"
  use { "embark-theme/vim", as = "embark-theme-vim" }

  -- File types
  use "preservim/vim-markdown" -- Markdown (.md)
  use "slim-template/vim-slim" -- Slim (.slim)

  -- UI
  use "dstein64/nvim-scrollview"
  use "folke/lsp-colors.nvim" -- Infer some colours needed for LSP
  use "folke/which-key.nvim" -- Menu when pressing [space]
  -- use {
  --   "nvim-neo-tree/neo-tree.nvim",
  --   branch = "v2.x",
  --   requires = {
  --     "nvim-lua/plenary.nvim",
  --     "kyazdani42/nvim-web-devicons",
  --     "MunifTanjim/nui.nvim"
  --   }
  -- }
  use "kyazdani42/nvim-tree.lua"
  use "kyazdani42/nvim-web-devicons"
  use "lewis6991/gitsigns.nvim" -- Git indicators on the gutter
  use "lukas-reineke/indent-blankline.nvim" -- Indent indicators
  use "nvim-lua/plenary.nvim" -- for Telescope
  use "nvim-lualine/lualine.nvim" -- Status line
  use "romgrk/barbar.nvim" -- tabline
  use "nvim-telescope/telescope.nvim"
  use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
  use "onsails/lspkind-nvim" -- Icons on LSP menus
  use "stevearc/dressing.nvim" -- Improved appearance of vim.ui
  use "rcarriga/nvim-notify"
  use "simrat39/symbols-outline.nvim"

  -- Optimisations
  use "lewis6991/impatient.nvim" -- Improve startup time by optimising Lua cache
  use "nathom/filetype.nvim" -- Improve startup time

  -- Goodies
  use "Darazaki/indent-o-matic" -- Detect indentation automatically
  use "akinsho/toggleterm.nvim" -- Terminal
  use "jrudess/vim-foldtext" -- Improve appearance of fold text
  use "michaeljsmith/vim-indent-object"
  use "nvim-pack/nvim-spectre" -- Find files
  use "phaazon/hop.nvim" -- Easymotion (gw)
  use "rstacruz/vim-gitgrep"
  use "thinca/vim-visualstar"
  use "tpope/vim-fugitive" -- Git
  use "tpope/vim-rhubarb" -- Fugitive extension for GitHub commands
  use "tpope/vim-surround"
  use "dstein64/vim-startuptime" -- Profile startup
  use "numToStr/Comment.nvim" -- Comments
  use "natecraddock/workspaces.nvim" -- Manage workspaces
  use "kazhala/close-buffers.nvim" -- Close hidden buffers

  -- Still trying it out
  use "folke/twilight.nvim" -- Isolate (leader-ot)
  use { "TimUntersberger/neogit", requires = "nvim-lua/plenary.nvim" }
  use { "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" }
  use "github/copilot.vim"
  use "airblade/vim-rooter"
end -- }}}

local packer_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(packer_path)) > 0 then
  vim.cmd([[echo "Installing packer..."]])
  vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", packer_path })
  vim.cmd("autocmd User PackerCompileDone luafile " .. vim.env.MYVIMRC)
  require("packer").startup(packages)
  require("packer").sync()
  return
end

local function run(fn)
  fn()
end

require("packer").startup(packages)
require("impatient")
-- }}}

-- Preamble {{{
local cmd = vim.api.nvim_command
local utils = require("core.utils")
local plugin = utils.plugin
-- }}}

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
  vim.g.indent_blankline_char_list = { "│" }
  vim.g.indent_blankline_context_char_list = { "│" }
  vim.g.indent_blankline_filetype_exclude = {
    "lspinfo", "packer", "checkhealth", "", "startify", "toggleterm", "help", "spectre_panel",
  }
end, { defer = true }) -- }}}

plugin("lualine", function(lualine) -- {{{
  local lualine_theme = require("core.lib.theme").get_lualine_theme()
  local opts = require("core.lib.lualine-theme").get_theme({ theme = lualine_theme })
  lualine.setup(opts)
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

plugin("nvim-gps", function(mod) -- {{{
  mod.setup({ separator = " ╱ " })
end, { defer = true }) -- }}}

plugin("hop", function(mod) -- {{{
  mod.setup({ keys = "arstgmneiowfpyulcdh" })
end, { defer = true }) -- }}}

plugin("notify", function(notify) -- {{{
  notify.setup({ stages = "static" })
  vim.notify = notify
end) -- }}}

plugin("null-ls", function() -- {{{
  local formatCommand = vim.lsp.buf.format and "vim.lsp.buf.format()" or "vim.lsp.buf.formatting_seq_sync()"
  cmd([[augroup Nullformat]])
  cmd([[au!]])
  cmd([[au BufWritePre *.lua,*.js,*.jsx,*.ts,*.tsx,*.cjs,*.mjs lua ]] .. formatCommand)
  cmd([[augroup END]])
end, { defer = true }) -- }}}

plugin("mason", function() -- {{{
  require("core.extras.lsp_borders").setup()
  require("core.setup.mason").setup()
end) -- }}}

plugin("spectre", function(spectre) -- {{{
  spectre.setup({
    line_sep_start = "",
    result_padding = "   ",
    line_sep = "",
  })
end, { defer = true }) -- }}}

run(function() -- Nightfox {{{
  local has, nightfox = pcall(require, "nightfox")
  if not has then return end
  nightfox.setup({
    options = {
      styles = {
        comments = "italic",
        keywords = "bold",
      },
    },
  })
end) -- }}}

run(function() -- Comment {{{
  local has, comment = pcall(require, "Comment")
  if not has then return end
  comment.setup()
end) -- }}}

run(function() -- Workspaces {{{
  local has, workspaces = pcall(require, "workspaces")
  if not has then return end

  workspaces.setup({
    hooks = {
      open_pre = { "%bd!" },
      open = { "lua require('telescope.builtin').oldfiles({only_cwd=true})" },
    },
  })

  local has_telescope, telescope = pcall(require, "telescope")
  if has_telescope then
    telescope.load_extension("workspaces")
  end
end) -- }}}

run(function() -- neo-tree {{{
  local has, neotree = pcall(require, "neo-tree")
  if not has then return end

  vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
  neotree.setup({
    window = {
      position = "right",
    },
  })
end) -- }}}

run(function() -- symbols-outline {{{
  local has, _ = pcall(require, "symbols-outline")
  if not has then return end

  vim.g.symbols_outline = {
    auto_close = true,
    symbol_blacklist = { "Field", "Param" },
  }
end) -- }}}

plugin("bufferline", function(bufferline) -- {{{
  bufferline.setup({
    -- auto_hide = true -- hide when only 1 buffer
    icon_pinned = '∴'
  })
end) -- }}}

plugin("nvim-tree", function(nvimtree) -- {{{
  nvimtree.setup({
    view = {
      width = 30
    }
  })
end) -- }}}

require("core.setup.treesitter").setup()
require("core.setup.nvim-settings").setup()
require("core.setup.rooter").setup()
require("core.setup.which-key").setup()
require("core.lib.theme").setup()
require("core.keymaps").setup()

vim.defer_fn(function()
  require("core.setup.nvim-autocmds").setup()
  require("core.setup.neogit").setup()
  require("core.setup.toggleterm").setup()
  require("core.setup.cmp").setup()
  require("core.setup.zz-deferred").setup()
  require("core.lib.abbreviations").setup()
  require("core.lib.highlight_on_yank").setup()
end, 250)

-- vim:foldmethod=marker

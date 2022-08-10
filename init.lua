-- Packer startup {{{
-- Proxy for checking if it's a dev environment
local has_gcc = vim.fn.executable("gcc")

local function packages(use)
  use("wbthomason/packer.nvim")

  -- Language
  if has_gcc then
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
  end
  use("nvim-treesitter/nvim-treesitter-textobjects")
  use("neovim/nvim-lspconfig")
  use("williamboman/mason.nvim") -- Install LSP servers (:Mason)
  use("WhoIsSethDaniel/mason-tool-installer.nvim") -- Auto-install as needed
  use("jose-elias-alvarez/null-ls.nvim") -- Formatting and diagnostics
  use("SmiteshP/nvim-gps") -- Breadcrumbs in the status line

  -- Completion
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-cmdline")
  use("hrsh7th/cmp-vsnip")
  use("hrsh7th/nvim-cmp")
  -- "hrsh7th/vim-vsnip"

  -- Themes
  use("rstacruz/vim-microtone")
  use("projekt0n/github-nvim-theme")
  use("rktjmp/lush.nvim") -- Required by zenbones
  use("mcchrish/zenbones.nvim")
  use({ "catppuccin/nvim", as = "catppuccininvim" })
  use({ "dracula/vim", as = "dracula-vim" })
  use("cmoscofian/nibble-vim")
  use("EdenEast/nightfox.nvim")
  use({ "embark-theme/vim", as = "embark-theme-vim" })

  -- File types
  use("preservim/vim-markdown") -- Markdown (.md)
  use("slim-template/vim-slim") -- Slim (.slim)

  -- UI
  use("dstein64/nvim-scrollview")
  use("folke/lsp-colors.nvim") -- Infer some colours needed for LSP
  use("folke/which-key.nvim") -- Menu when pressing [space]
  use("kyazdani42/nvim-tree.lua")
  use("kyazdani42/nvim-web-devicons")
  use("lewis6991/gitsigns.nvim") -- Git indicators on the gutter
  use("lukas-reineke/indent-blankline.nvim") -- Indent indicators
  use("nvim-lua/plenary.nvim") -- for Telescope
  use("nvim-lualine/lualine.nvim") -- Status line
  use("akinsho/bufferline.nvim") -- tab line
  use("nvim-telescope/telescope.nvim")
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
  use("onsails/lspkind-nvim") -- Icons on LSP menus
  use("stevearc/dressing.nvim") -- Improved appearance of vim.ui
  use("rcarriga/nvim-notify")
  use("RRethy/vim-illuminate")

  -- Optimisations
  use("lewis6991/impatient.nvim") -- Improve startup time by optimising Lua cache
  use("nathom/filetype.nvim") -- Improve startup time

  -- Goodies
  use("Darazaki/indent-o-matic") -- Detect indentation automatically
  use("akinsho/toggleterm.nvim") -- Terminal
  use("jrudess/vim-foldtext") -- Improve appearance of fold text
  use("michaeljsmith/vim-indent-object")
  use("nvim-pack/nvim-spectre") -- Find files
  use("phaazon/hop.nvim") -- Easymotion (gw)
  use("rstacruz/vim-gitgrep")
  use("thinca/vim-visualstar")
  use("tpope/vim-fugitive") -- Git
  use("tpope/vim-rhubarb") -- Fugitive extension for GitHub commands
  use("tpope/vim-surround")
  use("dstein64/vim-startuptime") -- Profile startup
  use("numToStr/Comment.nvim") -- Comments
  use("natecraddock/workspaces.nvim") -- Manage workspaces
  use("kazhala/close-buffers.nvim") -- Close hidden buffers

  -- Still trying it out
  use("folke/twilight.nvim") -- Isolate (leader-ot)
  use({ "TimUntersberger/neogit", requires = "nvim-lua/plenary.nvim" })
  use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" })
  use("github/copilot.vim")
  use("airblade/vim-rooter")
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

local function run_later(fn)
  vim.defer_fn(fn, 250)
end

require("packer").startup(packages)
require("impatient")
-- }}}

run_later(function() -- scrollview {{{
  local has, scrollview = pcall(require, "scrollview")
  if not has then
    return
  end

  scrollview.setup()
  vim.g.scrollview_excluded_filetypes = { "NvimTree" }
end) -- }}}

run_later(function() -- indent_blankline {{{
  local has, indent_blankline = pcall(require, "indent_blankline")
  if not has then
    return
  end

  indent_blankline.setup({
    space_char_blankline = " ",
    show_current_context = true,
  })

  vim.g.indent_blankline_show_first_indent_level = true
  vim.g.indent_blankline_char_list = { "│" }
  vim.g.indent_blankline_context_char_list = { "│" }
  vim.g.indent_blankline_filetype_exclude = {
    "lspinfo",
    "packer",
    "checkhealth",
    "",
    "startify",
    "toggleterm",
    "help",
    "spectre_panel",
  }
end) -- }}}

run(function() -- lualine {{{
  local has, lualine = pcall(require, "lualine")
  if not has then
    return
  end

  local lualine_theme = require("core.lib.theme").get_lualine_theme()
  local opts = require("core.lib.lualine-theme").get_theme({ theme = lualine_theme })

  lualine.setup(opts)
end) -- }}}

run_later(function() -- gitsigns {{{
  local has, gitsigns = pcall(require, "gitsigns")
  if not has then
    return
  end

  gitsigns.setup({
    signs = {
      changedelete = { text = "▌" }, -- Originally "~"
      change = { text = "▌" },
      add = { text = "▌" },
    },
  })
end) -- }}}

run_later(function() -- telescope {{{
  local has, telescope = pcall(require, "telescope")
  if not has then
    return
  end
  local options = {
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
    prompt_prefix = "   ",
    selection_caret = "  ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    file_sorter = require("telescope.sorters").get_fuzzy_file,
    file_ignore_patterns = { "node_modules" },
    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    path_display = { "truncate" },
    winblend = 0,
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
    mappings = {
      n = { ["q"] = require("telescope.actions").close },
    },
  },
}

  telescope.setup(options)

  local has_fzf, _ = pcall(require, "telescope._extensions.fzf")
  if has_fzf then
    telescope.load_extension("fzf")
  end
end) -- }}}

run_later(function() -- nvim-gps {{{
  local has, nvim_gps = pcall(require, "nvim-gps")
  if not has then
    return
  end

  nvim_gps.setup({ separator = " ╱ " })
end) -- }}}

run_later(function() -- hop {{{
  local has, hop = pcall(require, "hop")
  if not has then
    return
  end

  hop.setup({ keys = "arstgmneiowfpyulcdh" })
end) -- }}}

run_later(function() -- notify {{{
  local has, notify = pcall(require, "notify")
  if not has then
    return
  end

  notify.setup({ stages = "static" })
  vim.notify = notify
end) -- }}}

run_later(function() -- null-ls {{{
  local has, _ = pcall(require, "null-ls")
  if not has then
    return
  end

  local formatCommand = vim.lsp.buf.format and "vim.lsp.buf.format()" or "vim.lsp.buf.formatting_seq_sync()"
  vim.cmd([[augroup Nullformat]])
  vim.cmd([[au!]])
  vim.cmd([[au BufWritePre *.lua,*.js,*.jsx,*.ts,*.tsx,*.cjs,*.mjs lua ]] .. formatCommand)
  vim.cmd([[augroup END]])
end) -- }}}

run_later(function() -- spectre {{{
  local has, spectre = pcall(require, "spectre")
  if not has then
    return
  end

  spectre.setup({
    line_sep_start = "",
    result_padding = "   ",
    line_sep = "",
  })
end) -- }}}

run(function() -- Nightfox {{{
  local has, nightfox = pcall(require, "nightfox")
  if not has then
    return
  end
  local override = require("nightfox").override
  override.palettes({
    dawnfox = {
      bg1 = "#fcfbfa",
    },
  })

  nightfox.setup({
    options = {
      styles = {
        comments = "italic",
        keywords = "bold",
      },
    },
  })
end) -- }}}

run_later(function() -- Comment {{{
  local has, comment = pcall(require, "Comment")
  if not has then
    return
  end
  comment.setup()
end) -- }}}

run_later(function() -- Workspaces {{{
  local has, workspaces = pcall(require, "workspaces")
  if not has then
    return
  end

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
  if not has then
    return
  end

  vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
  neotree.setup({
    window = {
      position = "right",
    },
  })
end) -- }}}

run_later(function() -- nvim-tree {{{
  local has, nvim_tree = pcall(require, "nvim-tree")
  if not has then
    return
  end

  nvim_tree.setup({
    sync_root_with_cwd = true,
    view = {
      width = 30,
    },
    renderer = {
      add_trailing = false,
      indent_markers = {
        enable = true,
      },
    },
  })
end)

require("core.lib.theme").setup()
require("core.setup.bufferline").setup() -- do after theme
require("core.setup.nvim-settings").setup()
require("core.setup.treesitter").setup()

run_later(function()
  require("core.setup.mason").setup()
  require("core.setup.rooter").setup()
  require("core.extras.lsp_borders").setup()
  require("core.setup.nvim-autocmds").setup()
  require("core.setup.neogit").setup()
  require("core.setup.toggleterm").setup()
  require("core.setup.cmp").setup()
  require("core.setup.which-key").setup()
  require("core.setup.zz-deferred").setup()
  require("core.lib.abbreviations").setup()
  require("core.lib.highlight_on_yank").setup()
  require("core.keymaps").setup()
end)

-- vim:foldmethod=marker

-- Packer startup {{{
-- Proxy for checking if it's a dev environment
local has_gcc = vim.fn.executable("gcc")

local function packages(use)
  use("wbthomason/packer.nvim")

  -- Language
  if has_gcc then
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    use("nvim-treesitter/nvim-treesitter-textobjects")
    use("neovim/nvim-lspconfig")
    use("williamboman/mason.nvim") -- Install LSP servers (:Mason)
    use("WhoIsSethDaniel/mason-tool-installer.nvim") -- Auto-install as needed
    use("jose-elias-alvarez/null-ls.nvim") -- Formatting and diagnostics
    use("SmiteshP/nvim-gps") -- Breadcrumbs in the status line
  end

  -- Completion
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-cmdline")
  use("hrsh7th/cmp-vsnip")
  use("hrsh7th/nvim-cmp")

  -- Themes
  use("rstacruz/vim-microtone")
  use("projekt0n/github-nvim-theme")
  use("rktjmp/lush.nvim") -- Required by zenbones
  use("mcchrish/zenbones.nvim")
  use({ "catppuccin/nvim", as = "catppuccininvim" })
  use({ "dracula/vim", as = "dracula-vim" })
  use("cmoscofian/nibble-vim")
  use("EdenEast/nightfox.nvim")
  use("navarasu/onedark.nvim")
  use({ "embark-theme/vim", as = "embark-theme-vim" })

  -- File types
  use("preservim/vim-markdown") -- Markdown (.md)
  use("slim-template/vim-slim") -- Slim (.slim)

  -- UI
  use("goolord/alpha-nvim")
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

-- Packer bootstrap
local packer_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(packer_path)) > 0 then
  print("Installing packer...")
  vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", packer_path })
  vim.cmd("autocmd User PackerCompileDone luafile " .. vim.env.MYVIMRC)
  vim.cmd("packadd packer.nvim")
  require("packer").startup(packages)
  require("packer").sync()
  return
end

require("packer").startup(packages)
require("impatient")
require("core.lib.theme").setup()
require("core.setup.bufferline").setup() -- do after theme
require("core.setup.nvim-options").setup()
require("core.setup.treesitter").setup()
require("core.setup.alpha").setup()
require("core.setup.zz-other").setup()

vim.defer_fn(function()
  require("core.setup.mason").setup()
  require("core.setup.rooter").setup()
  require("core.extras.lsp_borders").setup()
  require("core.setup.nvim-autocmds").setup()
  require("core.setup.neogit").setup()
  require("core.setup.toggleterm").setup()
  require("core.setup.telescope").setup()
  require("core.setup.cmp").setup()
  require("core.setup.which-key").setup()
  require("core.setup.zz-deferred").setup()
  require("core.lib.abbreviations").setup()
  require("core.lib.highlight_on_yank").setup()
  require("core.keymaps").setup()
end, 250)

-- vim:foldmethod=indent

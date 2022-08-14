pcall(require, "impatient")
require("core.setup.nvim-options").setup()

local function packages(use)
  local has_gcc = true -- vim.fn.executable("gcc")
  use("wbthomason/packer.nvim")

  -- Language
  if has_gcc then
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    use({ "nvim-treesitter/nvim-treesitter-textobjects", event = "User DeferredLoad" })
    use("neovim/nvim-lspconfig")
    use("williamboman/mason.nvim") -- Install LSP servers (:Mason)
    use("WhoIsSethDaniel/mason-tool-installer.nvim") -- Auto-install as needed
    use("jose-elias-alvarez/null-ls.nvim") -- Formatting and diagnostics
    use("SmiteshP/nvim-gps") -- Breadcrumbs in the status line
  end

  -- Completion
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      "onsails/lspkind-nvim",
      { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
      { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
      { "hrsh7th/cmp-path", after = "nvim-cmp" },
      { "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
      { "hrsh7th/cmp-vsnip", after = "nvim-cmp" },
    },
  })

  -- Themes
  use("rstacruz/vim-microtone")
  use("projekt0n/github-nvim-theme")
  use({ "mcchrish/zenbones.nvim", requires = {
    "rktjmp/lush.nvim",
  } })
  use({ "catppuccin/nvim", as = "catppuccin-nvim" })
  use({ "dracula/vim", as = "dracula-vim" })
  use("cmoscofian/nibble-vim")
  use("EdenEast/nightfox.nvim")
  use("navarasu/onedark.nvim")
  use({ "embark-theme/vim", as = "embark-theme-vim" })

  -- File types
  use({ "preservim/vim-markdown", ft = { "markdown" } }) -- Markdown (.md)
  use({ "slim-template/vim-slim", ft = { "slim" } }) -- Slim (.slim)

  -- UI
  use({
    "goolord/alpha-nvim",
    config = function()
      require("core.setup.alpha").setup()
    end,
  })
  use({
    "dstein64/nvim-scrollview",
    event = "User DeferredLoad",
    config = function()
      require("core.setup.scrollview").setup()
    end,
  })
  use("folke/lsp-colors.nvim") -- Infer some colours needed for LSP
  use("folke/which-key.nvim") -- Menu when pressing [space]
  use({
    "kyazdani42/nvim-tree.lua",
    config = function()
      require("core.setup.nvim-tree").setup()
    end,
  })
  use("kyazdani42/nvim-web-devicons")
  use({
    "lewis6991/gitsigns.nvim",
    event = "User DeferredLoad",
    config = function()
      require("core.setup.gitsigns").setup()
    end,
  }) -- Git indicators on the gutter
  use({
    "lukas-reineke/indent-blankline.nvim",
    event = "User DeferredLoad",
    config = function()
      require("core.setup.indent_blankline").setup()
    end,
  }) -- Indent indicators
  use({ "nvim-lua/plenary.nvim", module = "plenary" }) -- Library for Telescope and many others
  use("nvim-lualine/lualine.nvim") -- Status line
  use({
    "akinsho/bufferline.nvim",
    event = "User DeferredLoad",
    config = function()
      require("core.setup.bufferline").setup() -- do after theme
    end,
  }) -- tab line
  use({
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    module = "telescope",
    requires = {
      { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
    },
    config = {
      require("core.setup.telescope").setup(),
    },
  })
  use({ "stevearc/dressing.nvim", event = "VimEnter *" }) -- Improved appearance of vim.ui
  use("rcarriga/nvim-notify")

  -- Optimisations
  use("lewis6991/impatient.nvim") -- Improve startup time by optimising Lua cache
  use("nathom/filetype.nvim") -- Improve startup time

  -- Goodies
  use("Darazaki/indent-o-matic") -- Detect indentation automatically
  use({
    "akinsho/toggleterm.nvim",
    event = "User DeferredLoad",
    config = function()
      require("core.setup.toggleterm").setup()
    end,
  }) -- Terminal
  use("jrudess/vim-foldtext") -- Improve appearance of fold text
  use({ "michaeljsmith/vim-indent-object", event = "User DeferredLoad" })
  use({ "nvim-pack/nvim-spectre", event = "User DeferredLoad" }) -- Find files
  use("phaazon/hop.nvim") -- Easymotion (gw)
  use({ "rstacruz/vim-gitgrep", event = "VimEnter *" })
  use({ "thinca/vim-visualstar", event = "VimEnter *" })
  use({ "tpope/vim-fugitive", event = "User DeferredLoad" }) -- Git
  use({ "tpope/vim-rhubarb", event = "User DeferredLoad" }) -- Fugitive extension for GitHub commands
  use({ "tpope/vim-surround", event = "User DeferredLoad" })
  use("dstein64/vim-startuptime") -- Profile startup
  use({
    "numToStr/Comment.nvim",
    event = "User DeferredLoad",
    config = function()
      require("Comment").setup()
    end,
  }) -- Comments
  use({ "natecraddock/workspaces.nvim", event = "VimEnter" }) -- Manage workspaces
  use({ "kazhala/close-buffers.nvim", event = "User DeferredLoad" }) -- Close hidden buffers

  -- Still trying it out
  use({ "folke/twilight.nvim", event = "VimEnter" }) -- Isolate (leader-ot)
  use({
    "TimUntersberger/neogit",
    requires = "nvim-lua/plenary.nvim",
    event = "VimEnter",
    config = function()
      require("core.setup.neogit").setup()
    end,
  })
  use({
    "sindrets/diffview.nvim",
    requires = { "nvim-lua/plenary.nvim", "TimUntersberger/neogit" },
    event = "VimEnter",
  })
  use("airblade/vim-rooter")

  -- Takes a lot of CPU sometimes
  -- use("github/copilot.vim")
end

-- Packer bootstrap
local packer_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.filereadable(packer_path .. "/lua/packer.lua") == 0 then
  print("Installing packer…")
  vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", packer_path })
  vim.cmd("autocmd User PackerCompileDone luafile " .. vim.env.MYVIMRC)
  vim.cmd("packadd packer.nvim")
  require("packer").startup(packages)
  require("packer").sync()
  return
end

require("packer").startup(packages)
require("core.lib.theme").setup()
require("core.setup.treesitter").setup()
require("core.setup.zz-other").setup()

local group = vim.api.nvim_create_augroup("deferredload", { clear = true })
vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  group = group,
  callback = function()
    vim.defer_fn(function()
      vim.cmd([[doautocmd User DeferredLoad]])
      require("core.setup.mason").setup()
      require("core.setup.rooter").setup()
      require("core.extras.lsp_borders").setup()
      require("core.setup.nvim-autocmds").setup()
      require("core.setup.cmp").setup()
      require("core.setup.which-key").setup()
      require("core.setup.zz-deferred").setup()
      require("core.setup.zz-other").setup_later()
      require("core.lib.abbreviations").setup()
      require("core.lib.highlight_on_yank").setup()
      require("core.keymaps").setup()
    end, 1)
  end,
})

-- vim:foldmethod=indent:foldlevel=0

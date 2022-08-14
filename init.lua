pcall(require, "impatient")
require("coresetup.nvim-options").setup()

vim.g.baseconfig = {
	theme = "terafox",
}

local function packages(use)
	use({ "wbthomason/packer.nvim" })

	use({
    "nvim-treesitter/nvim-treesitter",
    module = "nvim-treesitter",
    run = ":TSUpdate",
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSEnable", "TSDisable", "TSModuleInfo" },
    requires = {
      { "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" }
    },
    config = function()
      require("coresetup.treesitter").setup()
    end
  })


	use({ "neovim/nvim-lspconfig", event = "User OnFileLoad" })
	-- use("williamboman/mason.nvim") -- Install LSP servers (:Mason)
	-- use("WhoIsSethDaniel/mason-tool-installer.nvim") -- Auto-install as needed
	-- use("jose-elias-alvarez/null-ls.nvim") -- Formatting and diagnostics

	-- Improve startup time by optimising Lua cache
	use({ "lewis6991/impatient.nvim" })

	-- Library for Telescope and many others
	use({ "nvim-lua/plenary.nvim", module = "plenary" })

	-- Telescope file picker
	use({
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		module = "Telescope",
		requires = {
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
		},
		config = function()
			require("coresetup.telescope").setup()
		end,
	})

	-- Profile startup with :StartupTime
	use({ "dstein64/vim-startuptime", cmd = "StartupTime" })

	use({
		"folke/which-key.nvim",
		event = "User OnIdle",
		config = function()
			require("coresetup.keybindings").setup()
		end,
	})

	-- File explorer
	use({
		"kyazdani42/nvim-tree.lua",
		config = function()
			require("coresetup.nvim-tree").setup()
		end,
	})

	-- Status line
	use({
		"nvim-lualine/lualine.nvim",
		event = "User OnIdle",
		requires = {
			{ "SmiteshP/nvim-gps" }, -- Breadcrumbs in the status line
		},
		config = function()
			require("coresetup.lualine").setup()
		end,
	})

	use({
		"lukas-reineke/indent-blankline.nvim",
		event = "User OnIdle",
		config = function()
			require("coresetup.indent-blankline").setup()
		end,
	})

	use({ "EdenEast/nightfox.nvim" })
end

-- Bootstrap packer
local utils = require("core.utils")
if utils.bootstrap_packer(packages) == false then
	return
end

require("core.theme-overrides").setup()
vim.cmd([[colorscheme terafox]])

utils.on_vimenter(function()
	vim.defer_fn(function()
		vim.cmd([[doautocmd User OnIdle]])
	end, 1)
end)

utils.on_file_load(function()
	vim.cmd([[doautocmd User OnFileLoad]])
	require("core.lsp").setup_lspconfig()
	utils.setup_packer_autocmd()
end)

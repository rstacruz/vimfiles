pcall(require, "impatient")
require("coresetup.nvim-options").setup()

vim.g.baseconfig = {
	ui = {
		theme_dark = "terafox", -- terafox | github_dimmed | catppuccin
	},
}

local function packages(use)
	use({ "wbthomason/packer.nvim" })

	use({
		"nvim-treesitter/nvim-treesitter",
		module = "nvim-treesitter",
		run = ":TSUpdate",
		cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSEnable", "TSDisable", "TSModuleInfo" },
		event = { "BufRead" },
		requires = {
			{ "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" },
		},
		config = function()
			require("coresetup.treesitter").setup()
		end,
	})

	-- Detect indents
	use({ "Darazaki/indent-o-matic", event = "BufRead" })

	use({ "thinca/vim-visualstar", event = "User OnFileLoad" })

	use("airblade/vim-rooter")

	-- Easymotion-style jumps
	use({
		"phaazon/hop.nvim",
		cmd = { "HopLine", "HopWord" },
		config = function()
			require("hop").setup({ keys = "arstgmneiowfpyulcdh" })
		end,
	})

	-- Install LSP servers (:Mason)
	use({
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall" },
		module = { "mason" },
		config = function()
			require("mason").setup()
		end,
	})

	use({
		"neovim/nvim-lspconfig",
		event = "User OnFileLoad",
		config = function()
			require("core.lsp").setup()
		end,
	})

	-- Formatting and diagnostics
	use({
		"jose-elias-alvarez/null-ls.nvim",
		module = "null-ls",
	})

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
		event = "User OnIdle",
		config = function()
			require("coresetup.nvim-tree").setup()
		end,
	})

	-- Status line
	use({
		"nvim-lualine/lualine.nvim",
		event = "User OnIdle",
		requires = {
			-- { "SmiteshP/nvim-gps" }, -- Breadcrumbs in the status line
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
	use({ "projekt0n/github-nvim-theme" })
	use({ "mcchrish/zenbones.nvim", requires = { "rktjmp/lush.nvim" } })
	use({ "catppuccin/nvim", as = "catppuccin-nvim" })
	use({ "dracula/vim", as = "dracula-vim" })
	use({ "cmoscofian/nibble-vim" })
	use({ "navarasu/onedark.nvim" })
	use({ "embark-theme/vim", as = "embark-theme-vim" })
end

-- Bootstrap packer
local utils = require("core.utils")
if utils.bootstrap_packer(packages) == false then
	return
end

require("core.theme-overrides").setup()
vim.cmd("colorscheme " .. vim.g.baseconfig.ui.theme_dark)

utils.on_vimenter(function()
	vim.schedule(function()
		vim.cmd([[doautocmd User OnIdle]])
	end)
end)

utils.on_file_load(function()
	vim.schedule(function()
		vim.cmd([[doautocmd User OnFileLoad]])
		require("core.config_auto_reload").setup()
	end)
end)

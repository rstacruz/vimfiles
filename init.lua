pcall(require, "impatient")

-- Configuration
local defaults = {
	ui = {
		theme_dark = "terafox", -- terafox | github_dimmed | catppuccin
		theme_light = "github_light",
	},

	-- Feature toggles to optimise loading times for some environments
	features = {
		auto_cd_root = true,
		lsp = true,
		lsp_installer = true,
		completions = true,
		treesitter = true,
		github_fugitive = true,

		-- experimental
		welcome_screen = false, -- a bit buggy, sometimes causes errors on startup

		-- these might not be worth disabling I think
		hop = true,
		file_explorer = true,
		autopairs = true,
		gitsigns = true,
		indent_detection = true,
		indent_guides = true,
		scrollbars = true,
		neogit = true,

		-- Lazy load UI elements (status line). "true" makes startup
		-- faster at the expense of a flash of unstyled UI
		lazy_load_statusline = false,
	},

	pane_navigation = {
		-- Don't resize these sidebars
		excluded_filetypes = { "NvimTree", "DiffviewFiles" },

		-- Minimum width of panes when navigating using ctrl-h and ctrl+n. Use -1
		-- to disable
		min_width = 80,
	},

	format = {
		-- Auto-format on save
		autoformat_files = "*.lua,*.js,*.jsx,*.ts,*.tsx,*.cjs,*.mjs",
	},

	terminal = {
		shell = nil,
	},

	welcome_screen = {
		-- Banner to show in the welcome screen
		banner = { "╲    ╱", " ╲  ╱ ", "	╲╱ ", "" },
	},

	treesitter = {
		ensure_installed = {
			"lua",
		},
	},
}

-- Custom config
BaseConfig = require("core.config-utils").apply_overrides("baseconfig", defaults)

-- Set options
require("coresetup.nvim-options").setup()

-- Packer packages
local function packages(use)
	local features = BaseConfig.features
	use({ "wbthomason/packer.nvim" })

	-- Improve startup time by optimising Lua cache
	use({ "lewis6991/impatient.nvim" })

	-- Library for Telescope and many others
	use({ "nvim-lua/plenary.nvim", module = { "plenary", "plenary.async" } })

	if features.treesitter then
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

		use({
			"kylechui/nvim-surround",
			event = { "BufRead", "CursorMoved" },
			config = function()
				require("coresetup.nvim-surround").setup()
			end,
		})
	end

	if features.indent_detection then
		-- Detect indents
		use({ "Darazaki/indent-o-matic" })
	end

	if features.auto_cd_root then
		use({ "airblade/vim-rooter" })
	end

	if features.welcome_screen then
		use({
			"goolord/alpha-nvim",
			config = function()
				require("coresetup.alpha").setup()
			end,
		})
	end

	if features.hop then
		-- Easymotion-style jumps
		use({
			"phaazon/hop.nvim",
			cmd = { "HopLine", "HopWord" },
			config = function()
				local has, hop = pcall(require, "hop")
				if has then
					hop.setup({ keys = "arstgmneiowfpyulcdh" })
				end
			end,
		})
	end

	if features.lsp and features.lsp_installer then
		-- Install LSP servers (:Mason)
		use({
			"williamboman/mason.nvim",
			cmd = { "Mason", "MasonInstall" },
			module = { "mason" },
			config = function()
				local has, mason = pcall(require, "mason")
				if has then
					mason.setup()
				end
			end,
		})
	end

	if features.lsp then
		use({
			"neovim/nvim-lspconfig",
			event = "User OnFileLoad",
			config = function()
				require("core.lsp").setup()
			end,
		})

		use({
			"SmiteshP/nvim-navic",
			module = "nvim-navic",
			config = function()
				vim.g.navic_available = true
				require("coresetup.nvim-navic").setup()
			end,
		})

		-- Formatting and diagnostics
		use({
			"jose-elias-alvarez/null-ls.nvim",
			module = "null-ls",
		})
	end

	if features.file_explorer then
		-- File explorer
		use({
			"kyazdani42/nvim-tree.lua",
			event = "User OnIdle",
			config = function()
				require("coresetup.nvim-tree").setup()
			end,
		})
	end

	if features.gitsigns then
		-- Git indicators on the gutter
		use({
			"lewis6991/gitsigns.nvim",
			event = "User OnFileLoad",
			module = "gitsigns",
			config = function()
				require("coresetup.gitsigns").setup()
			end,
		})
	end

	if features.indent_guides then
		use({
			"lukas-reineke/indent-blankline.nvim",
			event = { "BufRead", "CursorMoved" },
			config = function()
				require("coresetup.indent-blankline").setup()
			end,
		})
	end

	if features.scrollbars then
		use({
			"dstein64/nvim-scrollview",
			event = "User OnFileLoad",
			config = function()
				require("coresetup.scrollview").setup()
			end,
		})
	end

	-- Telescope file picker
	use({
		"nvim-telescope/telescope.nvim",
		-- cmd = "Telescope",
		-- module = "telescope",
		-- Ideally :cmd should take care of lazy-loading, but it has problems with
		-- hot reloading
		event = "User OnIdle",
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
			require("coresetup.which-key").setup()
			require("coresetup.keybindings").setup()
		end,
	})

	use({ "thinca/vim-visualstar", keys = { "*", "#" } })

	-- Status line
	use({
		"nvim-lualine/lualine.nvim",
		event = BaseConfig.features.lazy_load_statusline and "User OnIdle" or nil,
		module = BaseConfig.features.lazy_load_statusline and { "lualine" } or nil,
		config = function()
			require("coresetup.lualine").setup()
		end,
	})

	use({ "kyazdani42/nvim-web-devicons", module = "nvim-web-devicons" })

	if features.completions then
		-- Completions
		use({
			"hrsh7th/nvim-cmp",
			event = { "InsertEnter", "CmdlineEnter" },
			requires = {
				"onsails/lspkind-nvim",
				{ "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
				{ "hrsh7th/cmp-buffer", after = "nvim-cmp" },
				{ "hrsh7th/cmp-path", after = "nvim-cmp" },
				{ "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
				{ "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
			},
			config = function()
				require("coresetup.cmp").setup()
			end,
		})

		use({ "L3MON4D3/LuaSnip", module = "luasnip" })
	end

	use({
		"numToStr/Comment.nvim",
		event = "User OnFileLoad",
		config = function()
			require("Comment").setup()
		end,
	}) -- Comments

	use({
		"rstacruz/vim-gitgrep",
		cmd = { "GG", "VG" },
	})

	use({
		"nvim-pack/nvim-spectre",
		module = { "spectre" },
	})

	use({
		"akinsho/bufferline.nvim",
		event = "User OnIdle" or nil,
		cmd = { "BufferLineCycleNext", "BufferLineCyclePrev" } or nil,
		config = function()
			require("coresetup.bufferline").setup()
		end,
	})

	-- Improve appearance of fold text
	use({ "jrudess/vim-foldtext", event = "BufRead" })

	if features.github_fugitive then
		-- Git blame and open in GitHub
		use({
			"tpope/vim-fugitive",
			event = { "User OnIdle" },
			requires = { "tpope/vim-rhubarb" },
			-- not quite working
			-- cmd = { "Git", "GBrowse", "GBrowse!" },
		})
	end

	if features.neogit then
		use({
			"TimUntersberger/neogit",
			requires = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
			cmd = { "Neogit" },
			setup = function()
				-- diffview requires plenary to be loaded before it
				pcall(require, "plenary")
			end,
			config = function()
				require("coresetup.neogit").setup()
			end,
		})
	end

	if features.autopairs then
		use({
			"windwp/nvim-autopairs",
			event = { "InsertEnter" },
			config = function()
				require("coresetup.nvim-autopairs").setup()
			end,
		})
	end

	-- Close hidden buffers
	use({ "kazhala/close-buffers.nvim", module = "close_buffers" })

	use({ "EdenEast/nightfox.nvim" })
	use({ "projekt0n/github-nvim-theme" })
	-- use({ "mcchrish/zenbones.nvim", requires = { "rktjmp/lush.nvim" } })
	-- use({ "catppuccin/nvim", as = "catppuccin-nvim" })
	-- use({ "dracula/vim", as = "dracula-vim" })
	-- use({ "cmoscofian/nibble-vim" })
	-- use({ "navarasu/onedark.nvim" })
	-- use({ "embark-theme/vim", as = "embark-theme-vim" })
end

-- Bootstrap packer
if require("core.packer-utils").bootstrap_packer(packages) == false then
	return
end

require("core.theme-overrides").setup()
require("core.theme-utils").setup()

local utils = require("core.utils")

-- Defer loading some plugins until Vim is idle
utils.on_vimenter(function()
	vim.schedule(function()
		vim.cmd([[doautocmd User OnIdle]])
	end)
end)

utils.on_file_load(function()
	vim.schedule(function()
		vim.cmd([[doautocmd User OnFileLoad]])
		require("core.reload-utils").setup()
		require("core.auto-format").setup()
	end)
end)

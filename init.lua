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
		workspaces = true,
		status_line = true,

		-- A bit buggy, sometimes causes errors on startup
		experimental_welcome_screen = false,

		-- Use alternate implementation of filetype detection. Supposedly faster,
		-- but doesn't really make a difference in my testing, at least with Neovim 0.7.
		-- However, it can detect more file types than Neovim's default (eg, .astro).
		alternate_filetypes = false,

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
		lazy_load_statusline = true,
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

	use({
		"nvim-treesitter/nvim-treesitter",
		disable = not features.treesitter,
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
		disable = not features.treesitter,
		event = { "BufRead", "CursorMoved" },
		config = function()
			require("coresetup.nvim-surround").setup()
		end,
	})

	-- Detect indents
	use({
		"Darazaki/indent-o-matic",
		disable = not features.indent_detection,
	})

	use({ "airblade/vim-rooter", disable = not features.auto_cd_root })

	use({
		"goolord/alpha-nvim",
		disable = not features.experimental_welcome_screen,
		config = function()
			require("coresetup.alpha").setup()
		end,
	})

	-- Easymotion-style jumps
	use({
		"phaazon/hop.nvim",
		disable = not features.hop,
		cmd = { "HopLine", "HopWord" },
		config = function()
			local has, hop = pcall(require, "hop")
			if has then
				hop.setup({ keys = "arstgmneiowfpyulcdh" })
			end
		end,
	})

	-- Install LSP servers (:Mason)
	use({
		"williamboman/mason.nvim",
		disable = not (features.lsp and features.lsp_installer),
		cmd = { "Mason", "MasonInstall" },
		module = { "mason" },
		config = function()
			local has, mason = pcall(require, "mason")
			if has then
				mason.setup()
			end
		end,
	})

	use({
		"neovim/nvim-lspconfig",
		disable = not features.lsp,
		event = "User OnFileLoad",
		config = function()
			require("core.lsp").setup()
		end,
	})

	use({
		"SmiteshP/nvim-navic",
		disable = not features.lsp,
		module = "nvim-navic",
		config = function()
			vim.g.navic_available = true
			require("coresetup.nvim-navic").setup()
		end,
	})

	-- Formatting and diagnostics
	use({
		"jose-elias-alvarez/null-ls.nvim",
		disable = not features.lsp,
		module = "null-ls",
	})

	-- File explorer
	use({
		"kyazdani42/nvim-tree.lua",
		disable = not features.file_explorer,
		event = "User OnIdle",
		config = function()
			require("coresetup.nvim-tree").setup()
		end,
	})

	-- Git indicators on the gutter
	use({
		"lewis6991/gitsigns.nvim",
		disable = not features.gitsigns,
		event = "User OnFileLoad",
		module = "gitsigns",
		config = function()
			require("coresetup.gitsigns").setup()
		end,
	})

	use({
		"lukas-reineke/indent-blankline.nvim",
		disable = not features.indent_guides,
		event = { "BufRead", "CursorMoved" },
		config = function()
			require("coresetup.indent-blankline").setup()
		end,
	})

	use({
		"dstein64/nvim-scrollview",
		disable = not features.scrollbars,
		event = "User OnIdle",
		config = function()
			require("coresetup.scrollview").setup()
		end,
	})

	use({
		"natecraddock/workspaces.nvim",
		disable = not features.workspaces,
		module = "workspaces",
		cmd = { "WorkspacesAdd", "WorkspacesRemove", "WorkspacesList", "WorkspacesOpen" },
		config = function()
			require("coresetup.workspaces").setup()
		end,
	})

	-- Improve vim.ui.select for :WorkspacesList and LSP rename
	use({ "stevearc/dressing.nvim", disable = not (features.workspaces or features.lsp), module = "dressing" })

	-- Git blame and open in GitHub
	use({
		"tpope/vim-fugitive",
		disable = not features.github_fugitive,
		event = { "User OnIdle" },
		requires = { "tpope/vim-rhubarb" },
		-- not quite working
		-- cmd = { "Git", "GBrowse", "GBrowse!" },
	})

	use({
		"sindrets/diffview.nvim",
		disable = not features.neogit,
		module = "diffview",
	})

	use({
		"TimUntersberger/neogit",
		disable = not features.neogit,
		cmd = { "Neogit" },
		setup = function()
			-- Force-load these plugins before loading Neogit
			pcall(require, "plenary")
			pcall(require, "diffview")
		end,
		config = function()
			require("coresetup.neogit").setup()
		end,
	})

	use({
		"windwp/nvim-autopairs",
		disable = not features.autopairs,
		event = { "InsertEnter" },
		config = function()
			require("coresetup.nvim-autopairs").setup()
		end,
	})

	-- Completions
	use({
		"hrsh7th/nvim-cmp",
		disable = not features.completions,
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

	use({ "L3MON4D3/LuaSnip", disable = not features.completions, module = "luasnip" })

	use({
		"nathom/filetype.nvim",
		disable = not features.alternate_filetypes,
	})

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
		disable = not features.status_line,
		event = features.lazy_load_statusline and "VimEnter" or nil,
		module = features.lazy_load_statusline and { "lualine" } or nil,
		config = function()
			require("coresetup.lualine").setup()
		end,
	})

	use({ "kyazdani42/nvim-web-devicons", module = "nvim-web-devicons" })

	use({
		"numToStr/Comment.nvim",
		event = { "User OnIdle", "CursorMoved" },
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
	vim.defer_fn(function()
		vim.cmd([[doautocmd User OnIdle]])
		require("core.auto-format").setup()
		require("core.reload-utils").setup()
	end, 160)
end)

utils.on_file_load(function()
	vim.schedule(function()
		vim.cmd([[doautocmd User OnFileLoad]])
	end)
end)

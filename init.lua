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
		workspaces = false,
		project_switcher = true,
		status_line = true,
		welcome_screen = true,

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
		banner = { "╲    ╱", " ╲  ╱ ", "  ╲╱ ", "" },
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
local features = BaseConfig.features
local packages = {
	{ "wbthomason/packer.nvim" },

	-- Improve startup time by optimising Lua cache
	{ "lewis6991/impatient.nvim" },

	{ -- Plenary: Library for Telescope and many others
		"nvim-lua/plenary.nvim",
		module = { "plenary", "plenary.async" },
	},

	{ -- Treesitter
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
	},

	{ -- nvim-surround: surround keybindings (cs, ds, ys)
		"kylechui/nvim-surround",
		disable = not features.treesitter,
		event = { "BufRead", "CursorMoved" },
		config = function()
			require("coresetup.nvim-surround").setup()
		end,
	},

	{ -- indent-o-matic: Detect indents
		"Darazaki/indent-o-matic",
		disable = not features.indent_detection,
	},

	{ -- vim-rooter: auto-cd-root
		"airblade/vim-rooter",
		disable = not features.auto_cd_root,
	},

	{ -- alpha: dashboard screen
		"goolord/alpha-nvim",
		disable = not features.welcome_screen,
		cmd = { "Alpha" },
		module = "alpha",
		event = "VimEnter",
		config = function()
			require("coresetup.alpha").setup()
		end,
	},

	{ -- hop: Easymotion-style jumps
		"phaazon/hop.nvim",
		disable = not features.hop,
		cmd = { "HopLine", "HopWord" },
		config = function()
			local has, hop = pcall(require, "hop")
			if has then
				hop.setup({ keys = "arstgmneiowfpyulcdh" })
			end
		end,
	},

	{ -- mason: Install LSP servers (:Mason)
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
	},

	{ -- lspconfig
		"neovim/nvim-lspconfig",
		disable = not features.lsp,
		event = "User OnFileLoad",
		config = function()
			require("core.lsp").setup()
		end,
	},

	{ -- navic: status bar display of context
		"SmiteshP/nvim-navic",
		disable = not features.lsp,
		module = "nvim-navic",
		config = function()
			vim.g.navic_available = true
			require("coresetup.nvim-navic").setup()
		end,
	},

	{ -- null-ls: Formatting and diagnostics
		"jose-elias-alvarez/null-ls.nvim",
		disable = not features.lsp,
		module = "null-ls",
	},

	{ -- nvim-tree: File explorer
		"kyazdani42/nvim-tree.lua",
		disable = not features.file_explorer,
		event = "User OnIdle",
		config = function()
			require("coresetup.nvim-tree").setup()
		end,
	},

	{ -- gitsigns: Git indicators on the gutter
		"lewis6991/gitsigns.nvim",
		disable = not features.gitsigns,
		event = "User OnFileLoad",
		module = "gitsigns",
		config = function()
			require("coresetup.gitsigns").setup()
		end,
	},

	{ -- indent-blankline: Indent guides
		"lukas-reineke/indent-blankline.nvim",
		disable = not features.indent_guides,
		event = { "User OnIdle" }, -- { "BufRead", "CursorMoved" },
		config = function()
			require("coresetup.indent-blankline").setup()
		end,
	},

	{ -- scrollview: Scroll bars
		"dstein64/nvim-scrollview",
		disable = not features.scrollbars,
		event = "User OnIdle",
		config = function()
			require("coresetup.scrollview").setup()
		end,
	},

	{ -- workspaces: Project switcher
		"natecraddock/workspaces.nvim",
		disable = not features.workspaces,
		module = "workspaces",
		cmd = { "WorkspacesAdd", "WorkspacesRemove", "WorkspacesList", "WorkspacesOpen" },
		config = function()
			require("coresetup.workspaces").setup()
		end,
	},

	{ -- project: project switcher
		"ahmedkhalf/project.nvim",
		disable = not features.project_switcher,
		module = { "project_nvim", "telescope._extensions.projects" },
		config = function()
			require("coresetup.project").setup()
		end,
	},

	{ -- dressing: Improve vim.ui.select for :WorkspacesList and LSP rename
		"stevearc/dressing.nvim",
		disable = not (features.workspaces or features.lsp),
		module = "dressing",
	},

	{ -- fugitive: Git blame and open in GitHub
		"tpope/vim-fugitive",
		disable = not features.github_fugitive,
		event = { "User OnIdle" },
		requires = { "tpope/vim-rhubarb" },
		-- not quite working
		-- cmd = { "Git", "GBrowse", "GBrowse!" },
	},

	{ -- diffview: used by neogit
		"sindrets/diffview.nvim",
		disable = not features.neogit,
		module = "diffview",
	},

	{ -- neogit
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
	},

	{ -- autopairs
		"windwp/nvim-autopairs",
		disable = not features.autopairs,
		event = { "InsertEnter" },
		config = function()
			require("coresetup.nvim-autopairs").setup()
		end,
	},

	{ -- cmp: Completions
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
	},

	{ -- luasnip: Snippets, required by cmp
		"L3MON4D3/LuaSnip",
		disable = not features.completions,
		module = "luasnip",
	},

	{ -- filetype: alternate filetypes
		"nathom/filetype.nvim",
		disable = not features.alternate_filetypes,
	},

	{ -- telescope: file picker UI
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
	},

	{ -- Profile startup with :StartupTime
		"dstein64/vim-startuptime",
		cmd = "StartupTime",
	},

	{ -- which-key
		"folke/which-key.nvim",
		event = "User OnIdle",
		config = function()
			require("coresetup.which-key").setup()
			require("coresetup.keybindings").setup()
		end,
	},

	{ -- visualstar: press * or # on a selection
		"thinca/vim-visualstar",
		keys = { "*", "#" },
	},

	{ -- Status line
		"nvim-lualine/lualine.nvim",
		disable = not features.status_line,
		event = features.lazy_load_statusline and "VimEnter" or nil,
		module = features.lazy_load_statusline and { "lualine" } or nil,
		config = function()
			require("coresetup.lualine").setup()
		end,
	},

	{ -- comment
		"numToStr/Comment.nvim",
		event = { "User OnIdle", "CursorMoved" },
		config = function()
			require("Comment").setup()
		end,
	},

	{ -- gitgrep
		"rstacruz/vim-gitgrep",
		cmd = { "GG", "VG" },
	},

	{ -- spectre
		"nvim-pack/nvim-spectre",
		module = { "spectre" },
	},

	{ -- bufferline
		"akinsho/bufferline.nvim",
		event = "User OnIdle",
		cmd = { "BufferLineCycleNext", "BufferLineCyclePrev" },
		config = function()
			require("coresetup.bufferline").setup()
		end,
	},

	{ -- nvim-web-devicons
		"kyazdani42/nvim-web-devicons",
		module = "nvim-web-devicons",
	},

	{ -- vim-foldtext: Improve appearance of fold text
		"jrudess/vim-foldtext",
		event = "BufRead",
	},

	-- Close hidden buffers
	{ "kazhala/close-buffers.nvim", module = "close_buffers" },

	-- Themes
	{ "EdenEast/nightfox.nvim" },
	{ "projekt0n/github-nvim-theme" },
	-- { "mcchrish/zenbones.nvim", requires = { "rktjmp/lush.nvim" } },
	-- { "catppuccin/nvim", as = "catppuccin-nvim" },
	-- { "dracula/vim", as = "dracula-vim" },
	-- { "cmoscofian/nibble-vim" }
	-- { "navarasu/onedark.nvim" }
	-- { "embark-theme/vim", as = "embark-theme-vim" }
}

-- Bootstrap packer)
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
	end, 1)
end)

utils.on_file_load(function()
	vim.schedule(function()
		vim.cmd([[doautocmd User OnFileLoad]])
	end)
end)

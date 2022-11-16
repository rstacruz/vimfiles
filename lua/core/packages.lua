local function get_packages(features)
	return {
		{ "wbthomason/packer.nvim" },

		-- Improve startup time by optimising Lua cache
		{ "lewis6991/impatient.nvim" },

		{ -- Plenary: Library for Telescope and many others
			"nvim-lua/plenary.nvim",
		},

		{ -- Treesitter
			"nvim-treesitter/nvim-treesitter",
			disable = not features.treesitter,
			module = "nvim-treesitter",
			run = ":TSUpdate",
			cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSEnable", "TSDisable", "TSModuleInfo" },
			event = { "BufRead", "User PackerComplete" },
			requires = {
				{ "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" },
			},
			config = function()
				require("coresetup.treesitter").setup()
			end,
		},

		{
			"nvim-treesitter/nvim-treesitter-context",
			disable = not features.treesitter_context,
			-- event = { "User OnIdle", "BufRead" },
			config = function()
				require("coresetup.treesitter-context").setup()
			end,
		},

		{ -- nvim-surround: surround keybindings (cs, ds, ys)
			"kylechui/nvim-surround",
			disable = not features.treesitter,
			event = { "User OnIdle", "InsertEnter" },
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
			cmd = {
				"HopLine",
				"HopWord",
				"HopPattern",
				"HopPatternMW",
				"HopChar1",
				"HopChar1MW",
				"HopChar2",
				"HopChar2MW",
			},
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
			event = "User OnIdle",
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
			event = "User OnIdle",
			module = "gitsigns",
			cmd = { "Gitsigns" },
			config = function()
				require("coresetup.gitsigns").setup()
			end,
		},

		{ -- indent-blankline: Indent guides
			"lukas-reineke/indent-blankline.nvim",
			disable = not features.indent_guides,
			event = { "User OnIdle" }, -- { "BufRead" },
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
			event = { "User OnIdle" },
			module = "dressing",
		},

		{ -- rhubarb: browse on GitHub
			"tpope/vim-rhubarb",
			event = { "User OnIdle" },
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
			requires = {
				"nvim-lua/plenary.nvim",
				"sindrets/diffview.nvim",
			},
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

		{ "onsails/lspkind-nvim", module = "lspkind" },

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
				{ "hrsh7th/cmp-emoji", after = "nvim-cmp" },
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

		{ "nvim-telescope/telescope-fzf-native.nvim", run = "make", opt = true },

		{ -- telescope: file picker UI
			"nvim-telescope/telescope.nvim",
			-- cmd = "Telescope",
			-- module = "telescope",
			-- Ideally :cmd should take care of lazy-loading, but it has problems with
			-- hot reloading
			event = "User OnIdle",
			requires = {
				"nvim-telescope/telescope-fzf-native.nvim",
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
			commit = "9c190ea91939eba8c2d45660127e0403a5300b5a~1", -- https://github.com/folke/which-key.nvim/issues/330 (5 Sep 2022)
			config = function()
				require("coresetup.which-key").setup()
				require("coresetup.keybindings").setup()
			end,
		},

		{ -- Status line
			"feline-nvim/feline.nvim",
			disable = not features.status_line,
			config = function()
				require("coresetup.feline").setup()
			end,
		},

		{ -- comment
			"numToStr/Comment.nvim",
			event = { "User OnIdle" },
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

		{
			"j-hui/fidget.nvim",
			disable = not features.lsp,
			module = "fidget",
			event = "User OnIdle",
			config = function()
				require("coresetup.fidget").setup()
			end,
		},

		{
			"ThePrimeagen/refactoring.nvim",
			disable = not features.refactoring,
			event = "User OnIdle",
			requires = {
				{ "nvim-lua/plenary.nvim" },
				{ "nvim-treesitter/nvim-treesitter" },
			},
		},

		{
			"nvim-treesitter/playground",
			disable = not features.treesitter_playground,
			event = "User OnIdle",
			requires = {
				{ "nvim-treesitter/nvim-treesitter" },
			},
		},

		{
			"mickael-menu/zk-nvim",
			disable = not features.zk,
			event = "User OnIdle",
			module = { "zk" },
			config = function()
				require("coresetup.zk").setup()
			end,
		},
		{
			"rlane/pounce.nvim",
			disabled = not features.pounce,
			command = { "Pounce", "PounceRepeat" },
			config = function()
				require("coresetup.pounce").setup()
			end,
		},

		{
			"slim-template/vim-slim",
			ft = { "slim" },
		},

		-- Themes
		{ "EdenEast/nightfox.nvim" },
		{ "cmoscofian/nibble-vim" },
		{ "navarasu/onedark.nvim" }, --, event = { "User ColorAll", "User Color_onedark" },
		{ "projekt0n/github-nvim-theme" },
		{ "rktjmp/lush.nvim", module = "lush" }, -- required by Zenbones
		{ "mcchrish/zenbones.nvim" },
		{ "catppuccin/nvim", as = "catppuccin-nvim", tag = "v0.2" },
		-- { "dracula/vim", as = "dracula-vim" },
		-- { "cmoscofian/nibble-vim" }
		-- { "embark-theme/vim", as = "embark-theme-vim" }
	}
end

return { get_packages = get_packages }

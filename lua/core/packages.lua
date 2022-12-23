local function get_packages(features)
	return {
		{ -- Plenary: Library for Telescope and many others
			"nvim-lua/plenary.nvim",
			module = "plenary",
		},

		{ -- Treesitter
			"nvim-treesitter/nvim-treesitter",
			disable = not features.treesitter,
			module = "nvim-treesitter",
			run = ":TSUpdate",
			cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSEnable", "TSDisable", "TSModuleInfo" },
			requires = {
				{ "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" },
			},
			config = function()
				require("coresetup.treesitter").setup()
			end,
		},

		{ -- treesitter-context: Show context lines at the top
			"nvim-treesitter/nvim-treesitter-context",
			disable = not features.treesitter_context,
			event = "BufReadPre",
			config = function()
				require("coresetup.treesitter-context").setup()
			end,
		},

		{ -- nvim-surround: surround keybindings (cs, ds, ys)
			"kylechui/nvim-surround",
			disable = not features.treesitter,
			event = "VeryLazy",
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
			event = { "VimEnter" },
			config = function()
				require("coresetup.alpha").setup()
			end,
		},

		{ -- hop: Easymotion-style jumps
			"phaazon/hop.nvim",
			disable = not features.hop,
			cmd = {
				"HopLine",
				"HopLineMW",
				"HopWord",
				"HopWordMW",
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
			event = "VeryLazy",
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
			event = "VeryLazy",
			config = function()
				require("coresetup.nvim-tree").setup()
			end,
		},

		{ -- gitsigns: Git indicators on the gutter
			"lewis6991/gitsigns.nvim",
			disable = not features.gitsigns,
			event = "VeryLazy",
			module = "gitsigns",
			cmd = { "Gitsigns" },
			config = function()
				require("coresetup.gitsigns").setup()
			end,
		},

		{ -- indent-blankline: Indent guides
			"lukas-reineke/indent-blankline.nvim",
			disable = not features.indent_guides,
			event = "VeryLazy",
			config = function()
				require("coresetup.indent-blankline").setup()
			end,
		},

		{ -- scrollview: Scroll bars
			"dstein64/nvim-scrollview",
			disable = not features.scrollbars,
			event = "VeryLazy",
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
			event = "VeryLazy",
			module = "dressing",
		},

		{ -- rhubarb: browse on GitHub
			"tpope/vim-rhubarb",
			event = "VeryLazy",
		},

		{ -- fugitive: Git blame and open in GitHub
			"tpope/vim-fugitive",
			disable = not features.github_fugitive,
			event = "VeryLazy",
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
			event = "VeryLazy",
			config = function()
				require("coresetup.nvim-autopairs").setup()
			end,
		},

		{ -- lspkind
			"onsails/lspkind-nvim",
			module = "lspkind",
		},

		{ -- cmp: Completions
			"hrsh7th/nvim-cmp",
			disable = not features.completions,
			event = "VeryLazy",
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

		{ "nvim-telescope/telescope-fzf-native.nvim", run = "make", opt = true },

		{ -- telescope: file picker UI
			"nvim-telescope/telescope.nvim",
			-- cmd = "Telescope",
			-- module = "telescope",
			-- Ideally :cmd should take care of lazy-loading, but it has problems with
			-- hot reloading
			event = "VeryLazy",
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
			config = function()
				vim.g.startuptime_tries = 10
			end,
		},

		{ -- which-key
			"folke/which-key.nvim",
			event = "VeryLazy",
			config = function()
				require("coresetup.which-key").setup()
				require("coresetup.keymap").setup()
			end,
		},

		{ -- Status line
			"feline-nvim/feline.nvim",
			lazy = false,
			disable = not features.status_line,
			config = function()
				require("coresetup.feline").setup()
			end,
		},

		{ -- comment
			"numToStr/Comment.nvim",
			event = "VeryLazy",
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
			event = "VeryLazy",
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
			event = "VeryLazy",
		},

		-- Close hidden buffers
		{ "kazhala/close-buffers.nvim", module = "close_buffers" },

		{ -- fidget: spinners for lsp messages
			"j-hui/fidget.nvim",
			disable = not features.lsp,
			module = "fidget",
			event = "VeryLazy",
			config = function()
				require("coresetup.fidget").setup()
			end,
		},

		{ -- trouble: diagnostics
			"folke/trouble.nvim",
			cmd = { "TroubleToggle", "Trouble" },
			config = function()
				require("trouble").setup({
					auto_open = false,
					use_diagnostic_signs = true, -- en
				})
			end,
		},

		{ -- refactoring
			"ThePrimeagen/refactoring.nvim",
			disable = not features.refactoring,
			event = "VeryLazy",
			requires = {
				{ "nvim-lua/plenary.nvim" },
				{ "nvim-treesitter/nvim-treesitter" },
			},
		},

		{ -- treesitter playground
			"nvim-treesitter/playground",
			disable = not features.treesitter_playground,
			event = "VeryLazy",
			requires = {
				{ "nvim-treesitter/nvim-treesitter" },
			},
		},

		{ -- zk-nvim: Notes organiser
			"mickael-menu/zk-nvim",
			disable = not features.zk,
			event = "VeryLazy",
			module = { "zk" },
			config = function()
				require("coresetup.zk").setup()
			end,
		},

		{ -- Slim file type
			"slim-template/vim-slim",
			ft = { "slim" },
		},

		-- Themes
		{ "EdenEast/nightfox.nvim", event = "VeryLazy" },
		{ "cmoscofian/nibble-vim", event = "VeryLazy" },
		{ -- onedark
			"navarasu/onedark.nvim",
			event = "VeryLazy",
			config = function()
				require("onedark").setup({
					style = "warmer", -- dark, deep, warmer
				})
			end,
		}, --, event = { "User ColorAll", "User Color_onedark" },
		{ "projekt0n/github-nvim-theme", event = "VeryLazy" },
		{ "mcchrish/zenbones.nvim", event = "VeryLazy" },
		{ "catppuccin/nvim", as = "catppuccin-nvim", tag = "v0.2", event = "VeryLazy" },
		{ "rktjmp/lush.nvim", module = "lush" }, -- required by Zenbones
		{
			"tiagovla/tokyodark.nvim",
			event = "VeryLazy",
			config = function()
				vim.g.tokyodark_color_gamma = "1.5"
			end,
		},
		-- { "dracula/vim", as = "dracula-vim" },
		-- { "cmoscofian/nibble-vim" }
		-- { "embark-theme/vim", as = "embark-theme-vim" }
	}
end

return { get_packages = get_packages }

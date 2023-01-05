local features = BaseConfig.features

return {
	{ -- Plenary: Library for Telescope and many others
		"nvim-lua/plenary.nvim",
	},

	{ -- indent-o-matic: Detect indents
		"Darazaki/indent-o-matic",
		disable = not features.indent_detection,
	},

	{ -- vim-rooter: auto-cd-root
		"airblade/vim-rooter",
		disable = not features.auto_cd_root,
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

	{ -- lspkind
		"onsails/lspkind-nvim",
		module = "lspkind",
	},

	{ -- luasnip: Snippets, required by cmp
		"L3MON4D3/LuaSnip",
		disable = not features.completions,
		module = "luasnip",
	},
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-cmdline" },
	{ "hrsh7th/cmp-emoji" },
	{ "saadparwaiz1/cmp_luasnip" },

	{ -- Profile startup with :StartupTime
		"dstein64/vim-startuptime",
		cmd = "StartupTime",
		config = function()
			vim.g.startuptime_tries = 10
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
		config = function()
			require("spectre").setup({
				line_sep_start = "",
				result_padding = "   ",
				line_sep = "",
			})
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

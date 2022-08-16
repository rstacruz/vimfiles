local defaults = {
	ui = {
		theme_dark = "github_dark", -- terafox | github_dimmed | catppuccin
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
		welcome_screen = false,

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

return { defaults = defaults }

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
		welcome_screen = true,

		-- Experimental
		refactoring = false,
		treesitter_playground = true,
		treesitter_context = true,
		pounce = false,
		zk = false,

		-- these might not be worth disabling I think
		hop = true,
		file_explorer = true,
		gitsigns = true,
		indent_detection = true,
		indent_guides = true,
		scrollbars = true,
		neogit = true,

		-- To be removed
		autopairs = false, -- I don't like it
		alternate_filetypes = false, -- Used for better Astro support, but Treesitter now supports .astro
	},

	pane_navigation = {
		-- Don't resize these sidebars
		excluded_filetypes = { "NvimTree", "DiffviewFiles" },

		-- Minimum width of panes when navigating using ctrl-h and ctrl+n. Use -1
		-- to disable
		min_width = 80,
	},
}

return { defaults = defaults }

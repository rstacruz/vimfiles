local defaults = {
	ui = {
		-- github_dark | terafox | github_dimmed | catppuccin
		theme_dark = "tokyodark",
		-- github_light | dayfox | onedark
		theme_light = "dawnfox",
	},

	-- Feature toggles to optimise loading times for some environments
	features = {
		auto_cd_root = true,
		lsp = true,
		lsp_installer = true,
		completions = true,
		treesitter = true,
		github_fugitive = true,
		status_line = true,
		welcome_screen = true,

		-- Experimental
		refactoring = true,
		treesitter_playground = true,
		treesitter_context = true,
		zk = false,
		octo = true,

		-- Hops
		hop = true, -- s<char>, has 1char and 2char modes
		pounce = false, -- s<char><char><uppercas>
		leap = false, -- s<char><char><lowercase> (forward), and S for backward

		-- these might not be worth disabling I think
		file_explorer = true,
		gitsigns = true,
		indent_detection = true,
		indent_guides = true,
		scrollbars = true,
		neogit = true,

		-- To be removed
		autopairs = false, -- I don't like it
	},

	pane_navigation = {
		-- Don't resize these sidebars
		excluded_filetypes = { "NvimTree", "DiffviewFiles", "Outline" },

		-- Minimum width of panes when navigating using ctrl-h and ctrl+n. Use -1
		-- to disable
		min_width = 80,
	},
}

return { defaults = defaults }

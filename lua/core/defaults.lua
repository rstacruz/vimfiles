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
		zk = false,

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

	-- lspconfig mappings are available here:
	-- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/lua/mason-lspconfig/mappings/server.lua
	--
	-- null-ls tools are available here:
	-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
	--
	-- Install the tools with :Mason (leader-ci), then if the tool is installed,
	-- they can be used here
	lsp_tools = {
		{ bin = "lua-language-server", lspconfig = "sumneko_lua" },
		{ bin = "typescript-language-server", lspconfig = "tsserver" },
		{ bin = "astro-language-server", lspconfig = "astro" },
		{ bin = "svelte-language-server", lspconfig = "svelte" },
		{ bin = "solargraph", lspconfig = "solargraph" },
		{ bin = "stylua", null_ls_formatting = "stylua" },
		{
			bin = "prettierd",
			null_ls_formatting = "prettierd",
			root_pattern = { ".prettierrc", ".prettierignore", ".prettierrc.js" },
		},
		-- { bin = "marksman", lspconfig = "marksman", root_pattern = { ".marksman.toml" } },
		{ bin = "zk", lspconfig = "zk", root_pattern = { ".zk" } },
	},

	-- Plugin setup overrides
	plugins = {},
}

return { defaults = defaults }

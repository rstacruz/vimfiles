-- nvim-tree: File explorer
local M = {
	"nvim-tree/nvim-tree.lua",
	disable = not BaseConfig.features.file_explorer,
	event = "VeryLazy",
}

local special_files = {
	"Cargo.toml",
	"Makefile",
	-- git
	".git",
	".gitignore",
	".gitattributes",
	".gitmodules",
	-- docs
	"README.md",
	-- js
	"package.json",
	"package-lock.json",
	"yarn.lock",
	".babelrc",
	".babel.config.js",
	".babel.config.cjs",
	".babel.config.mjs",
	".prettierrc",
	".prettierignore",
	".npmrc",
	".npmignore",
	"postcss.config.js",
	"tailwind.config.js",
	"tsconfig.json",
	"jsconfig.json",
	-- Docker
	".dockerignore",
	-- lua
	".luarc.json",
	".luacheckrc",
	"packer.lock",
	"stylua.toml",
	-- special
	".vscode",
	".obsidian",
	".pre-commit-config.yaml",
	".stignore",
}

function M.config()
	require("nvim-tree").setup({
		sync_root_with_cwd = true,
		view = {
			width = 30,
		},
		renderer = {
			-- Hide the trailing / in folders (default: true)
			add_trailing = false,

			-- Hide these files
			special_files = special_files,

			-- Lines
			indent_markers = {
				enable = true,
			},

			icons = {
				-- Show git (default: "before")
				git_placement = "after",
				glyphs = {
					default = "",
					symlink = "",
					git = {
						unstaged = "",
						staged = "●",
						unmerged = "",
						renamed = "➜",
						deleted = "",
						untracked = "◌",
						ignored = "◌",
					},
				},
			},
			-- Display staged files with a different colour
			highlight_git = true,
			-- Only show "nvim" rather than "~/.config/nvim"
			root_folder_modifier = ":t",
		},
		filters = {
			dotfiles = false,
			custom = { "node_modules", "\\.cache" },
			exclude = {},
		},
		actions = {
			open_file = {
				window_picker = {
					-- Disable the "pick window" behaviour when there is more than one open.
					-- Instead, choose the last window.
					enable = false,
				},
			},
		},
	})
end

return M
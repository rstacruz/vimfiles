local M = {
	"folke/which-key.nvim",
	event = "VeryLazy",
}

function M.config()
	require("which-key").setup({
		window = {
			border = "none", -- none single double shadow
			position = "bottom",
			margin = { 0, 10, 2, 10 }, -- trbl
		},
		layout = {
			spacing = 6,
			height = { min = 25, max = 25 },
		},
		key_labels = {
			["<leader>"] = "",
			["<space>"] = "␣",
		},
		show_help = false,
		plugins = {
			presets = {
				operators = false, -- adds help for operators like d, y, ...
				motions = false, -- adds help for motions
				text_objects = false, -- help for text objects triggered after entering an operator
				windows = false, -- default bindings on <c-w>
				nav = true, -- misc bindings to work with windows
				z = true, -- bindings for folds, spelling and others prefixed with z
				g = true, -- bindings for prefixed with g
			},
		},
		icons = {
			breadcrumb = "›", -- in the command line area
			separator = "┄", -- between a key and it's label
			group = "", -- 
		},
	})

	require("core.keymap").setup()
end

return M

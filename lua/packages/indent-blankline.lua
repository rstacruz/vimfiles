-- indent-blankline: Indent guides
local M = {
	"lukas-reineke/indent-blankline.nvim",
	enabled = BaseConfig.features.indent_guides,

	-- Lazy-loading works, but has a flash of content without the lines.
	-- Using non-lazy adds maybe 1ms of startup time
	lazy = false,
	-- event = "VeryLazy",
}

function M.config()
	require("indent_blankline").setup({
		space_char_blankline = " ",
		char_list = { "│" },
		context_char_list = { "│" },
		show_trailing_blankline_indent = false,
		show_current_context = true,
		show_current_context_start = true,
		show_first_indent_level = false,
		filetype_exclude = {
			"lspinfo",
			"packer",
			"checkhealth",
			"",
			"startify",
			"toggleterm",
			"help",
			"spectre_panel",
		},
	})
end

return M

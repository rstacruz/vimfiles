local function setup()
	local has, indent_blankline = pcall(require, "indent_blankline")
	if not has then
		return
	end

	local options = {
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
	}

	indent_blankline.setup(options)
end

return { setup = setup }

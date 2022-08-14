local function setup()
	local has, indent_blankline = pcall(require, "indent_blankline")
	if not has then
		return
	end

	indent_blankline.setup({
		space_char_blankline = " ",
		show_current_context = true,
		show_current_context_start = true,
	})

	vim.g.indent_blankline_show_first_indent_level = true
	vim.g.indent_blankline_char_list = { "│" }
	vim.g.indent_blankline_context_char_list = { "│" }
	vim.g.indent_blankline_use_treesitter_scope = true
	vim.g.indent_blankline_filetype_exclude = {
		"lspinfo",
		"packer",
		"checkhealth",
		"",
		"startify",
		"toggleterm",
		"help",
		"spectre_panel",
	}
end

return { setup = setup }

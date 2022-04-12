-- Configs I don't use anymore
--
local utils = require("utils")

if utils.has_paq("vim-startify") then -- {{{
	vim.api.nvim_set_var(
		"startify_custom_indices",
		{ "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "r", "s", "t", "g", "z", "x", "c", "d", "v" }
	)
	vim.api.nvim_set_var("startify_custom_header", {
		"       ",
		"   n    i  m",
		"       ",
	})
	vim.api.nvim_set_var("startify_change_to_vcs_root", 1)
	vim.api.nvim_set_var("startify_enable_unsafe", 1)
	vim.api.nvim_command([[
  let g:startify_lists = []
  let g:startify_lists += [ { 'type': 'dir', 'header': ['  Recent files'] } ]
  let g:startify_lists += [ { 'type': 'sessions', 'header': ['  Sessions'] } ]
  ]])
end -- }}}

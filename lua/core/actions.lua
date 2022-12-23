-- Open git files, fall back to find files
-- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#falling-back-to-find_files-if-git_files-cant-find-a-git-directory
local function open_file_picker()
	local ok = pcall(require("telescope.builtin").git_files, { show_untracked = true })
	if not ok then
		require("telescope.builtin").find_files()
	end
end

local function show_keymaps()
	require("telescope.builtin").keymaps({
		show_plug = false,
		lhs_filter = function(key)
			if string.match(key, "^ ") then
				return true
			end
		end,
	})
end

local function open_terminal()
	local shell = vim.env.SHELL
	vim.cmd("vsplit")
	vim.cmd("term " .. shell)
end

local function open_colorscheme_picker()
	require("telescope.builtin").colorscheme({ enable_preview = true })
end

return {
	open_file_picker = open_file_picker,
	open_terminal = open_terminal,
	open_colorscheme_picker = open_colorscheme_picker,
	show_keymaps = show_keymaps,
}

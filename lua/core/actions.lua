-- Open git files, fall back to find files
-- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#falling-back-to-find_files-if-git_files-cant-find-a-git-directory
local function open_file_picker()
	local ok = pcall(require("telescope.builtin").git_files, { show_untracked = true })
	if not ok then
		require("telescope.builtin").find_files()
	end
end

local function open_terminal()
	local shell = BaseConfig.terminal.shell or vim.env.SHELL
	vim.cmd("vsplit")
	vim.cmd("term " .. shell)
end

return {
	open_file_picker = open_file_picker,
	open_terminal = open_terminal,
}

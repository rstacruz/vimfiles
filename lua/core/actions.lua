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

local function open_custom_settings()
	local fname = vim.fn.stdpath("config") .. "/lua/custom/init.lua"
	vim.cmd("vsplit " .. fname)

	if vim.fn.getbufinfo("%")[1].linecount == 1 then
		local example = vim.fn.stdpath("config") .. "/lua/custom/init.lua.example"
		local lines = vim.fn.readfile(example, "", 999)
		local offset = 3 -- Skip the first few lines
		vim.fn.append(0, vim.list_slice(lines, offset + 1))
	end
end

return {
	open_file_picker = open_file_picker,
	open_terminal = open_terminal,
	open_custom_settings = open_custom_settings,
}

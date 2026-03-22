local M = {}

function M.open_opencode()
	if vim.fn.executable("opencode") == 0 then
		vim.notify("opencode not found in PATH", vim.log.levels.ERROR)
		return
	end

	vim.cmd("tabnew | term opencode")
	vim.cmd.startinsert()
end

function M.setup()
	vim.api.nvim_create_user_command("OpenCode", M.open_opencode, { desc = "Terminal: open OpenCode in a new tab" })
end

return M

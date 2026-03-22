local M = {}

function M.open_opencode()
	if vim.fn.executable("opencode") == 0 then
		vim.notify("opencode not found in PATH", vim.log.levels.ERROR)
		return
	end

	vim.cmd("tabnew | term opencode")
	vim.cmd.startinsert()
end

---@param opts { args: string }
function M.attach_opencode(opts)
	if vim.fn.executable("opencode") == 0 then
		vim.notify("opencode not found in PATH", vim.log.levels.ERROR)
		return
	end

	local port = (opts.args ~= "") and opts.args or "40970"
	local url = "http://127.0.0.1:" .. port

	vim.cmd("tabnew | term opencode attach " .. url .. " --dir .")
	vim.cmd.startinsert()
end

function M.setup()
	vim.api.nvim_create_user_command("OpenCode", M.open_opencode, { desc = "Terminal: open OpenCode" })
	vim.api.nvim_create_user_command("OpenCodeAttach", M.attach_opencode, { nargs = "?", desc = "Terminal: attach OpenCode" })
end

return M

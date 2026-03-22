local M = {}

---@param cmd string Shell command to run in the new tab
---@param title? string Buffer name for the new tab
local function run_in_tab(cmd, title)
	if vim.fn.executable("opencode") == 0 then
		vim.notify("opencode not found in PATH", vim.log.levels.ERROR)
		return
	end

	vim.cmd("tabnew | term " .. cmd)
	if title then
		pcall(vim.api.nvim_buf_set_name, 0, title)
	end
	vim.cmd.startinsert()
end

function M.open_opencode()
	run_in_tab("opencode", "OpenCode")
end

---@param opts { args: string }
function M.attach_opencode(opts)
	local port = (opts.args ~= "") and opts.args or "40970"
	run_in_tab("opencode attach http://127.0.0.1:" .. port .. " --dir .", "OpenCodeAttach")
end

function M.setup()
	vim.api.nvim_create_user_command("OpenCode", M.open_opencode, { desc = "Terminal: open OpenCode" })
	vim.api.nvim_create_user_command(
		"OpenCodeAttach",
		M.attach_opencode,
		{ nargs = "?", desc = "Terminal: attach OpenCode" }
	)
end

return M

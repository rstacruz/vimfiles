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
	local server = (opts.args ~= "") and opts.args or vim.env.OPENCODE_SERVER_URL or "http://127.0.0.1:4096"
	run_in_tab("opencode attach " .. server .. " --dir .", "OpenCode")
end

---@param opts? { auto_open?: boolean }
function M.setup(opts)
	vim.api.nvim_create_user_command("OpenCode", M.open_opencode, { desc = "Terminal: open OpenCode" })
	vim.api.nvim_create_user_command(
		"OpenCodeAttach",
		M.attach_opencode,
		{ nargs = "?", desc = "Terminal: attach OpenCode" }
	)
	if opts and opts.auto_open then
		vim.api.nvim_create_autocmd("VimEnter", { once = true, callback = M.open_opencode })
	end
end

return M

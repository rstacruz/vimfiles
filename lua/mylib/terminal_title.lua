local M = {}

---@param bufnr integer
---@return string?
local function get_terminal_title(bufnr)
	if vim.bo[bufnr].buftype ~= "terminal" then
		return nil
	end

	local name = vim.api.nvim_buf_get_name(bufnr)
	local cmd = name:match("term://.-//%d+:(.+)$")
	if not cmd or cmd == "" then
		return vim.fn.fnamemodify(vim.o.shell, ":t")
	end

	local argv0 = vim.split(cmd, " ", { plain = true })[1] or cmd
	return vim.fn.fnamemodify(argv0, ":t")
end

M.setup = function()
	local default_titlestring = vim.o.titlestring
	local group = vim.api.nvim_create_augroup("terminal_title", { clear = true })

	local function update_current_window()
		local title = get_terminal_title(vim.api.nvim_get_current_buf())
		if not title then
			return
		end

		vim.api.nvim_buf_set_name(0, title)
	end

	vim.o.title = true
	vim.api.nvim_create_autocmd({ "BufEnter", "TermEnter", "TermOpen", "WinEnter" }, {
		group = group,
		callback = update_current_window,
	})
end

return M

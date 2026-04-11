-- Automatically sets terminal title
local M = {}

---@param bufnr integer
---@return string?
local function get_terminal_source_name(bufnr)
	if vim.bo[bufnr].buftype ~= "terminal" then
		return nil
	end

	local cached_name = vim.b[bufnr].terminal_title_source_name
	if cached_name and cached_name ~= "" then
		return cached_name
	end

	local current_name = vim.api.nvim_buf_get_name(bufnr)
	if current_name:match("^term://") then
		vim.b[bufnr].terminal_title_source_name = current_name
	end

	return current_name
end

---@param bufnr integer
---@return string?
local function get_terminal_title(bufnr)
	local name = get_terminal_source_name(bufnr)
	if not name or name == "" then
		return nil
	end

	if not name:match("^term://") then
		return name
	end

	local cmd = name:match("term://.-//%d+:(.+)$")
	if not cmd or cmd == "" then
		return vim.fn.fnamemodify(vim.o.shell, ":t")
	end

	local argv0 = vim.split(cmd, " ", { plain = true })[1] or cmd
	return vim.fn.fnamemodify(argv0, ":t")
end

---@param bufnr integer
---@param target_name string
---@return string
local function to_buffer_name(target_name)
	if target_name == "" or target_name:match("^%a[%w+.-]*://") then
		return target_name
	end

	return vim.fn.fnamemodify(target_name, ":p")
end

---@param bufnr integer
---@param target_name string
---@return boolean
local function name_is_in_use(bufnr, target_name)
	target_name = to_buffer_name(target_name)

	for _, other_bufnr in ipairs(vim.api.nvim_list_bufs()) do
		if other_bufnr ~= bufnr and vim.api.nvim_buf_is_valid(other_bufnr) then
			if vim.api.nvim_buf_get_name(other_bufnr) == target_name then
				return true
			end
		end
	end

	return false
end

---@param value string
---@return string, integer?
local function parse_suffix(value)
	local base_title, suffix = value:match("^(.-) %[(%d+)%]$")
	if not base_title or not suffix then
		return value, nil
	end

	return base_title, tonumber(suffix)
end

---@param bufnr integer
---@param base_title string
---@return string
local function get_unique_terminal_title(bufnr, base_title)
	local resolved_base_title = to_buffer_name(base_title)
	local current_name = vim.api.nvim_buf_get_name(bufnr)
	if current_name == resolved_base_title then
		return resolved_base_title
	end

	local current_base, current_suffix = parse_suffix(vim.fn.fnamemodify(current_name, ":t"))
	if current_base == base_title and current_suffix and not name_is_in_use(bufnr, current_name) then
		return current_name
	end

	if not name_is_in_use(bufnr, resolved_base_title) then
		return resolved_base_title
	end

	local index = 2
	while true do
		local candidate = to_buffer_name(string.format("%s [%d]", base_title, index))
		if not name_is_in_use(bufnr, candidate) then
			return candidate
		end

		index = index + 1
	end
end

M.setup = function()
	local group = vim.api.nvim_create_augroup("terminal_title", { clear = true })

	local function update_current_window()
		local bufnr = vim.api.nvim_get_current_buf()
		local title = get_terminal_title(bufnr)
		if not title then
			return
		end

		local resolved_title = get_unique_terminal_title(bufnr, title)
		if vim.api.nvim_buf_get_name(bufnr) == resolved_title then
			return
		end

		pcall(vim.api.nvim_buf_set_name, bufnr, resolved_title)
	end

	vim.o.title = true
	vim.api.nvim_create_autocmd({ "BufEnter", "TermEnter", "TermOpen", "WinEnter" }, {
		group = group,
		callback = update_current_window,
	})
end

return M

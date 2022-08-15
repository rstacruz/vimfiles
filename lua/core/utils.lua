---@class BindOnceOptions
---@field group_name string
---@field events table<string>
---@field callback function

-- Bind an event to an autocmd, but only fire it once.
---@param options BindOnceOptions
local function bind_once(options)
	local augroup_name = options.group_name
	local events = options.events
	local group = vim.api.nvim_create_augroup(augroup_name, { clear = true })

	vim.api.nvim_create_autocmd(events, {
		pattern = "*",
		group = group,
		callback = function()
			vim.api.nvim_del_augroup_by_name(augroup_name)
			options.callback()
		end,
	})
end

---@param callback function
local function on_file_load(callback)
	bind_once({
		group_name = "on_file_load",
		events = { "BufRead", "BufWinEnter", "BufNewFile" },
		callback = callback,
	})
end

---@param callback function
local function on_vimenter(callback)
	bind_once({
		group_name = "on_vimenter",
		events = { "VimEnter" },
		callback = callback,
	})
end

return {
	on_file_load = on_file_load,
	on_vimenter = on_vimenter,
}

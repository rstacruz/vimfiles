-- Bind an event to an autocmd, but only fire it once.
---@param event table|string
---@param callback function
local function once(event, callback)
	local augroup_name = "BindOnce" .. type(event) == "table" and event[1] or event
	local group = vim.api.nvim_create_augroup(augroup_name, { clear = true })

	vim.api.nvim_create_autocmd(event, {
		pattern = "*",
		group = group,
		callback = function()
			vim.api.nvim_del_augroup_by_name(augroup_name)
			callback()
		end,
	})
end

-- Applies overrides to a configuation.
--   local config = { show = true }
--
--   Tables: extend the config
--   apply_config_overrides(config, { quiet = false })
--   --> { show = true, quiet = false }
--
--   Functions: run it
--   apply_config_overrides(config, function(config)
--     config.quiet = false
--   end)
--   --> { show = true, quiet = false }
--
local function apply_config_overrides(object, override)
	if not override then
		return object
	elseif type(override) == "function" then
		local result = override(object)
		return result or object
	elseif type(override) == "table" then
		return vim.tbl_deep_extend("force", object, override)
	end
end

local function on_colorscheme_change(options)
	local prefix = options.prefix or ""
	local callback = options.callback
	local group = vim.api.nvim_create_augroup(prefix .. "Colorscheme", { clear = true })
	vim.api.nvim_create_autocmd("Colorscheme", {
		pattern = "*",
		group = group,
		callback = callback,
	})
end

return {
	once = once,
	apply_config_overrides = apply_config_overrides,
	on_colorscheme_change = on_colorscheme_change,
}

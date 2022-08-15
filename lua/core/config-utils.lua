local function apply_overrides(key, config)
	local has, custom = pcall(require, "custom.init")

	if has and custom[key] then
		local result = custom[key](config)
		if result then
			-- returning an object will merge it
			return vim.tbl_deep_extend("force", config, result)
		else
			-- mutating an object
			return config
		end
	else
		return config
	end
end

return { apply_overrides = apply_overrides }

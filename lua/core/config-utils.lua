local function apply_overrides(key, config)
	local has, custom = pcall(require, "custom.init")
	if has and custom[key] then
		custom[key](config)
	end
end

return { apply_overrides = apply_overrides }

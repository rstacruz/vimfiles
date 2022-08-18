local function setup()
	local has, autopairs = pcall(require, "nvim-autopairs")
	if not has then
		return
	end

	local options = {}

	require("core.utils").apply_config_overrides(options, BaseConfig.plugins.nvim_autopairs)
	autopairs.setup(options)
end

return { setup = setup }

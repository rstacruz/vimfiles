local function setup()
	local has, surround = pcall(require, "nvim-surround")
	if not has then
		return
	end

	local options = {}

	require("core.utils").apply_config_overrides(options, BaseConfig.plugins.nvim_surround)
	surround.setup(options)
end

return { setup = setup }

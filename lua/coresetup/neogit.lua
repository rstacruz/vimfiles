local function setup()
	local has, neogit = pcall(require, "neogit")
	if not has then
		return
	end

	local options = {
		signs = {
			section = { " ", " " },
			item = { " ", " " },
		},
		integrations = {
			diffview = true, -- uses sindrets/diffview.nvim
		},
	}

	require("core.utils").apply_config_overrides(options, BaseConfig.plugins.neogit)

	neogit.setup(options)
end

return { setup = setup }

local function setup()
	local features = BaseConfig.features

	local has, workspaces = pcall(require, "workspaces")
	if not has then
		return
	end

	workspaces.setup({
		global_cd = true,
		hooks = {
			open_pre = { "%bd!" },
			open = features.file_explorer and { "NvimTreeOpen" } or nil,
		},
	})

	local has_telescope, telescope = pcall(require, "telescope")
	if has_telescope then
		telescope.load_extension("workspaces")
	end
end

return { setup = setup }

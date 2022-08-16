local function setup()
	local features = BaseConfig.features

	-- Use the UI from dressing.nvim for :WorkspacesList, if it's available
	pcall(require, "dressing")

	local has, workspaces = pcall(require, "workspaces")
	if not has then
		return
	end

	workspaces.setup({
		global_cd = true,
		hooks = {
			open_pre = { "silent %bd!" },
			open = features.file_explorer and { "NvimTreeOpen" } or nil,
		},
	})

	local has_telescope, telescope = pcall(require, "telescope")
	if has_telescope then
		telescope.load_extension("workspaces")
	end
end

return { setup = setup }

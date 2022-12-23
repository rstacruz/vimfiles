-- workspaces: Project switcher
local M = {
	"natecraddock/workspaces.nvim",
	disable = not BaseConfig.features.workspaces,
	module = "workspaces",
	cmd = { "WorkspacesAdd", "WorkspacesRemove", "WorkspacesList", "WorkspacesOpen" },
}

function M.config()
	local features = BaseConfig.features

	-- Use the UI from dressing.nvim for :WorkspacesList, if it's available
	pcall(require, "dressing")

	require("workspaces").setup({
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

return M

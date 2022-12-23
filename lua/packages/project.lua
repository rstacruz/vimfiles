-- project: project switcher
local M = {
	"ahmedkhalf/project.nvim",
	disable = not BaseConfig.features.project_switcher,
	-- module = { "project_nvim", "telescope._extensions.projects" },
}

function M.config()
	-- https://github.com/ahmedkhalf/project.nvim#%EF%B8%8F-configuration
	require("project_nvim").setup({})
end

return M

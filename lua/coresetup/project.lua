local function setup()
	local has, project_nvim = pcall(require, "project_nvim")
	if not has then
		return
	end

	-- https://github.com/ahmedkhalf/project.nvim#%EF%B8%8F-configuration
	local options = {}

	project_nvim.setup(options)
end

return { setup = setup }

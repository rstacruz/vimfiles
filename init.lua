pcall(require, "impatient")

-- Load configuration
BaseConfig = require("core.defaults").defaults
pcall(require, "custom.init")

-- Set Neovim options
require("coresetup.nvim-options").setup()

-- Packer packages
local packages = require("core.packages").get_packages(BaseConfig.features)

-- Install packer and install packages
if require("core.packer-utils").bootstrap_packer(packages) == false then
	return
end

-- Apply theme
require("core.theme-overrides").setup()
require("core.theme-utils").setup()

-- Defer loading some plugins until Vim is idle
require("core.utils").once("UIEnter", function()
	vim.defer_fn(function()
		vim.cmd([[doautocmd User OnIdle]])
		require("core.reload-utils").setup()
		require("coresetup.autocmds").setup()
	end, 1)
end)

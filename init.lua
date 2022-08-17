pcall(require, "impatient")

-- Load configuration
BaseConfig = require("core.defaults").defaults
pcall(require, "custom.init")

-- Set Neovim options
require("coresetup.nvim-options").setup()

-- Packer packages
local features = BaseConfig.features
local packages = require("core.packages").get_packages(features)

-- Install packer and install packages
if require("core.packer-utils").bootstrap_packer(packages) == false then
	return
end

require("core.theme-overrides").setup()
require("core.theme-utils").setup()

local utils = require("core.utils")

-- Defer loading some plugins until Vim is idle
utils.on_vimenter(function()
	vim.schedule(function()
		vim.cmd([[doautocmd User OnIdle]])
		require("core.auto-format").setup()
		require("core.reload-utils").setup()
		require("coresetup.autocmds").setup()
	end)
end)

utils.on_file_load(function()
	vim.schedule(function()
		vim.cmd([[doautocmd User OnFileLoad]])
	end)
end)

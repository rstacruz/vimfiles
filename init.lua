local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.runtimepath:prepend(lazypath)

-- Load configuration
BaseConfig = require("core.defaults").defaults

-- Set Neovim options
require("coresetup.nvim-options").setup()

-- Lazy packages (lazy can't be reinitialised)
if not vim.g.hot_reload then
	local packages = require("core.packages").get_packages(BaseConfig.features)
	require("coresetup.lazy").setup(packages)
end

-- Apply theme
require("core.theme-overrides").setup()
require("core.theme-utils").setup()
require("coresetup.autocmds").setup() -- has filetype stuff, so can't be deferred

-- Defer loading some plugins until Vim is idle
vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		require("core.reload-utils").setup()
	end,
})

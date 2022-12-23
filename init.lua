-- Load configuration
BaseConfig = require("core.defaults").defaults
require("core.nvim-options").setup()

-- Install Packages
if not vim.g.hot_reload then
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
	require("core.lazy").setup()
end

-- Things that can't be deferred
require("core.theme-overrides").setup()
require("core.theme-utils").setup()
require("core.autocmds").setup()

-- Defer loading some plugins until Vim is idle
vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		require("core.reload-utils").setup()
	end,
})

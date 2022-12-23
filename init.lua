-- Load configuration
BaseConfig = require("core.defaults").defaults
require("core.nvim-options").setup()
require("core.lazy").setup()
require("core.theme-overrides").setup()
require("core.theme-utils").setup()
require("core.autocmds").setup()

-- Defer loading some plugins until Vim is idle
vim.api.nvim_create_autocmd("User", {
	group = vim.api.nvim_create_augroup("KeymapSetup", { clear = true }),
	pattern = "VeryLazy",
	callback = function()
		require("core.keymap").setup()
	end,
})

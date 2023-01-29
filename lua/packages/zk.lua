-- zk-nvim: Notes organiser
local M = {
	"mickael-menu/zk-nvim",
	enable = BaseConfig.features.zk,
	event = "VeryLazy",
}

function M.config()
	require("zk").setup({
		-- use Telescope rather than vim.ui.select
		picker = "telescope",
	})
end

return M

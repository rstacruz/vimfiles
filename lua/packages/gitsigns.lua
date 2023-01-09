-- gitsigns: Git indicators on the gutter
local M = {
	"lewis6991/gitsigns.nvim",
	enabled = BaseConfig.features.gitsigns,
	event = "VeryLazy",
	module = "gitsigns",
	cmd = { "Gitsigns" },
}

function M.config()
	require("gitsigns").setup({
		signs = {
			changedelete = { text = "▌" }, -- Originally "~"
			change = { text = "▌" },
			add = { text = "▌" },
		},
	})
end

return M

local M = {
	"TimUntersberger/neogit",
	disable = not BaseConfig.features.neogit,
	cmd = { "Neogit" },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim",
	},
}

function M.config()
	require("neogit").setup({
		signs = {
			section = { " ", " " },
			item = { " ", " " },
		},
		integrations = {
			diffview = true, -- uses sindrets/diffview.nvim
		},
	})
end

return M

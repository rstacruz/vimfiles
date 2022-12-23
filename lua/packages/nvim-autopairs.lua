local M = {
	"windwp/nvim-autopairs",
	disable = not BaseConfig.features.autopairs,
	event = "VeryLazy",
}

function M.config()
	require("nvim-autopairs").setup({})
end

return M

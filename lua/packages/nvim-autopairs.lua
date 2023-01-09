local M = {
	"windwp/nvim-autopairs",
	enabled = BaseConfig.features.autopairs,
	event = "VeryLazy",
}

function M.config()
	require("nvim-autopairs").setup({})
end

return M

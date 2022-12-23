local M = {
	-- navic: status bar display of context
	"SmiteshP/nvim-navic",
	disable = not BaseConfig.features.lsp,
	-- module = "nvim-navic",
}

function M.config()
	vim.g.navic_available = true
	vim.g.navic_silence = true

	require("nvim-navic").setup({
		separator = "  ",

		-- Provide different highlights. But it's not very reliable
		-- highlight = true,
	})
end

return M

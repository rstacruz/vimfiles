return {
	"simrat39/symbols-outline.nvim",
	event = "VeryLazy",
	config = function()
		require("symbols-outline").setup({})
	end,
	keys = {
		{ "<leader>co", "<cmd>SymbolsOutline<cr>", desc = "Show symbols" },
	},
}

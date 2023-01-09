-- treesitter-context: Show context lines at the top
local M = {
	"nvim-treesitter/nvim-treesitter-context",
	enabled = BaseConfig.features.treesitter_context,
	event = "BufReadPre",
}

function M.config()
	require("treesitter-context").setup({})
end

return M

-- nvim-surround: surround keybindings (cs, ds, ys)
local M = {
	"kylechui/nvim-surround",
	disable = not BaseConfig.features.treesitter,
	event = "VeryLazy",
}

function M.config()
	require("nvim-autopairs").setup({})
end

return M

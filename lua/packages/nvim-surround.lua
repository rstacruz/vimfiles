-- nvim-surround: surround keybindings (cs, ds, ys)
--
--     cs'"   -- change surrounding ['] to ["]
--     csth1  -- change [t]ag to [h1]
--     ysiw"  -- surround current [w]ord with ["]
--
local M = {
	"kylechui/nvim-surround",
	enabled = BaseConfig.features.treesitter,
	event = "VeryLazy",
}

function M.config()
	require("nvim-surround").setup({})
end

return M

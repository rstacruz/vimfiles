local M = { -- hop: Easymotion-style jumps
	"phaazon/hop.nvim",
	disable = not BaseConfig.features.hop,
	cmd = {
		"HopLine",
		"HopLineMW",
		"HopWord",
		"HopWordMW",
		"HopPattern",
		"HopPatternMW",
		"HopChar1",
		"HopChar1MW",
		"HopChar2",
		"HopChar2MW",
	},
}

function M.config()
	require("hop").setup({ keys = "arstgmneiowfpyulcdh" })
end

return M

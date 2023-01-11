local M = { -- hop: Easymotion-style jumps
	"phaazon/hop.nvim",
	enabled = BaseConfig.features.hop,
	cmd = {
		"HopLine",
		"HopLineMW",
		"HopLineStart",
		"HopLineStartMW",
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

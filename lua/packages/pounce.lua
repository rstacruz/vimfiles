return {
	"rlane/pounce.nvim",
	disable = not BaseConfig.features.pounce,
	event = "VeryLazy",
	config = function()
		require("pounce").setup({})
	end,
}

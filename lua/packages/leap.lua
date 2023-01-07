return {
	"ggandor/leap.nvim",
	event = "VeryLazy",
	disable = not BaseConfig.features.leap,
	config = function()
		require("leap").add_default_mappings()
	end,
}

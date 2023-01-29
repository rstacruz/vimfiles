return {
	"ggandor/leap.nvim",
	event = "VeryLazy",
	enabled = BaseConfig.features.leap,
	config = function()
		require("leap").add_default_mappings()
	end,
}

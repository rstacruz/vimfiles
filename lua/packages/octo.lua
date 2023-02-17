-- octo: GitHub PR manager
-- https://github.com/pwntester/octo.nvim
--
-- :Octo pr list
-- :Octo review start -- show changes in PR
--   [q ]q to navigate through
--
return {
	"pwntester/octo.nvim",
	enabled = BaseConfig.features.octo,
	event = "VeryLazy",
	config = function()
		require("octo").setup({})
	end,
}

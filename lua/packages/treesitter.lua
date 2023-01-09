local M = {
	"nvim-treesitter/nvim-treesitter",
	enabled = BaseConfig.features.treesitter,
	module = "nvim-treesitter",
	run = ":TSUpdate",
	cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSEnable", "TSDisable", "TSModuleInfo" },
	requires = {
		{ "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" },
	},
}

function M.config()
	local nvim_treesitter = require("nvim-treesitter.configs")

	nvim_treesitter.setup({
		ensure_installed = { "lua" },
		auto_install = true, -- Auto install when entering buffers
		ignore_install = {
			"ruby", -- As of Neovim 0.8, it hangs in ERB
		},
		matchup = { enable = true },
		indent = { enable = true },
		autotag = { enable = true },
		highlight = {
			enable = true,
			use_languagetree = true,
		},
		textobjects = {
			select = {
				enable = true,
				lookahead = true,
				keymaps = {
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@class.outer",
					["ic"] = "@class.inner",
				},
			},
		},
	})

	vim.o.foldmethod = "expr"
	vim.o.foldexpr = "nvim_treesitter#foldexpr()"
end

return M

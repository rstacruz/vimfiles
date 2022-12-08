local function setup()
	local is_available, nvim_treesitter = pcall(require, "nvim-treesitter.configs")
	if not is_available then
		return
	end

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

return { setup = setup, config = config }

return {
	{
		"neovim/nvim-lspconfig",
		disable = not BaseConfig.features.lsp,
	},
	{
		"williamboman/mason.nvim",
		disable = not BaseConfig.features.lsp,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		disable = not BaseConfig.features.lsp,
		event = "VeryLazy",
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup()

			local lspconfig = require("lspconfig")
			local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

			require("mason-lspconfig").setup_handlers({
				function(server_name) -- default
					lspconfig[server_name].setup({
						capabilities = lsp_capabilities,
					})
				end,
			})
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		disable = not BaseConfig.features.lsp,
		event = "VeryLazy",
		config = function()
			local nls = require("null-ls")
			nls.setup({
				-- root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", ".git"),
				sources = {
					nls.builtins.formatting.stylua,
					nls.builtins.formatting.prettierd,
					nls.builtins.formatting.eslint_d,
					nls.builtins.formatting.isort,
					nls.builtins.formatting.fish_indent,
				},
			})
		end,
	},
}

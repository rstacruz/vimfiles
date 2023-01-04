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
		event = "BufRead",
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup()

			local has_navic, navic = pcall(require, "nvim-navic")
			local on_attach = has_navic and navic.attach or nil

      local lspconfig = require('lspconfig')
      local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

			require("mason-lspconfig").setup_handlers({
				function(server_name) -- default
					require("lspconfig")[server_name].setup({
						on_attach = on_attach,
            capabilities = lsp_capabilities
					})
				end,
			})
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		disable = not BaseConfig.features.lsp,
		event = "BufRead",
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

-- -- lspconfig mappings are available here:
-- -- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/lua/mason-lspconfig/mappings/server.lua
-- --
-- -- null-ls tools are available here:
-- -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
-- --
-- -- Install the tools with :Mason (leader-ci), then if the tool is installed,
-- -- they can be used here
-- local config = {
-- 	tools = {
-- 		{ bin = "lua-language-server", lspconfig = "sumneko_lua" },
-- 		{ bin = "typescript-language-server", lspconfig = "tsserver" },
-- 		{ bin = "astro-ls", lspconfig = "astro" },
-- 		{ bin = "svelte-language-server", lspconfig = "svelte" },
-- 		{ bin = "solargraph", lspconfig = "solargraph" },
-- 		{ bin = "stylua", null_ls_formatting = "stylua" },
-- 		{
-- 			bin = "prettierd",
-- 			null_ls_formatting = "prettierd",
-- 			root_pattern = { ".prettierrc", ".prettierignore", ".prettierrc.js" },
-- 		},
-- 		-- { bin = "marksman", lspconfig = "marksman", root_pattern = { ".marksman.toml" } },
-- 		-- { bin = "zk", lspconfig = "zk", root_pattern = { ".zk" } },
-- 	},
-- }
--
-- local function has_mason_bin(bin_name)
-- 	return vim.fn.executable(vim.fn.stdpath("data") .. "/mason/bin/" .. bin_name) == 1
-- end
--
-- -- Checks if the tool `bin_name` is available. It checks Mason separately
-- -- because executable() can be expensive for some systems (eg, WSL2 that might
-- -- traverse NTFS to check for executables).
-- local function has_bin(bin_name)
-- 	return has_mason_bin(bin_name) or vim.fn.executable(bin_name) == 1
-- end

-- function M.configx()
-- 	-- Ensure mason is loaded first. This makes it so that the mason bin's are available
-- 	local has_mason, mason = pcall(require, "mason")
-- 	if has_mason then
-- 		mason.setup()
-- 	end
--
-- 	local has_lspconfig, lspconfig = pcall(require, "lspconfig")
-- 	if not has_lspconfig then
-- 		return
-- 	end
--
-- 	local has_navic, navic = pcall(require, "nvim-navic")
-- 	local on_attach = has_navic and navic.attach or nil
--
-- 	local has_null_ls, null_ls = pcall(require, "null-ls")
-- 	local null_sources = {}
--
-- 	for _, tool in ipairs(config.tools) do
-- 		if has_bin(tool.bin) then
-- 			local root_dir = nil
-- 			if tool.root_pattern then
-- 				root_dir = lspconfig.util.root_pattern(unpack(tool.root_pattern))
-- 			end
-- 			if tool.lspconfig then
-- 				lspconfig[tool.lspconfig].setup({
-- 					on_attach = on_attach,
-- 					root_dir = root_dir,
-- 				})
-- 			end
-- 			if tool.null_ls_formatting then
-- 				table.insert(null_sources, null_ls.builtins.formatting[tool.null_ls_formatting])
-- 			end
-- 			if tool.null_ls_code_actions then
-- 				table.insert(null_sources, null_ls.builtins.code_actions[tool.null_ls_code_actions])
-- 			end
-- 			if tool.null_ls_completion then
-- 				table.insert(null_sources, null_ls.builtins.completion[tool.null_ls_completion])
-- 			end
-- 			if tool.null_ls_diagnostics then
-- 				table.insert(null_sources, null_ls.builtins.diagnostics[tool.null_ls_diagnostics])
-- 			end
-- 		end
-- 	end
--
-- 	if has_null_ls then
-- 		null_ls.setup({ sources = null_sources })
-- 	end
-- end

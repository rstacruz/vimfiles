local function has_bin(bin_name)
	return vim.fn.filereadable(vim.fn.stdpath("data") .. "/mason/bin/" .. bin_name) == 1
end

-- Mappings are available here:
-- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/lua/mason-lspconfig/mappings/server.lua
local tools = {
	{ bin = "lua-language-server", lspconfig = "sumneko_lua" },
	{ bin = "typescript-language-server", lspconfig = "tsserver" },
	{ bin = "astro-language-server", lspconfig = "astro" },
	{ bin = "stylua", null_ls_formatting = "stylua" },
	{ bin = "prettierd", null_ls_formatting = "prettierd" },
}

local function setup()
	-- Ensure mason is loaded first. This makes it so that the mason bin's are available
	local has_mason, mason = pcall(require, "mason")
	if has_mason then
		mason.setup()
	end

	local has_lspconfig, lspconfig = pcall(require, "lspconfig")
	if not has_lspconfig then
		return
	end

	local has_navic, navic = pcall(require, "nvim-navic")
	local on_attach = has_navic and navic.attach or nil

	local has_null_ls, null_ls = pcall(require, "null-ls")
	local null_sources = {}

	for _, tool in ipairs(tools) do
		if has_bin(tool.bin) then
			if tool.lspconfig then
				lspconfig[tool.lspconfig].setup({ on_attach = on_attach })
			end
			if tool.null_ls_formatting then
				table.insert(null_sources, null_ls.builtins.formatting[tool.null_ls_formatting])
			end
			if tool.null_ls_code_actions then
				table.insert(null_sources, null_ls.builtins.code_actions[tool.null_ls_code_actions])
			end
			if tool.null_ls_completion then
				table.insert(null_sources, null_ls.builtins.completion[tool.null_ls_completion])
			end
			if tool.null_ls_diagnostics then
				table.insert(null_sources, null_ls.builtins.diagnostics[tool.null_ls_diagnostics])
			end
		end
	end

	if has_null_ls then
		null_ls.setup({ sources = null_sources })
	end
end

return { setup = setup }

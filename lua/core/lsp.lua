local function has_bin(bin_name)
	return vim.fn.filereadable(vim.fn.stdpath("data") .. "/mason/bin/" .. bin_name) == 1
end

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

	if has_bin("lua-language-server") then
		lspconfig.sumneko_lua.setup({ on_attach = on_attach })
	end

	if has_bin("typescript-language-server") then
		lspconfig.tsserver.setup({ on_attach = on_attach })
	end

	if has_bin("stylua") then
		table.insert(null_sources, null_ls.builtins.formatting.stylua)
	end

	if has_null_ls then
		null_ls.setup({ sources = null_sources })
	end
end

return { setup = setup }

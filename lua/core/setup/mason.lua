local function which(bin)
  return vim.fn.executable(bin) == 1
end

-- See also:
-- - Mapping lspconfig names to Mason: https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
local function setup()
  local _, mason = pcall(require, "mason")
  if not mason then
    return
  end

  local has_lspconfig, lspconfig = pcall(require, "lspconfig")
  if not has_lspconfig then
    return
  end

  local has_null_ls, null_ls = pcall(require, "null-ls")
  local has_installer, installer = pcall(require, "mason-tool-installer")

  mason.setup()

  local ensure_installed = {}
  local null_sources = {}

  if which("node") then
    -- lspconfig.astro.setup({})
    -- lspconfig.cssls.setup({})
    -- lspconfig.svelte.setup({})
    -- lspconfig.tailwindcss.setup({})
    lspconfig.tsserver.setup({})
    -- lspconfig.yamlls.setup({})
    table.insert(ensure_installed, "astro-language-server")
    table.insert(ensure_installed, "css-lsp")
    table.insert(ensure_installed, "eslint_d")
    table.insert(ensure_installed, "prettierd")
    table.insert(ensure_installed, "svelte-language-server")
    table.insert(ensure_installed, "tailwindcss-language-server")
    table.insert(ensure_installed, "typescript-language-server")
    table.insert(ensure_installed, "yaml-language-server")
    table.insert(null_sources, null_ls.builtins.code_actions.eslint_d)
    -- table.insert(null_sources, null_ls.builtins.diagnostics.eslint_d) -- Produces "no eslint configuration found"} error
    table.insert(null_sources, null_ls.builtins.formatting.eslint_d)
  end
  if which("lua") then
    lspconfig.sumneko_lua.setup({})
    table.insert(ensure_installed, "lua-language-server")
  end
  if which("ruby") then
    -- lspconfig.solargraph.setup({})
    table.insert(null_sources, null_ls.builtins.formatting.standardrb)
    table.insert(null_sources, null_ls.builtins.diagnostics.standardrb)
    -- table.insert(null_sources, null_ls.builtins.formatting.rubocop)
    -- table.insert(null_sources, null_ls.builtins.diagnostics.rubocop)
    table.insert(ensure_installed, "rubocop")
    table.insert(ensure_installed, "solargraph")
  end
  if which("cargo") then
    table.insert(ensure_installed, "stylua")
    table.insert(null_sources, null_ls.builtins.formatting.stylua)
  end

  if has_installer then
    installer.setup({
      ensure_installed = ensure_installed,
    })
  end

  -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
  if has_null_ls then
    null_ls.setup({ sources = null_sources })
  end
end

return { setup = setup }

local function which(bin)
  return vim.fn.executable(bin) == 1
end

local function setup()
  local _, mason = pcall(require, "mason")
  if not mason then return end

  local _, lspconfig = pcall(require, "lspconfig")
  if not lspconfig then return end

  local _, null_ls = pcall(require, "null-ls")
  if not null_ls then return end

  local _, masonLspConfig = pcall(require, "mason-lspconfig")
  local _, installer = pcall(require, "mason-tool-installer")

  mason.setup()

  local tools = {}
  local null_sources = {}

  if which("node") then
    table.insert(tools, "typescript-language-server")
    table.insert(tools, "yaml-language-server")
    table.insert(tools, "eslint_d")
    table.insert(tools, "prettierd")
    lspconfig.tsserver.setup({})
    lspconfig.yamlls.setup({})
  end
  if which("lua") then
    table.insert(tools, "lua-language-server")
    lspconfig.sumneko_lua.setup({})
  end
  if which("ruby") then
    table.insert(tools, "solargraph")
    table.insert(tools, "rubocop")
    lspconfig.solargraph.setup({})
  end
  if which("cargo") then
    table.insert(tools, "stylua")
  end

  if masonLspConfig then masonLspConfig.setup() end

  if installer then
    installer.setup({
      ensure_installed = tools,
    })
  end

  -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
  if null_ls then
    null_ls.setup({ sources = null_sources })
  end
end

return { setup = setup }

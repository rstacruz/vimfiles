local function setup_lspconfig()
  local has_lspconfig, lspconfig = pcall(require, "lspconfig")
  if not has_lspconfig then
    return
  end

  lspconfig.sumneko_lua.setup({})
end

return { setup_lspconfig = setup_lspconfig }

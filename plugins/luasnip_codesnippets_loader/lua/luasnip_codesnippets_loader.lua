local M = {}

-- loads via cwd
M.load = function()
  local matches = vim.split(vim.fn.glob(vim.fn.getcwd() .. "/.vscode/*.code-snippets"), "\n", { trimempty = true })
  for _, filepath in ipairs(matches) do
    require("luasnip.loaders.from_vscode").load_standalone({ path = filepath })
    vim.notify("Loaded snippets from " .. filepath)
  end
  return {}
end

M.setup = function()
  vim.api.nvim_create_autocmd("DirChanged", {
    group = vim.api.nvim_create_augroup("luasnip_codesnippets_loader", { clear = true }),
    pattern = "*",
    callback = function()
      M.load()
    end,
  })
  M.load()
end

return M

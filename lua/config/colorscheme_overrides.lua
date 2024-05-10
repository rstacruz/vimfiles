local M = {}

M.setup = function()
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("monet_overrides", { clear = true }),
    pattern = { "monet" },
    callback = function()
      -- markdown bold
      vim.cmd([[hi! link @markup.strong Title]])
      vim.cmd([[hi! link @markup.italic.markdown_inline String]])
      vim.cmd([[hi! link @markup.raw.markdown_inline DiffText]])
    end,
  })
end

return M

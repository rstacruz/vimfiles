local M = {}

-- Toggles between virtual_lines and virtual_text
-- See: https://git.sr.ht/~whynothugo/lsp_lines.nvim
M.toggle = function()
  local new_value = not vim.diagnostic.config().virtual_lines
  vim.diagnostic.config({ virtual_lines = new_value, virtual_text = not new_value })
  return new_value
end

return M

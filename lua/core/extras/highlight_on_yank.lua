local M = {}

-- Flashes the current line when yanking text.
M.setup = function()
  local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
  vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function() vim.highlight.on_yank({ timeout = 60 }) end,
    group = highlight_group,
    pattern = '*',
  })
end

return M

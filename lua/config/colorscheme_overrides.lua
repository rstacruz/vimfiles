local M = {}

M.setup = function()
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("color_overrides_monet", { clear = true }),
    pattern = { "monet" },
    callback = function()
      -- markdown bold
      vim.cmd([[hi! link @markup.strong Title]])
      vim.cmd([[hi! link @markup.italic.markdown_inline String]])
      vim.cmd([[hi! link @markup.raw.markdown_inline DiffText]])
    end,
  })

  vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("color_overrides_github", { clear = true }),
    pattern = { "github*" },
    callback = function()
      -- markdown bold
      vim.defer_fn(function()
        vim.cmd([[hi! link @markup.strong @text.strong]])
        vim.cmd([[hi! link ObsidianRefText @text.uri]])
        vim.cmd([[hi! link @markup.italic.markdown_inline @text.emphasis]])
      end, 100)
    end,
  })

  vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("color_overrides_caret", { clear = true }),
    pattern = { "github*" },
    callback = function()
      -- markdown bold
      vim.defer_fn(function()
        vim.cmd([[hi! link @markup.strong @text.strong]])
        vim.cmd([[hi! link ObsidianRefText @text.uri]])
        vim.cmd([[hi! link @markup.italic.markdown_inline @text.emphasis]])
      end, 100)
    end,
  })
end

return M

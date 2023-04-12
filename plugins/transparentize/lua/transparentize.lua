local function transparentize()
  vim.api.nvim_set_hl(0, "LineNr", { bg = "none", ctermbg = "none" })
  vim.api.nvim_set_hl(0, "Normal", { bg = "none", ctermbg = "none" })
  vim.api.nvim_set_hl(0, "NormalNC", { bg = "none", ctermbg = "none" })
end

return { transparentize = transparentize }

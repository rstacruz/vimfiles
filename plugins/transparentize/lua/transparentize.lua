local function transparentize()
  vim.cmd([[
    hi! LineNr guibg=none ctermbg=none
    hi! Normal guibg=none ctermbg=none
    hi! NormalNC guibg=none ctermbg=none
    hi! SignColumn guibg=none ctermbg=none
    hi! VertSplit guibg=none ctermbg=none
  ]])
  -- We can use nvim_set_hl, but they will _override_ the whole highlight definition.
  -- Using :highlight! will _append_ the new definition to the existing one.
  --
  --   vim.api.nvim_set_hl(0, "Normal", { bg = "none", ctermbg = "none" })
  --
end

return { transparentize = transparentize }

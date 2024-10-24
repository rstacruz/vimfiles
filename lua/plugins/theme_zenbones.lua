vim.g.zenbones_lightness = "bright"

return {
  {
    "zenbones-theme/zenbones.nvim",
    lazy = true,
    dependencies = "rktjmp/lush.nvim",
    config = function() -- _, _opts
      vim.g.zenbones_lightness = "bright"
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("color_overrides_zenbones", { clear = true }),
        pattern = { "zenbones" },
        callback = function()
          -- no italic strings
          vim.cmd([[hi! Constant gui=none]])

          if vim.o.background == "light" then
            vim.cmd([[hi! Normal guibg=#ffffff]])
            vim.cmd([[hi! Constant gui=none guifg=#5566cc]])
            vim.cmd([[hi! Number gui=none guifg=#5566cc]])
            -- vim.cmd([[hi! @variable.typescript guifg=#5566cc]])
          end
        end,
      })
    end,
  },
}

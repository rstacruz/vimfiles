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
        pattern = {
          "duckbones",
          "forestbones",
          "kanagawabones",
          "neobones",
          "nordbones",
          "rosebones",
          "seoulbones",
          "tokyobones",
          "vimbones",
          "zenbones",
          "zenwritten",
        },
        callback = function(ev)
          local name = ev.match

          -- no italic strings
          vim.cmd([[hi! Constant gui=none]])

          if vim.o.background == "light" then
            vim.cmd([[hi! Constant gui=none guifg=#58938e]])
            vim.cmd([[hi! Number gui=none guifg=#58938e]])
            -- vim.cmd([[hi! @variable.typescript guifg=#5566cc]])
          end

          if vim.o.background == "light" and name == "nordbones" then
            vim.cmd([[hi! Normal guibg=#fcfcfc]])
          end
        end,
      })
    end,
  },
}

return {
  { -- lualine: simplify lualine
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.sections.lualine_a = {} -- vim mode
      opts.sections.lualine_b = {} -- branch
      opts.sections.lualine_z = {} -- time
      return opts
    end,
  },
}

return {
  { -- lualine: simplify lualine
    "nvim-lualine/lualine.nvim",
    vscode = false,
    opts = function(_, opts)
      opts.options.component_separators = { left = " ", right = " " }
      opts.options.section_separators = { left = "▌", right = "▐" }
      opts.sections.lualine_a = {} -- vim mode
      opts.sections.lualine_b = {} -- branch
      opts.sections.lualine_z = {} -- time
      opts.sections.lualine_x = {
        opts.sections.lualine_x[1], -- noice cmd
        opts.sections.lualine_x[2], -- noice status
        opts.sections.lualine_x[3], -- dap
        opts.sections.lualine_x[4],
        opts.sections.lualine_x[5], -- diff
      }
      return opts
    end,
  },
}

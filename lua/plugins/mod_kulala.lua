return {
  {
    "mistweaverco/kulala.nvim",
    ft = "http",
    optional = true,
    opts = function(_, opts)
      -- "b" (buffer, default) "g" (global)
      opts.environment_scope = "g"
      return opts
    end,
    keys = {
      {
        "<leader>Re",
        "<cmd>lua require('kulala').set_selected_env()<cr>",
        desc = "Set environment",
        ft = "http",
      },
    },
  },
}

-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/util/rest.lua#L8

return {
  {
    "folke/edgy.nvim",
    opts = function(_, opts)
      opts.right = { size = 90 }
      -- https://github.com/folke/edgy.nvim
      -- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/ui/edgy.lua
      opts.animate = { enabled = false }
    end,
  },
}

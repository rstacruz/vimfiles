return {
  {
    "echasnovski/mini.animate",
    optional = true,
    opts = function(_, opts)
      opts.cursor = { enable = false }
      return opts
    end,
  },
}

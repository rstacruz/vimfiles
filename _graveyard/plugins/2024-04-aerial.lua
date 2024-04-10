-- not really needed after mini.diff
return {
  { -- aerial
    "stevearc/aerial.nvim",
    opts = function(_, opts)
      opts.layout.min_width = 50
      -- opts.layout.default_direction = "prefer_left"

      opts.filter_kind = {
        "Class",
        "Constructor",
        "Enum",
        "Function",
        "Interface",
        "Module",
        "Method",
        "Struct",
      }
    end,
  },
}

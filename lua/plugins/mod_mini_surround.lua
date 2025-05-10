return {
  {
    "echasnovski/mini.surround",
    optional = true,
    opts = function(_, opts)
      opts.custom_surroundings = {
        -- Markdown strong
        ["s"] = { output = { left = "**", right = "**" } },
        -- Markdown emphasis
        ["e"] = { output = { left = "_", right = "_" } },
      }
      return opts
    end,
  },
}

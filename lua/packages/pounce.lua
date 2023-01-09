return {
  "rlane/pounce.nvim",
  enabled = BaseConfig.features.pounce,
  event = "VeryLazy",
  config = function()
    require("pounce").setup({})
  end,
}

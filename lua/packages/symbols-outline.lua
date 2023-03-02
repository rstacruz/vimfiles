return {
  "simrat39/symbols-outline.nvim",
  event = "VeryLazy",
  config = function()
    require("symbols-outline").setup({
      position = "right",
    })
  end,
  keys = {
    { "<leader>co", "<cmd>SymbolsOutline<cr>", desc = "Show symbols" },
  },
}

return {
  { -- pretty fold
    "anuvyklack/pretty-fold.nvim",
    lazy = true,
    event = "VeryLazy",
    opts = {
      fill_char = " ",
    },
    config = function(_, opts)
      require("pretty-fold").setup(opts)
    end,
  },

  { -- fugitive: Git blame and open in GitHub
    "tpope/vim-fugitive",
    lazy = true,
    event = "VeryLazy",
    dependencies = {
      "tpope/vim-rhubarb",
    },
    keys = {
      { "<leader>giy", "<cmd>GBrowse!<cr>", desc = "Copy GitHub URL", mode = { "n", "v" } },
      { "<leader>giY", "<cmd>GBrowse<cr>", desc = "Open GitHub URL in browser", mode = { "n", "v" } },
      { "<leader>gb", "<cmd>Git blame<cr>", desc = "Git Blame" },
    },
  },

  { -- symbols outline
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    config = true,
  },
}

return {
  { -- ufo: better folds
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    lazy = true,
    event = { "BufReadPost", "BufNew" },
    opts = {},
    keys = {
      { "zR", "<cmd>lua require('ufo').openAllFolds()<cr>", desc = "Open all folds" },
      { "zM", "<cmd>lua require('ufo').closeAllFolds()<cr>", desc = "Close all folds" },
      -- also see: https://github.com/LazyVim/LazyVim/discussions/1881#discussioncomment-7395199
    },
  },

  -- { -- Origami
  --   -- `^ h` to fold (h at first non-blank char)
  --   -- `l` to unfold
  --   "chrisgrieser/nvim-origami",
  --   lazy = true,
  --   event = "BufReadPost",
  --   opts = true,
  -- },

  -- { -- pretty fold
  --   "anuvyklack/pretty-fold.nvim",
  --   lazy = true,
  --   event = { "BufReadPost" },
  --   enabled = not is_vscode,
  --   opts = {
  --     fill_char = " ",
  --   },
  --   config = function(_, opts)
  --     require("pretty-fold").setup(opts)
  --   end,
  -- },
}

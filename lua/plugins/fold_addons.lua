return {
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

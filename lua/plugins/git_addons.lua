return {
  { -- git-conflict
    "akinsho/git-conflict.nvim",
    lazy = true,
    event = "BufReadPost",
    opts = {},
    keys = {
      { "<leader>gxl", "<cmd>GitConflictListQf<cr>", desc = "List git conflicts" },
    },
  },

  { -- git linker
    "ruifm/gitlinker.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    lazy = true,
    opts = {},
    keys = {
      { "<leader>gy", desc = "Copy GitHub URL", mode = { "n", "v" } },
    },
  },

  { -- blame
    "FabijanZulj/blame.nvim",
    lazy = true,
    cmd = { "BlameToggle" },
    opts = {},
    keys = {
      { "<leader>gb", "<cmd>BlameToggle<cr>", desc = "Blame" },
    },
  },
}

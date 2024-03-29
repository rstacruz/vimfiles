return {
  { -- git-conflict
    "akinsho/git-conflict.nvim",
    lazy = true,
    event = "BufReadPost",
    opts = {},
    keys = {
      { "<leader>gxl", "<cmd>GitConflictListQf<cr>", "List git conflicts" },
      { "<leader>gx<", "<cmd>GitConflictChooseOurs<cr>", "Choose ours" },
      { "<leader>gx>", "<cmd>GitConflictChooseTheirs<cr>", "Choose theirs" },
      { "<leader>gx=", "<cmd>GitConflictChooseTheirs<cr>", "Choose both" },
      { "<leader>gx-", "<cmd>GitConflictChooseTheirs<cr>", "Choose none" },
      { "]C", "<cmd>GitConflictNextConflict<cr>", "Next Git conflict" },
      { "[C", "<cmd>GitConflictPrevConflict<cr>", "Prev Git conflict" },
    },
  },

  { -- gitsigns (override)
    "lewis6991/gitsigns.nvim",
    keys = {
      { "<leader>ug", "<cmd>Gitsigns toggle_signs<cr>", desc = "Toggle git signs" },
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
    cmd = { "ToggleBlame", "EnableBlame", "DisableBlame" },
    keys = {
      { "<leader>gb", "<cmd>ToggleBlame<cr>", "Blame" },
    },
  },
}

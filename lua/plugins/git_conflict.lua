return {
  {
    "akinsho/git-conflict.nvim",
    vscode = false,
    lazy = true,
    event = "LazyFile",
    opts = {},
    keys = {
      { "<leader>gxl", "<cmd>GitConflictListQf<cr>", desc = "List git conflicts" },
    },
  },
}

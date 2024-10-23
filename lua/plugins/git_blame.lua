return {
  { -- blame
    "FabijanZulj/blame.nvim",
    vscode = false,
    lazy = true,
    cmd = { "BlameToggle" },
    opts = {},
    keys = {
      { "<leader>gb", "<cmd>BlameToggle<cr>", desc = "Blame" },
    },
  },
}

return {
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

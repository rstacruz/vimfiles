return {
  {
    "sindrets/diffview.nvim",
    vscode = false,
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
      { "<leader>gD", "<cmd>DiffviewOpen<cr>", desc = "Diffview Open" },
    },
  },
}

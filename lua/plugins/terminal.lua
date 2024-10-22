return {
  { -- terminal
    "akinsho/toggleterm.nvim",
    lazy = true,
    vscode = false,
    cmd = { "ToggleTerm" },
    opts = {
      size = 20,
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)
    end,
    keys = {
      { "<leader>!.", "<cmd>ToggleTerm<cr>", desc = "Terminal (below)" },
      { "<leader>.", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Terminal (right)" },
      { "<leader>gf", '<cmd>w | TermExec size=6 cmd="git-fastsync && exit"<cr>', desc = "Git fastsync" },
    },
  },
}

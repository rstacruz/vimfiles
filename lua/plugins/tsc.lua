return {
  {
    "dmmulroy/tsc.nvim",
    lazy = true,
    cmd = { "TSC", "TSCOpen", "TSCClose", "TSCStop" },
    opts = {},
    keys = {},
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        vtsls = {
          keys = {
            {
              "<leader>ct",
              "<cmd>TSC<CR>",
              desc = "Run TSC",
            },
          },
        },
      },
    },
  },
}

return {
  {
    "chrisgrieser/nvim-lsp-endhints",
    vscode = false,
    event = "LspAttach",
    opts = {
      icons = {
        type = "→ ",
        parameter = "",
      },
    },
    keys = {
      {
        "<leader>uH",
        function()
          require("lsp-endhints").toggle()
        end,
        desc = "Toggle hint location",
      },
    },
  },
}

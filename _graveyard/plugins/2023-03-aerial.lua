return {
  { -- aerial: symbols
    "stevearc/aerial.nvim",
    lazy = true,
    opts = {
      -- see :help SymbolKind
      filter_kind = false,
      -- filter_kind = {
      --   "Class", "Constructor", "Enum", "Function", "Interface", "Module", "Method", "Struct",
      -- },
    },
    keys = {
      { "<leader>cs", "<cmd>AerialToggle!<cr>", desc = "Browse symbol outline" },
      { "<leader>!o", "<cmd>Telescope aerial<cr>", desc = "Go to symbol outline (aerial)" }, -- like leader-ss but supports more non-lsp filetypes
    },
    config = function(_, opts)
      opts.on_attach = function(bufnr)
        -- Jump forwards/backwards with '{' and '}'
        vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr, desc = "Prev symbol" })
        vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr, desc = "Next symbol" })
      end
      require("aerial").setup(opts)
      require("telescope").load_extension("aerial")
    end,
  },
}

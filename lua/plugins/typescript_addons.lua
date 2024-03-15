return {

  { -- ts error translator
    -- attaches itself to tsserver
    -- `[d` and `]d` to go to error diagnostics
    "dmmulroy/ts-error-translator.nvim",
    lazy = true,
    ft = { "typescript", "typescriptreact" },
    opts = {},
  },

  { -- project-wide typescript type checking
    -- :TSC or leader-ct to run checks
    "dmmulroy/tsc.nvim",
    lazy = true,
    ft = { "typescript", "typescriptreact" },
    cmd = { "TSC" },
    opts = {},
    config = function(_, opts)
      require("tsc").setup(opts)

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("atsc_keybindings", { clear = true }),
        pattern = { "typescript", "typescriptreact" },
        callback = function(event)
          vim.keymap.set(
            "n",
            "<leader>ct",
            "<cmd>TSC<CR>",
            { buffer = event.buf, desc = "Check TypeScript types (TSC)" }
          )
        end,
      })
    end,
  },
}

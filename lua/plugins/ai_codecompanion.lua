if vim.g.disable_ai_plugins == 1 then
  return {}
end

return {
  -- https://github.com/LazyVim/LazyVim/pull/4268/files
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    cmd = { "CodeCompanion", "CodeCompanionActions", "CodeCompanionChat", "CodeCompanionCmd" },

    keys = {
      { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
      { "<leader>!", "", desc = "+experimental", mode = { "n", "v" } },
      { "<leader>!c", "", desc = "+codecompanion", mode = { "n", "v" } },
      { "<leader>!cp", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "Prompt Actions (CodeCompanion)" },
      { "<leader>!cc", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "Open Chat (CodeCompanion)" },
      { "<leader>!ca", "<cmd>CodeCompanionChat Add<cr>", mode = { "v" }, desc = "Add to chat (CodeCompanion)" },
      { "<leader>!ci", "<cmd>CodeCompanion<cr>", mode = { "n", "v" }, desc = "Inline prompt (CodeCompanion)" },
    },

    opts = {
      -- https://codecompanion.olimorris.dev/configuration/inline-assistant.html#keymaps
      strategies = {
        inline = {
          keymaps = {
            accept_change = {
              modes = { n = "ga" },
              description = "Accept the suggested change",
            },
            reject_change = {
              modes = { n = "gr" },
              description = "Reject the suggested change",
            },
          },
        },
      },
    },
  },

  -- Edgy integration
  {
    "folke/edgy.nvim",
    optional = true,
    opts = function(_, opts)
      opts.right = opts.right or {}
      table.insert(opts.right, {
        ft = "codecompanion",
        title = "CodeCompanion Chat",
        size = { width = 50 },
      })
    end,
  },
}

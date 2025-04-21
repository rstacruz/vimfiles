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
      "j-hui/fidget.nvim",
    },
    cmd = { "CodeCompanion", "CodeCompanionActions", "CodeCompanionChat", "CodeCompanionCmd" },

    keys = {
      { "<leader>C", "", desc = "+codecompanion", mode = { "n", "v" } },
      { "<leader>Cp", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "Prompt Actions (CodeCompanion)" },
      { "<leader>Cc", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "Open Chat (CodeCompanion)" },
      { "<leader>Ci", "<cmd>CodeCompanion<cr>", mode = { "n", "v" }, desc = "Inline prompt (CodeCompanion)" },
    },

    opts = function(_, opts)
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
        display = {
          -- https://codecompanion.olimorris.dev/configuration/chat-buffer
          chat = {
            intro_message = "Press ? for options",
            window = {
              opts = { number = false },
            },
          },
        },
        prompt_library = {
          ["AIcomments"] = {
            strategy = "inline",
            description = "Address AI comments",
            prompts = {
              {
                role = "user",
                content = [[
#buffer Are there comments marked AI! or AI?? Perform actions for AI!, answer AI? questions, then delete these comments.
]],
              },
            },
          },
          -- ["plan"] = {
          --   strategy = "chat",
          --   description = "Plan something",
          --   opts = {
          --     is_slash_cmd = true,
          --     short_name = "plan",
          --   },
          --   prompts = {
          --     {
          --       role = "user",
          --       content = [[...]]
          --     },
          --   },
          -- },
        },
      }
      if vim.env.OPENROUTER_API_KEY then
        local openrouter_env = {
          url = "https://openrouter.ai/api",
          api_key = "OPENROUTER_API_KEY",
          chat_url = "/v1/chat/completions",
        }
        opts.adapters = {}
        opts.adapters.copilot = function()
          return require("codecompanion.adapters").extend("copilot", {
            schema = {
              -- https://github.com/olimorris/codecompanion.nvim/issues/796
              model = { default = "claude-3.5-sonnet" },
              max_tokens = { default = 65536 },
            },
          })
        end
        opts.adapters.openrouter_deepseek_v3 = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            env = openrouter_env,
            schema = { model = { default = "deepseek/deepseek-chat-v3-0324" } },
          })
        end
        opts.adapters.openrouter_gemini_flash = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            env = openrouter_env,
            schema = { model = { default = "google/gemini-2.0-flash-001" } },
          })
        end
        opts.strategies.chat = { adapter = "openrouter_deepseek_v3" }
        opts.strategies.inline = { adapter = "openrouter_gemini_flash" }
        opts.strategies.cmd = { adapter = "openrouter_deepseek_v3" }
      end

      return opts
    end,

    config = function(_, opts)
      require("codecompanion").setup(opts)
    end,
  },

  -- Edgy integration
  {
    "folke/edgy.nvim",
    optional = true,
    opts = function(_, opts)
      opts.right = opts.right or {}
      table.insert(opts.right, {
        ft = "codecompanion",
        title = "CodeCompanion chat",
        size = { width = 80 },
      })
    end,
  },
}

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
      { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
      { "<leader>!", "", desc = "+experimental", mode = { "n", "v" } },
      { "<leader>!c", "", desc = "+codecompanion", mode = { "n", "v" } },
      { "<leader>!cp", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "Prompt Actions (CodeCompanion)" },
      { "<leader>!cc", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "Open Chat (CodeCompanion)" },
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
        ["plan"] = {
          strategy = "chat",
          description = "Plan something",
          opts = {
            is_slash_cmd = true,
            short_name = "plan",
          },
          prompts = {
            {
              role = "user",
              content = [[
<guidelines>

Follow the steps below.

- **Step 1: Gather info**
  - If files or answers aren't needed, skip to step 2
  - Request needed files
  - Ask questions if needed
  - Skip this step if user input not needed
  - No code changes yet
- **Step 2: Write plan**
  - Create structured plan with:
    - Background (bullet points)
    - Requirements
    - Actions (files/functions to change. Use numbered, logical steps.)
    - Out of scope
  - Keep it brief, use `## headings`, sentence fragments. Wait for user to confirm before moving to next step.
- **Step 3: Execute plan** - Start coding after plan approval.

</guidelines>

Follow the `<guidelines>` for this next request. The request follows below.

]],
            },
          },
        },
      },
    },

    config = function(_, opts)
      opts.adapters = {
        copilot = function()
          return require("codecompanion.adapters").extend("copilot", {
            schema = {
              -- https://github.com/olimorris/codecompanion.nvim/issues/796
              model = { default = "claude-3.5-sonnet" },
              max_tokens = { default = 65536 },
            },
          })
        end,
        -- anthropic = function()
        --   return require("codecompanion.adapters").extend("anthropic", {
        --     env = { api_key = "MY_OTHER_ANTHROPIC_KEY" },
        --   })
        -- end,
      }

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

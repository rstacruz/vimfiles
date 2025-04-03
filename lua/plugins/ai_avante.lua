-- Check if running on Termux (Android) to disable avante.nvim if needed
-- avante requires building native modules, which is not supported on android-aarch64
-- as of Feb 2025
local is_termux = string.find(vim.loop.os_uname().release, "android")

-- Configuration for avante.nvim plugin
-- References:
-- https://github.com/LazyVim/LazyVim/pull/4440
-- https://github.com/yetone/avante.nvim/blob/main/lua/avante/config.lua
return {
  -- Main avante.nvim plugin configuration
  {
    "yetone/avante.nvim",
    vscode = false,
    enabled = not is_termux,
    init = function()
      require("avante_lib").load()
    end,
    event = "VeryLazy",
    opts = function(_, opts)
      opts = {
        provider = "copilot",
        hints = { enabled = false },
        mappings = {
          ask = "<leader>Aa",
          edit = "<leader>Ae",
          refresh = "<leader>Ar",
          focus = "<leader>Af",
          toggle = {
            default = "<leader>At",
            debug = "<leader>Ad",
            hint = "<leader>Ah",
            suggestion = "<leader>As",
            repomap = "<leader>AR",
          },
          files = {
            add_current = "<leader>Ac",
            add_all_buffers = "<leader>AB",
          },
          select_model = "<leader>A?",
          select_history = "<leader>Ah",
        },
        windows = {
          width = 40, -- default 30%
        },
      }

      -- Override provider and settings if OPENROUTER_API_KEY is set
      if vim.env.OPENROUTER_API_KEY then
        opts.provider = "openrouter_gemini" -- Switch to OpenRouter provider

        -- Configure OpenRouter vendors
        opts.vendors = {
          openrouter = {
            __inherited_from = "openai",
            endpoint = "https://openrouter.ai/api/v1",
            api_key_name = "OPENROUTER_API_KEY",
            model = "deepseek/deepseek-chat-v3-0324",
          },
          openrouter_gemini = {
            __inherited_from = "openai",
            endpoint = "https://openrouter.ai/api/v1",
            api_key_name = "OPENROUTER_API_KEY",
            model = "google/gemini-2.0-flash-001",
          },
        }

        opts.cursor_applying_proivder = "openrouter_gemini"
        opts.behaviour = {
          enable_cursor_applying_mode = true,
        }
      end

      -- if vim.env.OPENAI_API_KEY then
      --   opts.rag_service = {
      --     enabled = true,
      --   }
      -- end

      return opts
    end,
    build = LazyVim.is_win() and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" or "make",
    config = function(_, opts)
      vim.fn.setenv("LANG", "en_US.UTF-8")
      require("avante").setup(opts)
    end,
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    optional = true,
    ft = function(_, ft)
      vim.list_extend(ft, { "Avante" })
    end,
  },

  {
    "saghen/blink.cmp",
    lazy = true,
    dependencies = { "saghen/blink.compat" },
    opts = {
      sources = {
        default = { "avante_commands", "avante_mentions", "avante_files" },
        compat = {
          "avante_commands",
          "avante_mentions",
          "avante_files",
        },
        -- LSP score_offset is typically 60
        providers = {
          avante_commands = {
            name = "avante_commands",
            module = "blink.compat.source",
            score_offset = 90,
            opts = {},
          },
          avante_files = {
            name = "avante_files",
            module = "blink.compat.source",
            score_offset = 100,
            opts = {},
          },
          avante_mentions = {
            name = "avante_mentions",
            module = "blink.compat.source",
            score_offset = 1000,
            opts = {},
          },
        },
      },
    },
  },

  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>!A", group = "+ai-avante" }, -- Add avante-specific keybindings
      },
    },
  },
}

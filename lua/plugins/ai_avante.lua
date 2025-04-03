-- avante requires building native modules. not supported on android-aarch64
-- afaik (as of Feb 2025)
local is_termux = string.find(vim.loop.os_uname().release, "android")

-- https://github.com/LazyVim/LazyVim/pull/4440
-- https://github.com/yetone/avante.nvim/blob/main/lua/avante/config.lua
return {
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
        },
      }
      if vim.env.OPENROUTER_API_KEY then
        opts.provider = "openrouter"

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
          -- https://github.com/yetone/avante.nvim/blob/main/cursor-planning-mode.md
          enable_cursor_applying_mode = true,
        }
      end
      if vim.env.OPENAI_API_KEY then
        opts.rag_service = {
          enabled = true,
        }
      end
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
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>!A", group = "+ai-avante" },
      },
    },
  },
}

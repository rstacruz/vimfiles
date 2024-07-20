return {
  { -- headlines
    -- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/lang/markdown.lua#L65
    "lukas-reineke/headlines.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    enabled = false,
    lazy = true,
    event = {
      "BufReadPre **.md",
      "BufNewFile **.md",
    },
    ft = { "markdown", "norg", "rmd", "org" },
    opts = function()
      local filetype_opts = {
        -- Termux doesn't display the characters well
        fat_headlines = false, -- not is_android,

        -- disable bullets for now. See https://github.com/lukas-reineke/headlines.nvim/issues/66
        bullets = {},

        headline_highlights = {
          "DiffAdd",
          "Headline",
        },

        -- headline_highlights = {
        --   "DiffDelete",
        --   "DiffAdd",
        --   "Headline",
        -- },
        -- codeblock_highlight = "DiffChange",
        -- Differentiates it a bit from code block
        -- headline_highlights = {
        --   "DiagnosticVirtualTextError",
        --   "DiagnosticVirtualTextInfo",
        --   "DiagnosticVirtualTextWarn",
        --   "CursorLine",
        -- },

        dash_string = "─",
      }
      return {
        norg = {
          headline_highlights = false,
        },
        markdown = filetype_opts,
        rmd = filetype_opts,
      }
    end,
    config = function(_, opts)
      -- PERF: schedule to prevent headlines slowing down opening a file
      vim.schedule(function()
        require("headlines").setup(opts)
        require("headlines").refresh()
      end)
    end,
  },
}

return {
  {
    "MeanderingProgrammer/markdown.nvim",
    lazy = true,
    event = {
      "BufReadPre **.md",
      "BufNewFile **.md",
    },
    ft = { "markdown", "norg", "rmd", "org" },
    opts = function()
      return {
        bullet = {
          enabled = true,
          icons = { "─", "·", "·", "·" }, -- default: { '●', '○', '◆', '◇' },
          highlight = "DiagnosticInfo", -- 'RenderMarkdownBullet',
        },

        checkbox = {
          custom = {
            wait = { raw = "[-]", rendered = "󰥔", highlight = "RenderMarkdownTodo" },
            prio = { raw = "[!]", rendered = "󰄱", highlight = "DiagnosticError" }, -- high priority
            done = { raw = "[x]", rendered = "󰄲", highlight = "DiagnosticOk" }, -- nf-md-checkbox_marked
            yes = { raw = "[y]", rendered = "󰄲", highlight = "DiagnosticOk" }, -- nf-md-checkbox_marked
            later = { raw = "[>]", rendered = "󰒊", highlight = "DiagnosticInfo" }, -- nf-md-send
            sched = { raw = "[<]", rendered = "󰃰", highlight = "DiagnosticInfo" }, -- nf-md-calendar_clock
            cancl = { raw = "[~]", rendered = "󰂭", highlight = "Comment" },
            info = { raw = "[i]", rendered = "󰋼", highlight = "DiagnosticInfo" }, -- nf-md-information
            idea = { raw = "[I]", rendered = "󰌵", highlight = "DiagnosticWarn" }, -- nf-md-lightbulb
            pro = { raw = "[p]", rendered = "󰔓", highlight = "DiagnosticOk" }, -- nf-md-thumb_up
            con = { raw = "[c]", rendered = "󰔑", highlight = "DiagnosticError" }, -- nf-md-thumb_down
            star = { raw = "[s]", rendered = "󰓎", highlight = "DiagnosticWarn" }, -- nf-md-star (asterisk * doesn't work)
            star2 = { raw = "[*]", rendered = "󰓎", highlight = "DiagnosticWarn" }, -- nf-md-star (asterisk * doesn't work)
            half = { raw = "[/]", rendered = "󰿦", highlight = "DiagnosticWarn" }, -- in progress, nf-md-texture_box
          },
        },

        callout = {
          -- RenderMarkdownHint, _Question - yellow
          -- RenderMarkdownSuccess - green
          -- RenderMarkdownInfo - blue
          -- RenderMarkdownError - red
          highlights = { raw = "[!HIGHLIGHTS]", rendered = "󰌶 Highlights", highlight = "RenderMarkdownHint" },
          tldr = { raw = "[!TLDR]", rendered = "󰌶 TLDR", highlight = "RenderMarkdownHint" },
          summary = { raw = "[!SUMMARY]", rendered = "󰌶 Summary", highlight = "RenderMarkdownHint" },
        },
      }
    end,
    config = function(_, opts)
      require("render-markdown").setup(opts)
    end,
  },
}

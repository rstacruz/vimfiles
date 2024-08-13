local is_termux = string.find(vim.loop.os_uname().release, "android")

return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    lazy = true,
    event = {
      "BufReadPre **.md",
      "BufNewFile **.md",
    },
    ft = { "markdown", "norg", "rmd", "org" },
    opts = function()
      return {
        render_modes = { "n", "v", "i", "c" },
        heading = {
          -- default:
          -- signs = { "󰫎 " },
          -- icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
          icons = { "━ " },
          signs = { "󰎤 ", "󰎩 ", "󰎬 ", "󰎮 ", "󰎰 ", "󰎵 " },

          -- signs = { "󰎦 ", "󰎩 ", "󰎬 ", "󰎮 ", "󰎰 ", "󰎵 " }, -- nf-md-numeric_0_box_outline
          -- signs = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " }, -- nf-md-numeric_0_box
          -- icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " }, -- nf-md-numeric_0_box
          -- signs = { "Ⅰ", "Ⅱ", "Ⅲ", "Ⅳ", "󰲩", "󰲫" },
          -- signs = { "∙", "∶", "∴", "∷", "󰲩", "󰲫" },
          -- signs = { "━ " },
          -- sign = false,
        },

        code = {
          sign = false,
          width = "block",
          position = "right",
          right_pad = 15,
          left_pad = 2,
        },

        bullet = {
          enabled = true,
          icons = { "─", "·", "·", "·" }, -- default: { '●', '○', '◆', '◇' },
          highlight = "DiagnosticInfo", -- 'RenderMarkdownBullet',
        },

        checkbox = {
          custom = {
            wait = { raw = "[-]", rendered = "󰥔 ", highlight = "RenderMarkdownTodo" },
            prio = { raw = "[!]", rendered = "󰄱 ", highlight = "DiagnosticError" }, -- high priority
            done = { raw = "[x]", rendered = "󰄲 ", highlight = "DiagnosticOk" }, -- nf-md-checkbox_marked
            yes = { raw = "[y]", rendered = "󰄲 ", highlight = "DiagnosticOk" }, -- nf-md-checkbox_marked
            later = { raw = "[>]", rendered = "󰒊 ", highlight = "DiagnosticInfo" }, -- nf-md-send
            sched = { raw = "[<]", rendered = "󰃰 ", highlight = "DiagnosticInfo" }, -- nf-md-calendar_clock
            cancel = { raw = "[~]", rendered = "󰂭 ", highlight = "Comment" },
            info = { raw = "[i]", rendered = "󰋼 ", highlight = "DiagnosticInfo" }, -- nf-md-information
            idea = { raw = "[I]", rendered = "󰌵 ", highlight = "DiagnosticWarn" }, -- nf-md-lightbulb
            pro = { raw = "[p]", rendered = "󰔓 ", highlight = "DiagnosticOk" }, -- nf-md-thumb_up
            con = { raw = "[c]", rendered = "󰔑 ", highlight = "DiagnosticError" }, -- nf-md-thumb_down
            star = { raw = "[s]", rendered = "󰓎 ", highlight = "DiagnosticWarn" }, -- nf-md-star (asterisk * doesn't work)
            star2 = { raw = "[*]", rendered = "󰓎 ", highlight = "DiagnosticWarn" }, -- nf-md-star (asterisk * doesn't work)
            half = { raw = "[/]", rendered = "󰿦 ", highlight = "DiagnosticWarn" }, -- in progress, nf-md-texture_box
          },
        },

        callout = {
          -- RenderMarkdownHint, _Question - yellow
          -- RenderMarkdownSuccess - green
          -- RenderMarkdownInfo - blue
          -- RenderMarkdownError - red
          highlights = { raw = "[!HIGHLIGHTS]", rendered = "󰌶 Highlights ", highlight = "RenderMarkdownHint" },
          tldr = { raw = "[!TLDR]", rendered = "󰌶 TLDR ", highlight = "RenderMarkdownHint" },
          summary = { raw = "[!SUMMARY]", rendered = "󰌶 Summary ", highlight = "RenderMarkdownHint" },
        },
      }
    end,
    config = function(_, opts)
      require("render-markdown").setup(opts)
    end,
  },

  {
    "iamcco/markdown-preview.nvim",
    enabled = not is_termux,
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    config = function(_, opts)
      -- require("markdown-preview").setup(opts)

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("markdown_preview_keybindings", { clear = true }),
        pattern = { "markdown" },
        callback = function(event)
          -- event = { buf, event, file, group, id, match }
          vim.keymap.set(
            "n",
            "<leader>mv",
            "<cmd>MarkdownPreviewToggle<CR>",
            { buffer = event.buf, desc = "Open Markdown preview in browser" }
          )
        end,
      })
    end,
  },
}

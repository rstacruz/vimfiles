local is_termux = string.find(vim.loop.os_uname().release, "android")

return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    vscode = false,
    lazy = true,
    event = {
      "BufReadPre **.md",
      "BufNewFile **.md",
    },
    ft = { "markdown", "norg", "rmd", "org", "codecompanion" },
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
          style = "normal",
          width = "block",
          position = "right",
          right_pad = 5,
          -- left_pad = 2, -- messes up indent guides
          border = "thick",
        },

        bullet = {
          enabled = true,
          icons = { "─", "─", "─", "─" }, -- default: { '●', '○', '◆', '◇' },
          highlight = "DiagnosticInfo", -- 'RenderMarkdownBullet',
        },

        checkbox = {
          -- "󰄲" -- nf-md-checkbox_marked
          -- "󰄳" -- nf-md-checkbox_marked_circle
          -- "󰄰" -- nf-md-checkbox_blank_circle_outline
          -- "󰸞" -- nf-md-check-bold
          -- "󰏤" -- nf-md-pause
          -- "󰜺" -- nf-md-cancel
          -- "󰄬" -- nf-md-check
          unchecked = { icon = "□" },
          checked = { icon = "󰸞", highlight = "DiagnosticOk" }, -- nf-md-check-bold
          custom = {
            -- Comment = grey
            -- RenderMarkdownTodo = cyan?
            -- DiagnosticOk = green
            -- DiagnosticError = red
            -- DiagnosticInfo = cyan
            -- DiagnosticWarn = yellow
            wait = { raw = "[-]", rendered = "󰥔", highlight = "RenderMarkdownTodo" },
            prio = { raw = "[!]", rendered = "󰄰", highlight = "DiagnosticError" }, -- high priority
            done = { raw = "[x]", rendered = "󰸞", highlight = "DiagnosticOk" },
            prog1 = { raw = "[1]", rendered = "󰂎", highlight = "DiagnosticInfo" },
            prog2 = { raw = "[2]", rendered = "󱊡", highlight = "DiagnosticInfo" },
            prog4 = { raw = "[4]", rendered = "󱊢", highlight = "DiagnosticInfo" },
            prog8 = { raw = "[8]", rendered = "󱊣", highlight = "DiagnosticInfo" },
            -- prog1 = { raw = "[1]", rendered = "󰂎", highlight = "DiagnosticInfo" },
            -- prog2 = { raw = "[2]", rendered = "󱊡", highlight = "DiagnosticInfo" },
            -- prog4 = { raw = "[4]", rendered = "󱊢", highlight = "DiagnosticInfo" },
            -- prog8 = { raw = "[8]", rendered = "󱊣", highlight = "DiagnosticInfo" },
            -- yes = { raw = "[y]", rendered = "󰄬", highlight = "DiagnosticOk" },
            fwd = { raw = "[>]", rendered = "󰒊", highlight = "Comment" }, -- nf-md-send
            sched = { raw = "[<]", rendered = "󰃰", highlight = "Comment" }, -- nf-md-calendar_clock
            cancel = { raw = "[~]", rendered = "󰏤", highlight = "DiagnosticWarn" },
            info = { raw = "[i]", rendered = "󰋼", highlight = "DiagnosticInfo" }, -- nf-md-information -- `i` in obsidian
            idea = { raw = "[l]", rendered = "󰌵", highlight = "DiagnosticWarn" }, -- nf-md-lightbulb -- `I` in obsidian
            pro = { raw = "[p]", rendered = "󰔓", highlight = "DiagnosticOk" }, -- nf-md-thumb_up
            con = { raw = "[c]", rendered = "󰔑", highlight = "DiagnosticError" }, -- nf-md-thumb_down
            star = { raw = "[s]", rendered = "󰓎", highlight = "DiagnosticWarn" }, -- nf-md-star (asterisk * doesn't work)
            star2 = { raw = "[*]", rendered = "󰓎", highlight = "DiagnosticWarn" }, -- nf-md-star (asterisk * doesn't work)
            bookmark = { raw = "[b]", rendered = "󰃀", highlight = "DiagnosticWarn" }, -- nf-md-star (asterisk * doesn't work)
            half = { raw = "[/]", rendered = "󰿦", highlight = "Comment" }, -- in progress, nf-md-texture_box
            delegated = { raw = "[d]", rendered = "👤", highlight = "Comment" }, -- in progress, nf-md-texture_box
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

        link = {
          -- Fallback icon for 'inline_link' elements
          -- hyperlink = "󰌹 ",
          hyperlink = "",

          -- image = "󰥶 ", -- Inlined with 'image' elements
          -- email = "󰀓 ", -- Inlined with 'email_autolink' elements
          -- hyperlink = "󰌹 ", -- Fallback icon for 'inline_link' elements
          -- wiki = { icon = "󱗖 ", highlight = "RenderMarkdownWikiLink" },
          wiki = { icon = "", highlight = "RenderMarkdownLink" },

          custom = {
            -- web = { pattern = "^http[s]?://", icon = "󰖟 ", highlight = "RenderMarkdownLink" },
            -- stylua: ignore start
            jira = { pattern = "^http[s]?://%a+.atlassian.net/browse", icon = "󰌃 ", highlight = "RenderMarkdownLink" },
            conf = { pattern = "^http[s]?://%a+.atlassian.net/wiki", icon = " ", highlight = "RenderMarkdownLink" }, -- nf-fa-confluence
            slack = { pattern = "^http[s]?://%a+.slack.com", icon = "󰒱 ", highlight = "RenderMarkdownLink" }, -- nf-md-slack
            github = { pattern = "^http[s]?://github.com", icon = "󰊤 ", highlight = "RenderMarkdownLink" }, -- nf-md-github + ctrl-k 1M
            gitlab = { pattern = "^http[s]?://gitlab.com", icon = " ", highlight = "RenderMarkdownLink" }, -- nf-fa-gitlab
            trello = { pattern = "^http[s]?://trello.com", icon = "󰔲 ", highlight = "RenderMarkdownLink" },
            miro = { pattern = "^http[s]?://miro.com", icon = "󰃥 ", highlight = "RenderMarkdownLink" },
            datadog = { pattern = "^http[s]?://app.datadoghq.com", icon = "󰩃 ", highlight = "RenderMarkdownLink" },
            googledrive = { pattern = "^http[s]?://drive.google.com", icon = "󰊶 ", highlight = "RenderMarkdownLink", },
            web = { pattern = "^http[s]?://", icon = "󰏌 ", highlight = "RenderMarkdownLink" }, -- nf-md-open_in_new + ctrl-k 1M
            -- stylua: ignore end
          },
        },
      }
    end,
    config = function(_, opts)
      require("render-markdown").setup(opts)
    end,
  },

  {
    "zk-org/zk-nvim",
    vscode = false,
    enabled = false,
    lazy = true,
    ft = { "markdown" },
    opts = {
      picker = "select",
    },
    config = function(_, opts)
      require("zk").setup(opts)
      LazyVim.lsp.on_attach(function(client, buffer)
        if client.name == "zk" then
          -- stylua: ignore start
          vim.keymap.set("n", "<leader>zr", "<cmd>ZkBacklinks<CR>", { buffer = buffer, desc = "Show backlinks (references)" })
          vim.keymap.set("n", "<leader>zl", "<cmd>ZkLinks<CR>", { buffer = buffer, desc = "Show outgoing links" })
          vim.keymap.set("n", "<leader>zL", "<cmd>ZkLinks {recursive=true}<CR>", { buffer = buffer, desc = "Show outgoing links (recursive)" })
          vim.keymap.set("n", "<leader>zn", "<Cmd>ZkNew { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>", { buffer = buffer, desc = "Create new page…" })

          -- Create a note in the same dir, using current selection for content
          vim.keymap.set("v", "<leader>zn", "<Cmd>ZkNewFromContentSelection { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>", { buffer = buffer, desc = "Create new page from selection…" })

          -- Create a note in the same dir, using current selection for title
          vim.keymap.set("v", "<leader>zt", "<Cmd>ZkNewFromTitleSelection { dir = vim.fn.expand('%:p:h') }<CR>", { buffer = buffer, desc = "Link to new file…" })
          -- stylua: ignore end
        end
      end)
    end,
  },
}

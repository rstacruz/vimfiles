local is_vscode = vim.g.vscode or vim.env.VSCODE

return {
  { -- Alpha (welcome page)
    -- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/ui.lua#L227-L239
    "goolord/alpha-nvim",
    enabled = not is_vscode,
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      dashboard.section.header.val = {
        "┌──┬──────────────────────────────────────────────┐",
        "├──┴──────────────────────────────────────────────┤",
        "│                                                 │",
        "│   Microsoft® Visual Studio Code™        ┌─┐     │",
        "│   Version 0.9, MS-DOS Edition          ⊙␣⊙│     │",
        "│                                         │ ││    │",
        "│   Copyright © 1991, Microsoft           │─┘│    │",
        "│   Corporation. All rights reserved.     └──┘    │",
        "│                                                 │",
        "└─────────────────────────────────────────────────┘",
      }
      dashboard.section.buttons.val = {
        dashboard.button("s", "󰑓 " .. " RESUME.EXE", [[:lua require("persistence").load() <cr>]]),
        dashboard.button("n", " " .. " NEWFILE.BAT", ":ene <BAR> startinsert <CR>"),
        dashboard.button("f", " " .. " FIND.EXE", ":Telescope find_files <CR>"),
        dashboard.button("r", " " .. " RECENTS.EXE", ":Telescope oldfiles only_cwd=true<CR>"),
        dashboard.button("m", " " .. " MARKS.COM", ":lua require('harpoon.ui').toggle_quick_menu()<CR>"),
        dashboard.button("q", " " .. " CTRLALT.DEL", ":qa<CR>"),
        -- dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
        -- dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
        -- dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
      }
      return dashboard
    end,
  },
}

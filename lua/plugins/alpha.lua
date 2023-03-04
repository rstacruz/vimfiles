-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/ui.lua#L227-L239
return {
  "goolord/alpha-nvim",
  opts = function()
    local dashboard = require("alpha.themes.dashboard")
    dashboard.section.header.val = { "Neovim" }
    dashboard.section.buttons.val = {
      dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
      dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
      -- dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
      -- dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
      -- dashboard.button("s", "󰑓 " .. " Restore Session", [[:lua require("persistence").load() <cr>]]),
      -- dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
      dashboard.button("q", " " .. " Quit", ":qa<CR>"),
    }
    dashboard.section.buttons.val = {}
    return dashboard
  end,
}

local is_vscode = vim.g.vscode or vim.env.VSCODE

return {
  { -- Alpha (welcome page)
    -- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/ui.lua#L227-L239
    "goolord/alpha-nvim",
    enabled = not is_vscode,
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      dashboard.section.header.val = { "" }
      dashboard.section.buttons.val = {
        dashboard.button("e", " " .. " new file", ":ene <BAR> startinsert <CR>"),
      }
      --   dashboard.button("s", "󰑓 " .. " RESUME.EXE", [[:lua require("persistence").load() <cr>]]),
      --   dashboard.button("e", " " .. " NEWFILE.BAT", ":ene <BAR> startinsert <CR>"),
      --   dashboard.button("f", " " .. " FIND.EXE", ":Telescope find_files <CR>"),
      --   dashboard.button("r", " " .. " RECENTS.EXE", ":Telescope oldfiles only_cwd=true<CR>"),
      --   dashboard.button("m", " " .. " MARKS.COM", ":lua require('harpoon.ui').toggle_quick_menu()<CR>"),
      --   dashboard.button("q", " " .. " CTRLALT.DEL", ":qa<CR>"),
      --   -- dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
      --   -- dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
      --   -- dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
      -- }
      return dashboard
    end,
    config = function(_, dashboard)
      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "AlphaReady",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      require("alpha").setup(dashboard.opts)

      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = "" .. ms .. "ms"
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },
}

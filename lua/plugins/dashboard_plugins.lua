local Util = require("lazyvim.util")
return {
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function()
      local hr = "─────────────────────────"
      local logo = "" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t") .. "\n" .. hr
      logo = string.rep("\n", 8) .. logo .. "\n\n"

      local oldfiles = Util.telescope("oldfiles", { only_cwd = true })
      local restore_session = 'lua require("persistence").load()'
      local explore = 'lua require("mini.files").open()'

      local opts = {
        theme = "doom",
        hide = {
          statusline = false,
        },
        config = {
          header = vim.split(logo, "\n"),
          -- stylua: ignore
          center = {
            { action = "ene | startinsert",     desc = " New file",        icon = " ", key = "e" },
            { action = Util.telescope('files'), desc = " Open file...",    icon = " ", key = "p" },
            { action = explore,                 desc = " Explore...",      icon = " ", key = "x" },
            { action = oldfiles,                desc = " Recent files...", icon = " ", key = "r" },
            { action = restore_session,         desc = " Restore session", icon = " ", key = "s" },
            { action = "qa",                    desc = " Quit",            icon = " ", key = "q" },
          },
          footer = function()
            local stats = require("lazy").stats()
            local ms = math.floor((stats.startuptime * 100 + 0.5) / 100)
            return { "", hr, "" .. stats.loaded .. "/" .. stats.count .. " plugins _ " .. ms .. "ms" }
          end,
        },
      }

      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(" ", 23 - #button.desc)
        button.key_format = " %s"
        button.key_hl = "SignColumn"
        button.icon_hl = "SignColumn"
      end

      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "DashboardLoaded",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      return opts
    end,
  },
}

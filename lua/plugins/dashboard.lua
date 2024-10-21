return {
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function(_, opts)
      local logo = [[::]]

      logo = string.rep("\n", 8) .. logo .. "\n\n"
      opts.config.header = vim.split(logo, "\n")
      opts.config.center = {
        {
          action = function()
            vim.api.nvim_input("<cmd>qa<cr>")
          end,
          desc = " Quit",
          icon = " ",
          key = "q",
        },
      }
      opts.config.footer = function()
        local stats = require("lazy").stats()
        local ms = math.floor((stats.startuptime * 100 + 0.5) / 100)
        return { "", " ", "" .. stats.loaded .. "/" .. stats.count .. " plugins _ " .. ms .. "ms" }
      end

      opts.theme = "doom"
    end,
  },
}

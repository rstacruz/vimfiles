return {
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    vscode = false,
    opts = function(_, opts)
      local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
      local logo = "" .. cwd .. "\n" -- .. string.rep("─", #cwd)
      logo = string.rep("\n", 8) .. logo .. "\n"

      opts.config.header = vim.split(logo, "\n")
      opts.config.center = {
        {
          action = function()
            LazyVim.pick("oldfiles")()
          end,
          desc = "open recent",
          icon = "",
          key = "r",
          key_format = "  %s",
        },
        {
          action = function()
            vim.api.nvim_input("<cmd>qa<cr>")
          end,
          desc = "quit",
          icon = "",
          key = "q",
          key_format = "  %s",
        },
      }
      opts.config.footer = function()
        local stats = require("lazy").stats()
        local ms = math.floor((stats.startuptime * 100 + 0.5) / 100)
        return { " ", "" .. stats.loaded .. "/" .. stats.count .. " plugins · " .. ms .. "ms" }
      end

      opts.theme = "doom"
    end,
  },
}

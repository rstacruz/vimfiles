return {
  {
    "snacks.nvim",
    opts = {
      styles = {
        float = {
          width = 0.999,
          height = 0.9,
        },
        lazygit = {
          width = 0.999,
          height = 0.999,
        },
      },
      dashboard = {
        width = 20, -- default: 60

        sections = {
          -- { section = "header" },
          -- `gap` - space-y
          -- `padding` - margin-bottom
          { section = "terminal", cmd = "sh -c 'basename $(pwd)'", padding = 1, height = 1 },
          { section = "keys", gap = 0, padding = 1 },
          { section = "startup" },
          -- { section = "terminal", cmd = "date", padding = 2, height = 1 },
        },
        preset = {
          -- header = [[]],

          -- stylua: ignore
          ---@type snacks.dashboard.Item[]
          keys = {
            { icon = " ", key = "f", desc = "file", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "S", desc = "git status", action = ":lua Snacks.picker.git_status()" },
            { icon = " ", key = "d", desc = "git diff", action = ":DiffviewOpen" },
            { icon = " ", key = "e", desc = "new", action = ":ene | startinsert" },
            { icon = " ", key = "r", desc = "recent", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = " ", key = "@", desc = "session", section = "session" },
            { icon = " ", key = "s", desc = "lazyvim", action = ":lua Snacks.lazygit({ cwd = LazyVim.root.git() })" },
            { icon = " ", key = "q", desc = "quit", action = ":qa" },

            -- { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            -- { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            -- { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            -- { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            -- { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            -- { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            -- { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
            -- { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            -- { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },
    },
  },
}

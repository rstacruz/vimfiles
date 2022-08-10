local function setup()
  local has, alpha = pcall(require, "alpha")
  if not has then
    return
  end

  -- https://github.com/goolord/alpha-nvim/blob/main/lua/alpha/themes/theta.lua
  local theta = require("alpha.themes.theta")

  local dashboard = require("alpha.themes.dashboard")

  local section_mru = theta.config.layout[4]

  -- buttons
  local section_buttons = {
    type = "group",
    val = {
      dashboard.button("e", "  New file", "<cmd>ene<cr>"),
      dashboard.button("r", "  Recent files", "<cmd>Telescope oldfiles<cr>"),
      dashboard.button("q", "  Quit", "<cmd>qa<cr>"),
    },
    opts = { spacing = 0 },
  }
  local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")

  local config = {
    layout = {
      { type = "padding", val = 2 },
      {
        type = "text",
        val = {
          "╭" .. string.rep("─", string.len(cwd) + 4) .. "╮",
          "│  " .. cwd .. "  │",
          "╰" .. string.rep("─", string.len(cwd) + 4) .. "╯",
        },
        opts = { position = "center", hl = "Type" },
      },
      { type = "padding", val = 1 },
      section_buttons,
      { type = "padding", val = 1 },
      section_mru,
    },
    opts = {
      margin = 5,
    },
  }

  alpha.setup(config)
end

return { setup = setup }

local function boxify(input, options)
  offset = options and options.offset or 0
  input = "  " .. input .. "  "
  return {
    "╭" .. string.rep("─", string.len(input) + offset + 4) .. "╮",
    "│  " .. input .. "  │",
    "╰" .. string.rep("─", string.len(input) + offset + 4) .. "╯",
  }
end

local function get_config()
  -- https://github.com/goolord/alpha-nvim/blob/main/lua/alpha/themes/theta.lua
  local theta = require("alpha.themes.theta")

  local dashboard = require("alpha.themes.dashboard")

  local section_mru = theta.config.layout[4].val[3]

  -- buttons
  local section_buttons = {
    type = "group",
    val = {
      dashboard.button("e", "  New file", "<cmd>ene<cr>"),
      dashboard.button("r", "  Recent files", "<cmd>Telescope oldfiles<cr>"),
      dashboard.button(",", "  Browse files", "<cmd>e .<cr>"),
      dashboard.button(".", "  Open terminal", "<cmd>term<cr>"),
      dashboard.button("w", "  Open workspace", "<cmd>Telescope workspaces<cr>"),
      dashboard.button("q", "  Quit", "<cmd>qa<cr>"),
    },
    opts = { spacing = 1 },
  }
  local config = {
    layout = {
      { type = "padding", val = 2 },
      {
        type = "text",
        val = { "╲    ╱", " ╲  ╱ ", "  ╲╱ ", "" },
        opts = { position = "center", hl = "NonText", redraw = true },
      },
      section_buttons,
      { type = "padding", val = 2 },
      {
        type = "text",
        val = function()
          local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
          return " " .. cwd
        end,
        opts = { position = "center", hl = "NonText", redraw = true },
      },
      { type = "padding", val = 1 },
      -- { type = "group", val = section_mru.val, },
      -- { type = "padding", val = 1 },
      {
        type = "text",
        val = "──",
        opts = { position = "center", hl = "NonText", redraw = true },
      },
    },
    opts = {
      margin = 5,
    },
  }

  return config
end

local function setup()
  local has, alpha = pcall(require, "alpha")
  if not has then
    return
  end
  local config = get_config()
  alpha.setup(config)
end

return { setup = setup }

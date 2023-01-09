-- scrollview: Scroll bars
local M = {
  "dstein64/nvim-scrollview",
  enabled = BaseConfig.features.scrollbars,
  event = "VeryLazy",
}

function M.config()
  require("scrollview").setup({
    -- Make it sit flush to the window edge. (default: 2)
    column = 1,
  })
end

return M

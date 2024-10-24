return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      on_colors = function(colors)
        -- https://github.com/folke/tokyonight.nvim/blob/main/extras/lua/tokyonight_moon.lua
        -- https://github.com/folke/tokyonight.nvim/blob/main/extras/lua/tokyonight_day.lua
        -- https://github.com/folke/tokyonight.nvim/blob/main/lua/tokyonight/util.lua
        local util = require("tokyonight.util")

        if colors.bg == "#222436" then -- tokyonight-moon
          colors.bg = "#23232f"

          for key, color in pairs(colors) do
            if type(color) == "string" and color:sub(1, 1) == "#" then
              if key:sub(1, 3) == "bg_" then
                colors[key] = util.blend(color, 0.85, "#000000")
              end
            end
          end
        elseif colors.bg == "#e1e2e7" then -- tokyonight-day
          local ignored = {
            fg_gutter = 1,
            comment = 1,
            border_highlight = 1,
          }

          for key, color in pairs(colors) do
            if type(color) == "string" and color:sub(1, 1) == "#" then
              if key:sub(1, 3) == "bg_" then
                colors[key] = util.blend(color, 0.5, "#ffffff")
              elseif ignored[key] then
                -- pass
              else
                -- colors[key] = util.blend(color, 0.7, "#000000")
                colors[key] = util.brighten(color, -0.2)
              end
            end
          end

          colors.bg = "#fdfdfd"
        end
      end,
    },
  },
}

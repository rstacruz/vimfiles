return {
  {
    "echasnovski/mini.indentscope",
    -- See https://www.lazyvim.org/extras/ui/mini-indentscope
    opts = {
      symbol = "│", -- ┆ ┊ │
      options = { try_as_border = true },

      draw = {
        delay = 0, -- default 100
        animation = require("mini.indentscope").gen_animation.none(),
      },
    },
  },
}

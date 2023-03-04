return {
  { -- Noice
    "folke/noice.nvim",
    opts = {
      presets = {
        lsp_doc_border = true,
      },
    },
  },

  { -- Notify
    "rcarriga/nvim-notify",
    opts = {
      render = "minimal", -- default: "default"
      stages = "fade", -- default: "fade_in_slide_out"
      top_down = false, -- shows at the bot. default: true
      max_width = function() -- default: columns * 0.75
        return math.floor(vim.o.columns * 0.5)
      end,
    },
  },

  { -- Pairs
    "echasnovski/mini.pairs",
    enabled = false,
  },

  { -- Indentscope
    "echasnovski/mini.indentscope",
    opts = {
      draw = {
        delay = 0, -- default: 100
        animation = require("mini.indentscope").gen_animation.none(),
      },
    },
  },
}

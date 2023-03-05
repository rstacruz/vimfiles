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
    -- Makes things more minimal and less intrusive
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
    -- I just don't like autopairs, that's all
    "echasnovski/mini.pairs",
    enabled = false,
  },

  { -- Indentscope
    -- Remove animations
    "echasnovski/mini.indentscope",
    opts = {
      draw = {
        delay = 0, -- default: 100
        animation = require("mini.indentscope").gen_animation.none(),
      },
    },
  },

  { -- Spectre
    -- Opens in insert mode
    "windwp/nvim-spectre",
    opts = {
      line_sep_start = "",
      result_padding = "   ",
      line_sep = "",
    },
    keys = {
      { -- Updates options passed to open()
        "<leader>sr",
        function()
          require("spectre").open({ is_insert_mode = true })
        end,
        desc = "Replace in files (Spectre)",
      },
      { -- new
        "<leader>s*",
        function()
          require("spectre").open({ select_word = true })
        end,
        desc = "Replace in files (Spectre)",
      },
    },
  },

  { -- Flit
    -- Rebinds `f F t T` to be leap-like. I can never get used to it :(
    "ggandor/flit.nvim",
    enabled = false,
  },

  { -- Neotree
    -- Changes key mappings
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      { "<leader>e", "<cmd>Neotree focus<cr>", { desc = "Focus Neotree" } },
      -- ^ Focus instead of toggle
    },
  },
}

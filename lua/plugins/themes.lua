return {
  { -- melange
    "savq/melange-nvim",
    lazy = true,
    event = "VeryLazy",
  },

  { -- caret
    "projekt0n/caret.nvim",
    lazy = true,
    event = "VeryLazy",
  },
  { -- github
    "projekt0n/github-nvim-theme",
    lazy = true,
    event = "VeryLazy",
  },

  { -- visual_studio_code
    "askfiy/visual_studio_code",
    lazy = true,
    event = "VeryLazy",
  },

  -- { -- kanagawa
  --   "rebelot/kanagawa.nvim",
  --   lazy = true,
  --   event = "VeryLazy",
  --   opts = {
  --     colors = {
  --       theme = {
  --         all = {
  --           ui = {
  --             bg_gutter = "none",
  --           },
  --         },
  --       },
  --     },
  --   },
  --   config = function(_, opts)
  --     require("kanagawa").setup(opts)
  --   end,
  -- },

  { -- edge: like onedark
    "sainnhe/edge",
    lazy = true,
    event = "VeryLazy",
    config = function()
      vim.g.edge_style = "neon"
      vim.g.edge_better_performance = 1
    end,
  },
  -- { "projekt0n/github-nvim-theme", lazy = true, event = "VeryLazy" },

  -- {
  --   "mcchrish/zenbones.nvim",
  --   lazy = true,
  --   event = "VeryLazy",
  --   dependencies = {
  --     { "rktjmp/lush.nvim", lazy = true },
  --   },
  --   config = function()
  --     local opts = { lightness = "bright", darkness = "warm", solid_line_nr = true }
  --     vim.g.zenbones = opts
  --     vim.g.rosebones = opts
  --     vim.g.tokyobones = opts
  --     vim.g.neobones = opts
  --   end,
  -- },

  { "EdenEast/nightfox.nvim", lazy = true, event = "VeryLazy" },

  -- Add a VeryLazy so it shows up in laeder-uC
  { "catppuccin/nvim", event = "VeryLazy" },
}

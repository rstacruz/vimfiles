return {
  { -- monet
    "fynnfluegge/monet.nvim",
    lazy = true,
    event = "VeryLazy",
  },

  { -- lackluster (greyscale)
    "slugbyte/lackluster.nvim",
    lazy = true,
    event = "VeryLazy",
  },

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
  {
    "catppuccin/nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      local c = require("catppuccin.utils.colors")

      opts.color_overrides = {
        latte = {
          base = "#ededf5",
        },

        frappe = {
          rosewater = c.brighten("#f4dbd6", 0.3),
          flamingo = c.brighten("#f0c6c6", 0.3),
          pink = c.brighten("#f5bde6", 0.3),
          mauve = c.brighten("#c6a0f6", 0.3),
          red = c.brighten("#ed8796", 0.3),
          maroon = c.brighten("#ee99a0", 0.3),
          peach = c.brighten("#f5a97f", 0.3),
          yellow = c.brighten("#eed49f", 0.3),
          green = c.brighten("#a6da95", 0.3),
          teal = c.brighten("#8bd5ca", 0.3),
          sky = c.brighten("#91d7e3", 0.3),
          sapphire = c.brighten("#7dc4e4", 0.3),
          blue = c.brighten("#8aadf4", 0.3),
          lavender = c.brighten("#b7bdf8", 0.3),
          text = c.brighten("#cad3f5", 0.3),
          subtext1 = c.brighten("#b8c0e0", 0.1),
          subtext0 = c.brighten("#a5adcb", 0.1),
          overlay2 = c.brighten("#939ab7", 0.1),
          overlay1 = c.brighten("#8087a2", 0.1),
          overlay0 = c.brighten("#6e738d", 0.1),
          surface2 = c.brighten("#5b6078", 0.1),
          surface1 = c.brighten("#494d64", 0.1),
          surface0 = c.brighten("#363a4f", 0.1),
          base = c.brighten("#24273a", 0.1),
          mantle = c.brighten("#1e2030", 0.1),
          crust = c.brighten("#181926", 0.1),
        },
      }
    end,
  },
}

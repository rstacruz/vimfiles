return {
  { -- indent-blankline.nvim
    -- change characters
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      char = "▏", -- from lazyvim: "│",

      -- add neorg and org
      filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason", "neorg", "org" },
    },
  },
}

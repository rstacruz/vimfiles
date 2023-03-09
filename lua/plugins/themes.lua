return {
  { "projekt0n/github-nvim-theme", lazy = true, event = "VeryLazy" },
  {
    "mcchrish/zenbones.nvim",
    lazy = true,
    event = "VeryLazy",
    dependencies = {
      { "rktjmp/lush.nvim", lazy = true },
    },
    config = function()
      local opts = { lightness = "bright", darkness = "warm", solid_line_nr = true }
      vim.g.zenbones = opts
      vim.g.rosebones = opts
      vim.g.tokyobones = opts
      vim.g.neobones = opts
    end,
  },
  { "EdenEast/nightfox.nvim", lazy = true, event = "VeryLazy" },
}

return {
  { "projekt0n/github-nvim-theme", lazy = true, event = "VeryLazy" },
  {
    "mcchrish/zenbones.nvim",
    lazy = true,
    event = "VeryLazy",
    dependencies = {
      { "rktjmp/lush.nvim", lazy = true },
    },
  },
  { "EdenEast/nightfox.nvim", lazy = true, event = "VeryLazy" },
}

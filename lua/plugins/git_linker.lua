return {
  { -- git linker
    "ruifm/gitlinker.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    lazy = true,
    opts = {},
    keys = {
      { "<leader>gy", desc = "Copy GitHub URL", mode = { "n", "v" } },
    },
  },
}

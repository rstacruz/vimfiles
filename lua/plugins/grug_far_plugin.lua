local defaults = {
  placeholders = {
    search = "Search",
    replace = "Replace",
  },
}
return {
  {
    "MagicDuck/grug-far.nvim",
    opts = { headerMaxWidth = 80 },
    cmd = "GrugFar",
    keys = {
      {
        "<leader>s*",
        function()
          local grug = require("grug-far")
          local word = vim.fn.expand("<cword>")
          -- https://github.com/MagicDuck/grug-far.nvim/blob/main/lua/grug-far/opts.lua
          grug.grug_far({
            prefills = { search = word, flags = "-i" },
            placeholders = { enabled = false },
          })
        end,
        desc = "Search for word",
      },
      {
        "<leader>sr",
        function()
          local grug = require("grug-far")
          grug.grug_far({
            prefills = { flags = "-i" },
            placeholders = { enabled = false },
          })
        end,
        mode = { "n", "v" },
        desc = "Search and Replace",
      },
    },
  },
}

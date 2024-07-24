return {
  {
    "MagicDuck/grug-far.nvim",
    opts = { headerMaxWidth = 80 },
    cmd = "GrugFar",
    keys = {
      {
        "<leader>sr",
        function()
          local grug = require("grug-far")
          grug.grug_far()
          -- local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
          -- grug.grug_far({
          --   prefills = {
          --     filesFilter = ext and ext ~= "" and "*." .. ext or nil,
          --   },
          -- })
        end,
        mode = { "n", "v" },
        desc = "Search and Replace",
      },
    },
  },
}

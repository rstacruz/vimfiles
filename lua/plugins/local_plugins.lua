return {
  {
    dir = vim.fn.stdpath("config") .. "/plugins/autosize",
    config = function()
      require("autosize").setup()
    end,
  },

  {
    dir = vim.fn.stdpath("config") .. "/plugins/persist_colorscheme",
    config = function()
      require("persist_colorscheme").setup()
    end,
  },

  {
    dir = vim.fn.stdpath("config") .. "/plugins/close_unused_buffers",
    lazy = true,
    config = function()
      require("close_unused_buffers").setup()
    end,
    keys = {
      {
        "<leader>bx",
        "<cmd>lua require('close_unused_buffers').close_unused_buffers()<cr>",
        desc = "Close unused buffers",
      },
    },
  },
}

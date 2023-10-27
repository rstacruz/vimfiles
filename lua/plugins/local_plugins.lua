return {
  {
    dir = vim.fn.stdpath("config") .. "/plugins/luasnip_codesnippets_loader",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    config = true,
  },
  {
    dir = vim.fn.stdpath("config") .. "/plugins/transparentize",
    lazy = true,
    config = function()
      require("autosize").setup()
    end,
    keys = {
      {
        "<leader>!t",
        "<cmd>lua require('transparentize').transparentize()<cr>",
        desc = "Make background transparent",
      },
    },
  },

  {
    dir = vim.fn.stdpath("config") .. "/plugins/autosize",
    lazy = true,
    event = "VeryLazy",
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

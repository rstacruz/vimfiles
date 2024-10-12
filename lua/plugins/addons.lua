-- Addons:
-- These are plugins that aren't included in the LazyVim.

return {
  {
    "chrisgrieser/nvim-chainsaw",
    lazy = true,
    opts = {
      marker = "🔹",
    },
    keys = {
      {
        "glm", -- g [l]g [m]essage
        function()
          require("chainsaw").messageLog()
        end,
        desc = "Log: custom message",
      },
      {
        "glv", -- g [l]og [v]ar
        function()
          require("chainsaw").variableLog()
        end,
        desc = "Log: variable log",
      },
      {
        "glt",
        function()
          require("chainsaw").timeLog()
        end,
        desc = "Log: time log",
      },
      {
        "glj", -- g [l]og [j]son
        function()
          require("chainsaw").objectLog()
        end,
        desc = "Log: JSON.stringify log",
      },
      {
        "glx",
        function()
          require("chainsaw").removeLogs()
        end,
        desc = "Log: remove logs",
      },
    },
  },

  { -- align.nvim
    "echasnovski/mini.align",
    version = "*",
    lazy = true,
    opts = true,
    event = { "LazyFile" },
  },

  { -- context (show context lines)
    "nvim-treesitter/nvim-treesitter-context",
    lazy = true,
    event = "LazyFile",
    opts = {},
    keys = {
      { "<leader>ux", "<cmd>TSContextToggle<cr>", desc = "Toggle context lines" },
    },
  },

  { -- vim-slim (.slim filename support)
    "slim-template/vim-slim",
    lazy = true,
    ft = "slim",
  },

  { -- mini.files (file browser)
    "echasnovski/mini.files",
    lazy = true,
    opts = {
      windows = {
        max_number = math.huge,
        preview = true,
        width_focus = 40,
        width_nofocus = 30,
        width_preview = 60,
      },
      options = {
        -- Whether to use for editing directories
        -- Disabled by default in LazyVim because neo-tree is used for that
        use_as_default_explorer = false,
      },
      mappings = {
        go_in = "<Right>",
        go_in_plus = "<CR>",
        go_out = "<Left>",
      },
    },
    keys = {
      {
        "-",
        function()
          require("mini.files").open(vim.api.nvim_buf_get_name(0), false)
        end,
        "Open mini.files",
      },
    },
  },

  { -- early retirement (closes inactive tabs)
    "chrisgrieser/nvim-early-retirement",
    lazy = true,
    opts = {
      retirementAgeMins = 5, -- Close tabs after 5min of inactivity
    },
    config = true,
    event = "VeryLazy",
  },

  { -- terminal
    "akinsho/toggleterm.nvim",
    lazy = true,
    cmd = { "ToggleTerm" },
    opts = {
      size = 20,
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)
    end,
    keys = {
      { "<leader>!.", "<cmd>ToggleTerm<cr>", desc = "Terminal (below)" },
      { "<leader>.", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Terminal (right)" },
      { "<leader>gf", '<cmd>w | TermExec size=6 cmd="git-fastsync && exit"<cr>', desc = "Git fastsync" },
    },
  },

  { -- indent detection
    "Darazaki/indent-o-matic",
    opts = {},
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    config = function(_, opts)
      require("indent-o-matic").setup(opts)
    end,
  },

  { -- scrollview: Scroll bars
    "dstein64/nvim-scrollview",
    lazy = true,
    event = "VeryLazy",
    opts = {
      -- Make it sit flush to the window edge. (default: 2)
      column = 1,
    },
    config = function(_, opts)
      require("scrollview").setup(opts)
    end,
  },

  { -- surround (replaces mini-surround)
    "kylechui/nvim-surround",
    lazy = true,
    event = { "LazyFile" },
    opts = {},
    config = function(_, opts)
      require("nvim-surround").setup(opts)
    end,
  },

  { -- lsp-lines: show more diagnostic info
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    lazy = true,
    -- event = "VeryLazy",
    keys = {
      { "<leader>uv", "<cmd>lua require('etc.toggle_virtual_lines').toggle()<cr>", desc = "Toggle virtual lines/text" },
    },
    config = function()
      require("lsp_lines").setup()
    end,
  },

  {
    "echasnovski/mini.misc",
    lazy = false,
    config = function()
      require("mini.misc").setup_termbg_sync()
    end,
  },
}

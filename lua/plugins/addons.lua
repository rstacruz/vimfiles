-- Addons:
-- These are plugins that aren't included in the LazyVim.

local is_vscode = vim.g.vscode or vim.env.VSCODE
local uname = vim.loop.os_uname()
local is_android = uname.machine == "aarch64"

return {
  { -- debugprint
    "andrewferrier/debugprint.nvim",
    lazy = true,
    opts = {},
    keys = {
      { "g?p", desc = "Debug: insert below" },
      { "g?P", desc = "Debug: insert above" },
      { "g?v", desc = "Debug: insert below from variable" }, -- (put cursor on a var)
      { "g?v", desc = "Debug: insert from variable", mode = "v" },
    },
  },

  { -- align.nvim
    "echasnovski/mini.align",
    version = "*",
    lazy = true,
    opts = true,
    event = { "BufReadPost" },
  },

  { -- context
    "nvim-treesitter/nvim-treesitter-context",
    lazy = true,
    event = "BufReadPost",
    opts = {},
    keys = {
      { "<leader>ux", "<cmd>TSContextToggle<cr>", desc = "Toggle context lines" },
    },
  },

  { -- Origami
    -- `^ h` to fold (h at first non-blank char)
    -- `l` to unfold
    "chrisgrieser/nvim-origami",
    lazy = true,
    event = "BufReadPost",
    opts = true,
  },

  {
    "slim-template/vim-slim",
    lazy = true,
    ft = "slim",
  },

  { -- mini.files
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
        "_",
        function()
          require("mini.files").open(vim.api.nvim_buf_get_name(0), false)
        end,
        "Open mini.files",
      },
    },
  },

  { -- headlines
    "lukas-reineke/headlines.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    lazy = true,
    event = {
      "BufReadPre **.md",
      "BufNewFile **.md",
    },
    opts = {
      markdown = {
        -- Termux doesn't display the characters well
        -- fat_headlines = false,
        fat_headlines = not is_android,

        headline_highlights = {
          "DiffAdd",
          "DiffDelete",
          "DiffChange",
        },
        -- codeblock_highlight = "DiffChange",
        -- Differentiates it a bit from code block
        -- headline_highlights = {
        --   "DiagnosticVirtualTextError",
        --   "DiagnosticVirtualTextInfo",
        --   "DiagnosticVirtualTextWarn",
        --   "CursorLine",
        -- },

        dash_string = "─",
      },
    },
    config = true, -- or `opts = {}`
  },

  { -- early retirement: closes inactive tabs
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
      { "<leader>.", "<cmd>ToggleTerm<cr>", desc = "Terminal" },
      { "<leader>gf", '<cmd>TermExec cmd="git-fastsync && exit"<cr>', desc = "Git fastsync" },
    },
  },

  { -- indent detection
    "Darazaki/indent-o-matic",
    opts = {},
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    enabled = not is_vscode,
    config = function(_, opts)
      require("indent-o-matic").setup(opts)
    end,
  },

  { -- refactoring
    "ThePrimeagen/refactoring.nvim",
    lazy = true,
    enabled = not is_vscode,
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" },
    },
    keys = {
      {
        "<leader>ce",
        "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
        desc = "Select refactor...",
        mode = "v",
      },
      -- {
      --   "<leader>cE",
      --   "<cmd>lua require('refactoring').select_refactor()<cr>",
      --   desc = "Select refactor...",
      --   mode = "v",
      -- },
    },
    opts = {},
    config = function(_, opts)
      require("refactoring").setup(opts)
      require("telescope").load_extension("refactoring")
    end,
  },

  { -- scrollview: Scroll bars
    "dstein64/nvim-scrollview",
    lazy = true,
    event = "VeryLazy",
    enabled = not is_vscode,
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
    event = { "BufReadPost" },
    opts = {},
    config = function(_, opts)
      require("nvim-surround").setup(opts)
    end,
  },

  { -- lsp-lines: show more diagnostic info
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    lazy = true,
    -- event = "VeryLazy",
    enabled = not is_vscode,
    keys = {
      { "<leader>uv", "<cmd>lua require('etc.toggle_virtual_lines').toggle()<cr>", desc = "Toggle virtual lines/text" },
    },
    config = function()
      require("lsp_lines").setup()
    end,
  },

  { -- pretty fold
    "anuvyklack/pretty-fold.nvim",
    lazy = true,
    event = { "BufReadPost" },
    enabled = not is_vscode,
    opts = {
      fill_char = " ",
    },
    config = function(_, opts)
      require("pretty-fold").setup(opts)
    end,
  },

  { -- fugitive: Git blame and open in GitHub
    "tpope/vim-fugitive",
    lazy = true,
    enabled = not is_vscode,
    cmd = "Git",
    keys = {
      { "<leader>gb", "<cmd>Git blame<cr>", desc = "Git Blame" },
    },
  },
}

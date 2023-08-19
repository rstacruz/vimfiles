-- Addons:
-- These are plugins that aren't included in the LazyVim.

local is_vscode = vim.g.vscode or vim.env.VSCODE
local uname = vim.loop.os_uname()
local is_android = uname.arch == "aarch64"

return {
  { -- align.nvim
    "echasnovski/mini.align",
    version = "*",
    lazy = true,
    opts = true,
    event = "VeryLazy",
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
    opts = {
      windows = {
        max_number = 4,
        preview = true,
        width_focus = 40,
        width_nofocus = 10,
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
          require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
        end,
        "Open mini.files",
      },
    },
  },

  {
    "echasnovski/mini.jump2d",
    version = "*",
    opts = {
      labels = "arstgoiendhgmcplfuwybjx", -- colemak-dh bias, no pinkies
      view = {
        n_steps_ahead = 2, -- show more chars rather than just one
      },
      allowed_windows = {
        not_current = false, -- only show on current window
      },
    },
    lazy = true,
    config = function(_, opts)
      require("mini.jump2d").setup(opts)
    end,
    keys = {
      {
        "gl",
        function()
          MiniJump2d.start(MiniJump2d.builtin_opts.line_start)
        end,
        desc = "Go to line",
        mode = { "n", "v" },
      },
      {
        "gm",
        function()
          MiniJump2d.start(MiniJump2d.builtin_opts.word_start)
        end,
        desc = "Go to word",
        mode = { "n", "v" },
      },
      {
        "g!",
        function()
          MiniJump2d.start({
            spotter = MiniJump2d.gen_pattern_spotter("['\"`]"),
          })
        end,
        desc = "Go to quote",
        mode = { "n", "v" },
      },
    },
  },

  { -- headlines
    "lukas-reineke/headlines.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    opts = {
      markdown = {
        -- Termux doesn't display the characters well
        fat_headlines = not is_android,

        -- Differentiates it a bit from code block
        headline_highlights = {
          "DiagnosticVirtualTextError",
          "DiagnosticVirtualTextInfo",
          "DiagnosticVirtualTextWarn",
          "CursorLine",
        },

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
      { "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "Terminal" },
      { "<leader>ta", "<cmd>ToggleTerm 1<cr>", desc = "Terminal 1" },
      { "<leader>tr", "<cmd>ToggleTerm 2<cr>", desc = "Terminal 2" },
      { "<leader>ts", "<cmd>ToggleTerm 3<cr>", desc = "Terminal 3" },
    },
  },

  { -- indent detection
    "Darazaki/indent-o-matic",
    opts = {},
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

  { -- aerial: symbols
    "stevearc/aerial.nvim",
    lazy = true,
    enabled = not is_vscode,
    opts = {
      -- see :help SymbolKind
      filter_kind = false,
      -- filter_kind = {
      --   "Class", "Constructor", "Enum", "Function", "Interface", "Module", "Method", "Struct",
      -- },
    },
    keys = {
      { "<leader>cs", "<cmd>AerialToggle!<cr>", desc = "Browse symbol outline" },
      { "<leader>!o", "<cmd>Telescope aerial<cr>", desc = "Go to symbol outline (aerial)" }, -- like leader-ss but supports more non-lsp filetypes
    },
    config = function(_, opts)
      opts.on_attach = function(bufnr)
        -- Jump forwards/backwards with '{' and '}'
        vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr, desc = "Prev symbol" })
        vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr, desc = "Next symbol" })
      end
      require("aerial").setup(opts)
      require("telescope").load_extension("aerial")
    end,
  },

  { -- surround (replaces mini-surround)
    "kylechui/nvim-surround",
    lazy = true,
    event = "VeryLazy",
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

  { -- zk: Markdown lsp for notes
    "mickael-menu/zk-nvim",
    lazy = true,
    ft = { "markdown" },
    enabled = not is_vscode and not is_android,
    opts = {
      picker = "telescope",
    },
    config = function(_, opts)
      require("zk").setup(opts)
      require("lazyvim.util").on_attach(function(client, buffer)
        if client.name == "zk" then
          -- stylua: ignore start
          vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { buffer = buffer, desc = "Preview link under cursor" })
          vim.keymap.set("n", "gf", "<cmd>lua vim.lsp.buf.definition()<CR>", { buffer = buffer, desc = "Follow link" })
          vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { buffer = buffer, desc = "Follow link" })
          vim.keymap.set("n", "gr", "<cmd>ZkBacklinks<CR>", { buffer = buffer, desc = "Show backlinks (references)" })

          vim.keymap.set("n", "<leader>zr", "<cmd>ZkBacklinks<CR>", { buffer = buffer, desc = "Show backlinks (references)" })
          vim.keymap.set("n", "<leader>zl", "<cmd>ZkLinks<CR>", { buffer = buffer, desc = "Show outgoing links" })
          vim.keymap.set("n", "<leader>zn", "<Cmd>ZkNew { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>", { buffer = buffer, desc = "Create new page…" })

          -- Create a note in the same dir, using current selection for content
          vim.keymap.set("v", "<leader>zn", "<Cmd>ZkNewFromContentSelection { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>", { buffer = buffer, desc = "Create new page from selection…" })

          -- Create a note in the same dir, using current selection for title
          vim.keymap.set("v", "<leader>zt", "<Cmd>ZkNewFromTitleSelection { dir = vim.fn.expand('%:p:h') }<CR>", { buffer = buffer, desc = "Link to new file…" })
          -- stylua: ignore end
        end
      end)
    end,
  },

  { -- pretty fold
    "anuvyklack/pretty-fold.nvim",
    lazy = true,
    event = "VeryLazy",
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
    event = "VeryLazy",
    enabled = not is_vscode,
    dependencies = {
      "tpope/vim-rhubarb",
    },
    keys = {
      { "<leader>giy", "<cmd>GBrowse!<cr>", desc = "Copy GitHub URL", mode = { "n", "v" } },
      { "<leader>giY", "<cmd>GBrowse<cr>", desc = "Open GitHub URL in browser", mode = { "n", "v" } },
      { "<leader>gb", "<cmd>Git blame<cr>", desc = "Git Blame" },
    },
  },
}

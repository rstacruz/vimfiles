-- Addons:
-- These are plugins that aren't included in the LazyVim.

local is_vscode = vim.g.vscode or vim.env.VSCODE

return {
  {
    "echasnovski/mini.jump2d",
    version = "*",
    opts = {},
    lazy = true,
    config = function()
      require("mini.jump2d").setup()
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
        "gw",
        function()
          MiniJump2d.start({
            spotter = MiniJump2d.gen_pattern_spotter("%a+"),
          })
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
        dash_string = "─",
        -- differentiates it a bit from code block
        headline_highlights = { "DiagnosticVirtualTextWarn", "DiagnosticVirtualTextInfo" },
      },
    },
    config = true, -- or `opts = {}`
  },

  { -- Harpoon
    "ThePrimeagen/harpoon",
    lazy = true,
    keys = {
      {
        "<leader>!fm",
        function()
          require("harpoon.ui").toggle_quick_menu()
        end,
        desc = "Edit marks... (harpoon)",
      },
      {
        "<leader>fm",
        "<cmd>Telescope harpoon marks<cr>",
        desc = "Show marks... (harpoon)",
      },
      {
        "<leader>fM",
        function()
          require("harpoon.mark").add_file()
        end,
        desc = "Mark this file (harpoon)",
      },
    },
    config = function()
      require("telescope").load_extension("harpoon")
    end,
  },

  { -- orgmode
    -- just trying it out
    "nvim-orgmode/orgmode",
    -- lazy = true,
    -- ft = { "org" },
    dependencies = {
      { "akinsho/org-bullets.nvim", lazy = true },
    },
    opts = {
      org_agenda_files = { "~/Dev/org/*" },
      org_default_notes_file = "~/Dev/org/index.org",
    },
    config = function(_, opts)
      require("orgmode").setup_ts_grammar()
      require("orgmode").setup(opts)
    end,
  },

  { -- Neorg: note taking
    -- I don't use this much, just giving this a try (Apr 2023)
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    lazy = true,
    ft = { "neorg", "norg" },
    cmd = { "Neorg" },
    opts = {
      load = {
        ["core.defaults"] = {}, -- Loads default behaviour
        -- meta-enter will continue lists and headings
        -- https://github.com/nvim-neorg/neorg/wiki/Itero
        ["core.itero"] = {},
        ["core.concealer"] = {
          config = {
            icon_preset = "basic", -- basic | diamond | varied
          },
        }, -- Adds pretty icons to your documents
        -- ["core.norg.dirman"] = { -- Manages Neorg workspaces
        --   config = {
        --     workspaces = {
        --       notes = "~/notes",
        --     },
        --   },
        -- },
      },
    },
    dependencies = { { "nvim-lua/plenary.nvim" } },
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
      { "_", "<cmd>ToggleTerm<cr>", desc = "Terminal" },
      { "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "Terminal" },
      { "<leader>ta", "<cmd>ToggleTerm 1<cr>", desc = "Terminal 1" },
      { "<leader>tr", "<cmd>ToggleTerm 2<cr>", desc = "Terminal 2" },
      { "<leader>ts", "<cmd>ToggleTerm 3<cr>", desc = "Terminal 3" },
    },
  },

  { -- hop
    "phaazon/hop.nvim",
    lazy = true,
    opts = {},
    config = function(_, opts)
      require("hop").setup(opts)
    end,
    keys = {
      { "gh", "<cmd>HopWord<cr>", desc = "Go to word..." },
      { "g/", "<cmd>HopPattern<cr>", desc = "Find pattern..." },
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
      { "<leader>!a", "<cmd>Telescope aerial<cr>", desc = "Go to symbol (aerial)" }, -- like leader-ss but supports more non-lsp filetypes
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

  { -- file browser
    "nvim-telescope/telescope-file-browser.nvim",
    keys = {
      { "<leader>_", "<cmd>Telescope file_browser<cr>", desc = "Browse files" },
    },
    enabled = not is_vscode,
    config = function()
      require("telescope").load_extension("file_browser")
    end,
  },

  { -- lsp-lines: show more diagnostic info
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    lazy = true,
    event = "VeryLazy",
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
    enabled = not is_vscode,
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

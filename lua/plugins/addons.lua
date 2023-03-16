return {
  { -- zk: Markdown lsp for notes
    "mickael-menu/zk-nvim",
    lazy = true,
    event = "VeryLazy",
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
    dependencies = {
      "tpope/vim-rhubarb",
    },
    keys = {
      { "<leader>giy", "<cmd>GBrowse!<cr>", desc = "Copy GitHub URL", mode = { "n", "v" } },
      { "<leader>giY", "<cmd>GBrowse<cr>", desc = "Open GitHub URL in browser", mode = { "n", "v" } },
      { "<leader>gb", "<cmd>Git blame<cr>", desc = "Git Blame" },
    },
  },

  { -- symbols outline
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    config = true,
  },
}

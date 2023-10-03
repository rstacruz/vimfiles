return {
  { -- markdown image
    -- PasteImg
    "postfen/clipboard-image.nvim",
    -- Upstream is "ekickx/clipboard-image.nvim",
    -- Context for fork: https://github.com/ekickx/clipboard-image.nvim/pull/48#issuecomment-1589760763
    lazy = true,
    cmd = { "PasteImg" },
    opts = {
      default = {
        img_dir = "Media",
        -- https://github.com/ekickx/clipboard-image.nvim/discussions/15#discussioncomment-1638740
        img_name = function()
          vim.fn.inputsave()
          local name = vim.fn.input("Name: ")
          vim.fn.inputrestore()
          return name
        end,
      },
    },
  },

  { -- obsidian
    -- :ObsidianOpen - open in obsidian app
    -- :ObsidianQuickSwitch
    -- :ObsidianFollowLink
    -- :ObsidianBacklinks
    -- :ObsidianSearch
    "epwalsh/obsidian.nvim",
    lazy = true,
    event = vim.g.obsidian_vault_dir and {
      -- "BufReadPre " .. vim.fn.expand(vim.g.obsidian_vault_dir) .. "/**.md",
      -- "BufNewFile " .. vim.fn.expand(vim.g.obsidian_vault_dir) .. "/**.md",
      "BufReadPre **.md",
      "BufNewFile **.md",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      dir = vim.g.obsidian_vault_dir,
      mappings = {},

      notes_subdir = "Scratch",

      -- Disable auto-updating frontmatter id, createdAt, alias, etc
      disable_frontmatter = true,

      completion = {
        -- options: current_dir (default), notes_subdir
        new_notes_location = "notes_subdir",
      },
    },
    config = function(_, opts)
      require("obsidian").setup(opts)

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("obsidian_keybindings", { clear = true }),
        pattern = { "markdown" },
        callback = function(event)
          -- event = { buf, event, file, group, id, match }
          vim.keymap.set(
            "n",
            "<leader>mr",
            "<cmd>ObsidianBacklinks<CR>",
            { buffer = event.buf, desc = "Obsidian: Show backlinks" }
          )
          vim.keymap.set(
            "n",
            "gr",
            "<cmd>ObsidianBacklinks<CR>",
            { buffer = event.buf, desc = "Obsidian: Show backlinks" }
          )
          vim.keymap.set(
            "n",
            "<c-p>",
            "<cmd>ObsidianQuickSwitch<CR>",
            { buffer = event.buf, desc = "Obsidian: Open..." }
          )
          vim.keymap.set(
            "n",
            "<leader>ms",
            "<cmd>ObsidianQuickSwitch<CR>",
            { buffer = event.buf, desc = "Obsidian: Open..." }
          )
          vim.keymap.set(
            "n",
            "<leader>m/",
            "<cmd>ObsidianSearch<CR>",
            { buffer = event.buf, desc = "Obsidian: Search..." }
          )
          vim.keymap.set(
            "n",
            "gf",
            "<cmd>ObsidianFollowLink<CR>",
            { buffer = event.buf, desc = "Obsidian: Follow link" }
          )
        end,
      })
    end,
    -- TODO: add mappings for ctrl-p -> :ObsidianQuickSwitch
    -- TODO: add mappings for gf (ObsidianFollowLink)
    -- TODO: add mappings for gr (ObsidianBacklinks)
  },
}

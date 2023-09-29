return {
  { -- cp-image
    -- Use `:PasteImage`
    "niuiic/cp-image.nvim",
    lazy = true,
    dependencies = { "niuiic/core.nvim" },
    cmd = { "PasteImage" },
    opts = {
      -- These settings are biased towards my Obsidian vaults
      cmd = function(path, image_type)
        if vim.fn.executable("wl-paste") then
          return string.format("wl-paste -t image > %s", path)
        else
          vim.notify("Don't know how to paste, sorry :(")
          return false
        end
      end,
      text = function(relative_path, file_name, file_type, full_path)
        local basename = vim.fn.fnamemodify(file_name, ":t") .. "." .. file_type
        return string.format("![[%s]]", basename)
      end,
      path = function(project_root)
        return project_root .. "/Media"
      end,
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
      "BufReadPre " .. vim.fn.expand(vim.g.obsidian_vault_dir) .. "/**.md",
      "BufNewFile " .. vim.fn.expand(vim.g.obsidian_vault_dir) .. "/**.md",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      dir = vim.g.obsidian_vault_dir,
      -- Disable auto-updating frontmatter id, createdAt, alias, etc
      disable_frontmatter = true,
      mappings = {},
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

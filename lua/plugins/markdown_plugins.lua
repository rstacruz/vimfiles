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
    -- :ObsidianBacklinks
    -- :ObsidianSearch
    -- :ObsidianFollowLink
    -- :ObsidianQuickSwitch
    "epwalsh/obsidian.nvim",
    lazy = true,
    ft = "markdown",
    -- event = vim.g.obsidian_vault_dir and {
    --   -- "BufReadPre " .. vim.fn.expand(vim.g.obsidian_vault_dir) .. "/**.md",
    --   -- "BufNewFile " .. vim.fn.expand(vim.g.obsidian_vault_dir) .. "/**.md",
    --   "BufReadPre **.md",
    --   "BufNewFile **.md",
    -- },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = {
      "ObsidianToday",
      "ObsidianTomorrow",
      "ObsidianSearch",
      "ObsidianWorkspace",
    },
    opts = {
      workspaces = {
        {
          name = "personal",
          path = vim.g.obsidian_vault_dir,
        },
      },

      notes_subdir = "Pages",

      completion = {
        -- options: current_dir (default), notes_subdir
        new_notes_location = "notes_subdir",
      },

      note_id_func = function(title)
        -- Default behaviour: return something like "124351678905-XYZX"
        return title
      end,

      note_frontmatter_func = function(note)
        -- Add createdAt: in the frontmatter
        local out = {}

        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end

        if out.createdAt == nil then
          out.createdAt = os.date("!%Y-%m-%dT%TZ")
        end

        if note.aliases and next(note.aliases) ~= nil then
          out.aliases = note.aliases
        end

        if note.tags and next(note.tags) ~= nil then
          out.tags = note.tags
        end

        if string.match(note.id, "(index)") then
          out["BC-link-note"] = "down"
        end
        return out
      end,

      attachments = {
        img_folder = "Media", -- default: "assets/imgs"
      },
      ui = {
        checkboxes = {
          -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
          -- Inspired by https://minimal.guide/checklists
          -- ObsidianRightArrow = orange
          -- ObsidianTilde = red
          [" "] = { char = "󰄱", hl_group = "Comment" },
          ["!"] = { char = "󰄱", hl_group = "DiagnosticError" }, -- high priority
          ["x"] = { char = "󰄲", hl_group = "DiagnosticOk" }, -- nf-md-checkbox_marked
          ["y"] = { char = "󰄲", hl_group = "DiagnosticOk" }, -- nf-md-checkbox_marked
          [">"] = { char = "󰒊", hl_group = "Comment" }, -- nf-md-send
          ["<"] = { char = "󰃰", hl_group = "Comment" }, -- nf-md-calendar_clock
          -- ["<"] = { char = "󰥔", hl_group = "ObsidianRightArrow" }, -- nf-md-calendar_clock
          -- ["<"] = { char = "󰃮", hl_group = "ObsidianRightArrow" }, -- nf-md-calendar_blank
          ["~"] = { char = "󰂭", hl_group = "Comment" },
          ["i"] = { char = "󰋼", hl_group = "DiagnosticInfo" }, -- nf-md-information
          -- ["I"] = { char = "󰛨", hl_group = "DiagnosticWarn" }, -- nf-md-lightbulb_on
          ["I"] = { char = "󰌵", hl_group = "DiagnosticWarn" }, -- nf-md-lightbulb
          ["p"] = { char = "󰔓", hl_group = "DiagnosticOk" }, -- nf-md-thumb_up
          ["c"] = { char = "󰔑", hl_group = "DiagnosticError" }, -- nf-md-thumb_down
          ["s"] = { char = "󰓎", hl_group = "DiagnosticWarn" }, -- nf-md-star (asterisk * doesn't work)
          ["/"] = { char = "󰿦", hl_group = "DiagnosticWarn" }, -- in progress, nf-md-texture_box
        },
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
            "v",
            "<leader>ml",
            "<cmd>ObsidianLink<CR>",
            { buffer = event.buf, desc = "Obsidian: Link selection to..." }
          )
          vim.keymap.set("v", "<leader>mX", function()
            vim.cmd("ObsidianLinkNew")
          end, { buffer = event.buf, desc = "Obsidian: Link selection to (infer title)" })
          vim.keymap.set("v", "<leader>mx", function()
            local new_name = vim.fn.input("New name: ", "", "file")
            if new_name == "" then
              return
            end
            vim.cmd("ObsidianLinkNew " .. new_name)
          end, { buffer = event.buf, desc = "Obsidian: Link selection to..." })
          vim.keymap.set(
            "n",
            "<leader>mp",
            "<cmd>ObsidianPasteImg<CR>",
            { buffer = event.buf, desc = "Obsidian: Paste image" }
          )
          vim.keymap.set(
            "n",
            "<leader>mr",
            "<cmd>ObsidianBacklinks<CR>",
            { buffer = event.buf, desc = "Obsidian: Show backlinks" }
          )
          vim.keymap.set("n", "<leader>mR", function()
            local current_name = vim.fn.expand("%:t:r")
            local new_name = vim.fn.input("New name: ", current_name, "file")
            if new_name == "" then
              return
            end
            vim.cmd("ObsidianRename " .. new_name)
          end, { buffer = event.buf, desc = "Obsidian: Rename..." })
          vim.keymap.set(
            "n",
            "gr",
            "<cmd>ObsidianBacklinks<CR>",
            { buffer = event.buf, desc = "Obsidian: Show backlinks" }
          )
          -- vim.keymap.set(
          --   "n",
          --   "<c-p>",
          --   "<cmd>ObsidianQuickSwitch<CR>",
          --   { buffer = event.buf, desc = "Obsidian: Open..." }
          -- )
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
      norg = {
        headline_highlights = false,
      },
      markdown = {
        -- Termux doesn't display the characters well
        -- fat_headlines = is_android(),

        fat_headlines = false,

        headline_highlights = {
          "DiffDelete",
          "DiffAdd",
          "Headline",
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
}

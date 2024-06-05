local uname = vim.loop.os_uname()
local is_android = uname.machine == "aarch64"

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

      -- options: current_dir (default), notes_subdir
      new_notes_location = "notes_subdir",

      attachments = {
        img_folder = "Media", -- default: "assets/imgs"
      },

      wiki_link_func = function(opts)
        -- default: wiki_link_id_prefix (`[[id|title]]`)
        local link = require("obsidian.util").wiki_link_id_prefix(opts)
        -- remove suffix (`[[id|title]]` -> `[[id]]`)
        local output = string.gsub(link, "|[^]]+", "")
        return output
      end,

      note_id_func = function(title)
        -- Default behaviour: return something like "124351678905-XYZX"
        if title then
          return title
        end

        return "Untitled-" .. tostring(os.time())
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
          -- "2405 Page" -> 2024-05-01
          local datestamp = os.date("!%Y%m")
          ---@cast datestamp string
          if string.match(note.id, "^%d%d%d%d ") and string.sub(note.id, 1, 4) ~= string.sub(datestamp, 3, 9) then
            local year = "20" .. string.sub(note.id, 1, 2)
            local month = string.sub(note.id, 3, 4)
            local ymd = "" .. year .. "-" .. month .. "-01T00:00:00Z"
            out.createdAt = ymd
          else
            out.createdAt = os.date("!%Y-%m-%dT%TZ")
          end
        end

        -- Only save aliases if they're not the same as [self]
        if note.aliases and next(note.aliases) ~= nil and (#note.aliases ~= 1 or note.aliases[1] ~= note.id) then
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
          [">"] = { char = "󰒊", hl_group = "DiagnosticInfo" }, -- nf-md-send
          ["<"] = { char = "󰃰", hl_group = "DiagnosticInfo" }, -- nf-md-calendar_clock
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

      -- override mappings to remove `<leader>ch` and `<cr>`
      mappings = {
        ["gf"] = {
          action = function()
            return require("obsidian").util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
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
          -- vim.keymap.set("v", "<leader>mX", function()
          --   vim.cmd("ObsidianLinkNew")
          -- end, { buffer = event.buf, desc = "Obsidian: Link selection to (infer title)" })

          -- vim.keymap.set("v", "<leader>mx", function()
          --   local new_name = vim.fn.input("New name: ", "", "file")
          --   if new_name == "" then
          --     return
          --   end
          --   vim.cmd("ObsidianLinkNew " .. new_name)
          -- end, { buffer = event.buf, desc = "Obsidian: Link selection to..." })

          vim.keymap.set("v", "<leader>mx", function()
            local new_name = vim.fn.input("New name: ", "", "file")
            if new_name == "" then
              return
            end
            vim.cmd("ObsidianExtractNote " .. new_name)
          end, { buffer = event.buf, desc = "Obsidian: Extract to..." })

          vim.keymap.set(
            "n",
            "<leader>mp",
            "<cmd>ObsidianPasteImg<CR>",
            { buffer = event.buf, desc = "Obsidian: Paste image" }
          )

          vim.keymap.set(
            "n",
            "<c-a>", -- yep, conflicts with a default
            "<cmd>ObsidianToggleCheckbox<CR>",
            { buffer = event.buf, desc = "Obsidian: Toggle checkbox" }
          )

          vim.keymap.set(
            "n",
            "<leader>mc",
            "<cmd>ObsidianToggleCheckbox<CR>",
            { buffer = event.buf, desc = "Obsidian: Toggle checkbox" }
          )

          vim.keymap.set(
            "n",
            "<leader>mf",
            "<cmd>ObsidianFollowLink vsplit<CR>",
            { buffer = event.buf, desc = "Obsidian: Follow link in vsplit" }
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
    -- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/lang/markdown.lua#L65
    "lukas-reineke/headlines.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    lazy = true,
    event = {
      "BufReadPre **.md",
      "BufNewFile **.md",
    },
    ft = { "markdown", "norg", "rmd", "org" },
    opts = function()
      local filetype_opts = {
        -- Termux doesn't display the characters well
        fat_headlines = false, -- not is_android,

        -- disable bullets for now. See https://github.com/lukas-reineke/headlines.nvim/issues/66
        bullets = {},

        headline_highlights = {
          "DiffAdd",
          "Headline",
        },

        -- headline_highlights = {
        --   "DiffDelete",
        --   "DiffAdd",
        --   "Headline",
        -- },
        -- codeblock_highlight = "DiffChange",
        -- Differentiates it a bit from code block
        -- headline_highlights = {
        --   "DiagnosticVirtualTextError",
        --   "DiagnosticVirtualTextInfo",
        --   "DiagnosticVirtualTextWarn",
        --   "CursorLine",
        -- },

        dash_string = "─",
      }
      return {
        norg = {
          headline_highlights = false,
        },
        markdown = filetype_opts,
        rmd = filetype_opts,
      }
    end,
    config = function(_, opts)
      -- PERF: schedule to prevent headlines slowing down opening a file
      vim.schedule(function()
        require("headlines").setup(opts)
        require("headlines").refresh()
      end)
    end,
  },
}

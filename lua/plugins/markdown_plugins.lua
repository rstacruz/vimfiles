local uname = vim.loop.os_uname()
local is_android = uname.machine == "aarch64"

local home = os.getenv("HOME")

local function filter(array, criteriaFunc)
  local result = {}
  for _, value in ipairs(array) do
    if criteriaFunc(value) then
      table.insert(result, value)
    end
  end
  return result
end

local workspaces = filter({
  { path = home .. "/Documents/Vaults/Notes", name = "Notes" },
  { path = home .. "/Documents/Vaults/Worknotes", name = "Work" },
  { path = home .. "/Documents/Vaults/Extranotes", name = "Extras" },
}, function(entry)
  return vim.fn.isdirectory(entry.path) == 1
end)

return {
  {
    "MeanderingProgrammer/markdown.nvim",
    lazy = true,
    event = {
      "BufReadPre **.md",
      "BufNewFile **.md",
    },
    ft = { "markdown", "norg", "rmd", "org" },
    opts = {
      bullet = {
        enabled = true,
        -- default: { '●', '○', '◆', '◇' },
        icons = { "─", "·", "·", "·" },
        -- highlight = 'RenderMarkdownBullet',
        highlight = "DiagnosticInfo", -- 'RenderMarkdownBullet',
      },
      checkbox = {
        custom = {
          wait = { raw = "[-]", rendered = "󰥔", highlight = "RenderMarkdownTodo" },
          prio = { raw = "[!]", rendered = "󰄱", highlight = "DiagnosticError" }, -- high priority
          done = { raw = "[x]", rendered = "󰄲", highlight = "DiagnosticOk" }, -- nf-md-checkbox_marked
          yes = { raw = "[y]", rendered = "󰄲", highlight = "DiagnosticOk" }, -- nf-md-checkbox_marked
          later = { raw = "[>]", rendered = "󰒊", highlight = "DiagnosticInfo" }, -- nf-md-send
          sched = { raw = "[<]", rendered = "󰃰", highlight = "DiagnosticInfo" }, -- nf-md-calendar_clock
          cancl = { raw = "[~]", rendered = "󰂭", highlight = "Comment" },
          info = { raw = "[i]", rendered = "󰋼", highlight = "DiagnosticInfo" }, -- nf-md-information
          idea = { raw = "[I]", rendered = "󰌵", highlight = "DiagnosticWarn" }, -- nf-md-lightbulb
          pro = { raw = "[p]", rendered = "󰔓", highlight = "DiagnosticOk" }, -- nf-md-thumb_up
          con = { raw = "[c]", rendered = "󰔑", highlight = "DiagnosticError" }, -- nf-md-thumb_down
          star = { raw = "[s]", rendered = "󰓎", highlight = "DiagnosticWarn" }, -- nf-md-star (asterisk * doesn't work)
          star2 = { raw = "[*]", rendered = "󰓎", highlight = "DiagnosticWarn" }, -- nf-md-star (asterisk * doesn't work)
          half = { raw = "[/]", rendered = "󰿦", highlight = "DiagnosticWarn" }, -- in progress, nf-md-texture_box
        },
      },
    },
    config = function(_, opts)
      require("render-markdown").setup(opts)
    end,
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
      workspaces = workspaces,

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
        -- use markdown.nvim instead for these
        checkboxes = {},
        bullets = {},
        external_link_icon = {},
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
}

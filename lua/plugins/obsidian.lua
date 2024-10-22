local function get_obsidian_workspaces()
  local workspaces = {}
  local home = os.getenv("HOME")
  local vaults_dir = home .. "/Documents/Vaults/*"
  local items = vim.fn.glob(vaults_dir, false, 1)

  for _, filepath in ipairs(items) do
    if vim.fn.isdirectory(filepath) == 1 then
      local name = vim.fn.fnamemodify(filepath, ":t")
      local item = { path = filepath, name = name }

      -- Load overrides file if it exists
      local overrides_file = filepath .. "/.obsidian-nvim-overrides.lua"
      if vim.uv.fs_stat(overrides_file) then
        local oldpath = package.path
        package.path = filepath .. "/.?.lua;" .. oldpath
        item.overrides = require("obsidian-nvim-overrides")
        package.path = oldpath
      end

      table.insert(workspaces, item)
    end
  end

  return workspaces
end

return {
  { -- obsidian
    -- :ObsidianOpen - open in obsidian app
    -- :ObsidianBacklinks
    -- :ObsidianSearch
    -- :ObsidianFollowLink
    -- :ObsidianQuickSwitch
    "epwalsh/obsidian.nvim",
    vscode = false,
    lazy = true,
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = {
      "ObsidianToday",
      "ObsidianTomorrow",
      "ObsidianSearch",
      "ObsidianNew",
      "ObsidianNewFromTemplate",
      "ObsidianWorkspace",
    },
    keys = {
      {
        "<leader>mw",
        "<cmd>ObsidianWorkspace<cr>",
        desc = "Obsidian: open workspace...",
      },
      {
        "<leader>mn",
        "<cmd>ObsidianNew<cr>",
        desc = "Obsidian: create new file...",
      },
    },
    opts = {
      workspaces = get_obsidian_workspaces(),

      notes_subdir = "Pages",

      -- options: current_dir (default), notes_subdir
      new_notes_location = "current_dir",

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

      note_frontmatter_func = function(note)
        local out = {}

        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end

        -- Add createdAt: in the frontmatter
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

        return out
      end,

      note_id_func = function(title)
        -- Default behaviour: return something like "124351678905-XYZX"
        if title then
          return title
        end

        return "Untitled-" .. tostring(os.time())
      end,

      templates = {
        folder = "Templates",
      },

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
            "<leader>mt",
            "<cmd>ObsidianTemplate<CR>",
            { buffer = event.buf, desc = "Obsidian: Template..." }
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
  },
}

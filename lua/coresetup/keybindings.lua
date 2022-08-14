local function get_default_mappings()
  local mappings = {
    default = {
      n = {
        ["-"] = { "<cmd>NvimTreeFindFile<cr>", "Open file explorer" },
        ["<c-p>"] = { "<cmd>Telescope find_files<cr>", "Open file…" },

        -- lsp
        ["gd"] = { "<cmd>Telescope lsp_definitions<cr>", "Definitions (lsp)…" },
        ["gr"] = { "<cmd>Telescope lsp_references<cr>", "References (lsp)…" },
        ["gh"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Show hover" },
        ["gD"] = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Declaration (lsp)…" },
        ["gi"] = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Implementation (lsp)…" },
        ["K"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Show hover" },

        -- [s] settings
        ["<leader>s"] = { name = "[s]ettings…" },
        ["<leader>s,"] = {
          "<cmd>vsplit " .. vim.fn.stdpath("config") .. "/init.lua<cr>",
          "Edit Neovim settings",
        },
        ["<leader>sc"] = { "<cmd>Telescope colorscheme<cr>", "Choose [c]olorscheme…" },
        ["<leader>sk"] = {
          "<cmd>vsplit " .. vim.fn.stdpath("config") .. "/lua/coresccup/keybindings.lua<cr>",
          "Edit [k]eybindings",
        },
        ["<leader>sr"] = {
          "<cmd>lua require('core.utils').reload()<cr>",
          "Reload config",
        },
        ["<leader>si"] = {
          "<cmd>lua require('core.utils').reload()<cr>:PackerInstall<cr>",
          "Packer: [i]nstall new packages",
        },
        ["<leader>su"] = {
          "<cmd>lua require('core.utils').reload()<cr>:PackerSync<cr>",
          "Packer: [u]pdate packages",
        },

        -- Leader: [c] code
        ["<leader>c"] = { name = "[c]ode…" },
        ["<leader>ca"] = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "[a]ctions…" },
        ["<leader>cr"] = { "<cmd>lua vim.lsp.buf.rename()<cr>", "[r]ename symbol…" },
        ["<leader>cd"] = { "<cmd>Telescope diagnostics<CR>", "Show [d]iagnostics" },
        ["<leader>cf"] = { "<cmd>lua vim.lsp.buf.formatting_seq_sync()<cr>", "[f]ormat via LSP" },

        -- [,] others
        ["<leader>,"] = { name = "experimental…" },
        ["<leader>,p"] = { "<cmd>StartupTime --tries 12<cr>", "Profile startup time" },
      },
      nv = {
        ["gl"] = { "<cmd>HopLine<cr>", "Go to line" },
        ["gw"] = { "<cmd>HopWord<cr>", "Go to word" },
      },
      v = {},
      ctrl = {
        ["<c-h>"] = { [[<cmd>wincmd W | set winwidth=80 | set winwidth=20<cr>]], "Focus previous pane" },
        ["<c-n>"] = { [[<cmd>wincmd w | set winwidth=80 | set winwidth=20<cr>]], "Focus next pane" },
        ["<c-s>"] = { [[<cmd>w<cr><esc>]], "Save file" },
      },
    },
  }
  return mappings
end

local function apply_mappings(key)
  local which_key = require("which-key")

  local mappings = get_default_mappings()[key]
  if not mappings then
    return
  end

  which_key.register(mappings.n or {}, { mode = "n" })
  which_key.register(mappings.v or {}, { mode = "v" })
  which_key.register(mappings.nv or {}, { mode = "n" })
  which_key.register(mappings.nv or {}, { mode = "v" })
  which_key.register(mappings.ctrl or {}, { mode = "i" })
  which_key.register(mappings.ctrl or {}, { mode = "t" })
  which_key.register(mappings.ctrl or {}, { mode = "n" })
  which_key.register(mappings.ctrl or {}, { mode = "v" })
end

local function setup()
  apply_mappings("default")
end

return { setup = setup, apply_mappings = apply_mappings }

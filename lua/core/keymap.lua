local function get_default_mappings()
  local features = BaseConfig.features

  local mappings = {
    -- Normal mappings, but bypassing which-key
    n2 = {
      -- Open all folds (recursive). Pressing `zO` in an already-open fold won't
      -- unfold all descendants, but pressing `zc` before that will force it.
      ["zO"] = { "zczO" },

      -- Close all folds (recursive). Also do `zx`, which with treesitter's folding
      -- implementation, will "reset" folds (usually needed for Markdown).
      ["zM"] = { "zxzM" },
    },
    n = {
      -- Open sidebar. Inspired by vim-vinegar.
      ["-"] = features.file_explorer and { "<cmd>NvimTreeFindFile<cr>", "Open file explorer" } or nil,

      ["s"] = features.hop and { "<cmd>HopChar1MW<cr>", "Go to character…" } or nil,
      -- Use "123," to go to line 123. This just makes things easier to press

      [","] = { "G", "Go to line" },
      ["+"] = { "za", "Toggle fold under cursor" },
      ["<del>"] = { "<cmd>bd!<cr>", "Destroy this buffer" },
      ["<s-del>"] = { "<cmd>w<cr>:bd<cr>", "Save and close" },
      ["<c-p>"] = { "<cmd>lua require('core.actions').open_file_picker()<cr>", "Open file…" },
      ["gs"] = { ":%s~~", "Replace with…" },
      ["ga"] = features.hop and { "<cmd>HopChar2MW<cr>", "Go to pattern (2 chars)…" } or nil,
      ["]c"] = { "<cmd>cnext<CR>", "Next quickfix item" },
      ["[c"] = { "<cmd>cprev<CR>", "Prev quickfix item" },
      ["]g"] = features.gitsigns and {
        "<cmd>lua require('gitsigns').next_hunk()<cr>",
        "Next Git change",
      } or nil,
      ["[g"] = features.gitsigns and {
        "<cmd>lua require('gitsigns').prev_hunk()<cr>",
        "Previous Git change",
      } or nil,

      -- lsp
      ["gd"] = features.lsp and { "<cmd>Telescope lsp_definitions<cr>", "Definitions (lsp)…" } or nil,
      ["gr"] = features.lsp and { "<cmd>Telescope lsp_references<cr>", "References (lsp)…" } or nil,
      ["gR"] = features.lsp and { "<cmd>lua vim.lsp.buf.references()<cr>", "References to this file…" } or nil,
      ["gh"] = features.lsp and { "<cmd>lua vim.lsp.buf.hover()<cr>", "Show hover" } or nil,
      ["gD"] = features.lsp and { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Declaration (lsp)…" } or nil,
      ["gi"] = features.lsp and { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Implementation (lsp)…" } or nil,
      ["K"] = features.lsp and { "<cmd>lua vim.lsp.buf.hover()<cr>", "Show hover" } or nil,

      -- buffer
      ["gb"] = { "<cmd>BufferLineCycleNext<cr>", "Buffer: next" },
      ["gB"] = { "<cmd>BufferLineCyclePrev<cr>", "Buffer: previous" },
      ["<tab>"] = { "<cmd>BufferLineCycleNext<cr>", "Buffer: next" },
      ["<s-tab>"] = { "<cmd>BufferLineCyclePrev<cr>", "Buffer: previous" },

      -- others
      ["<leader>*"] = { ":GG <c-r><c-w><cr>", " Search for word in cursor…" },
      ["<leader>."] = { "<cmd>lua require('core.actions').open_terminal()<cr>", " Open terminal" },
      ["<leader>/"] = { "<cmd>HopPatternMW<cr>", "Find pattern…" } or nil,

      -- Leader: [f] file
      ["<leader>f"] = { name = " File…" },
      ["<leader>fw"] = { "<cmd>noa w<cr>", " Save without formatting" },
      ["<leader>fr"] = { "<cmd>e!<cr>", " Revert changes in file" },
      ["<leader>fy"] = { [[:let @+=@% | echo '→ ' . @%<cr>]], " Copy current path" },
      ["<leader>fY"] = { name = " Copy options…" },
      ["<leader>fYp"] = { [[:let @+=expand('%:p') | echo '→ ' . expand('%:p')<cr>]], " Copy full path" },
      ["<leader>fYt"] = { [[:let @+=expand('%:t') | echo '→ ' . expand('%:t')<cr>]], " Copy basename" },

      -- Leader: [g] git
      ["<leader>g"] = (features.github_fugitive or features.neogit) and { name = " Git…" } or nil,
      ["<leader>gs"] = features.neogit and { "<cmd>Neogit<cr>", " Git status…" } or nil,
      ["<leader>gc"] = features.neogit and { "<cmd>Neogit commit<cr>", " Git commit…" } or nil,
      ["<leader>gd"] = features.github_fugitive and { "<cmd>Gitsigns diffthis HEAD<cr>", " Diff…" } or nil,
      ["<leader>gb"] = features.github_fugitive and { "<cmd>Git blame<cr>", " Blame" } or nil,
      ["<leader>gy"] = features.github_fugitive and { "<cmd>GBrowse!<cr>", " Copy GitHub URL" } or nil,
      ["<leader>gY"] = features.github_fugitive and { "<cmd>GBrowse<cr>", " Open in GitHub" } or nil,

      -- Leader: [p] pick
      ["<leader>p"] = { name = " Pick…" },
      ["<leader>ph"] = { "<cmd>Telescope help_tags<cr>", " Vim help…" },
      ["<leader>p<space>"] = { "<cmd>Telescope resume<cr>", "· Resume last search…" },
      ["<leader>pf"] = { "<cmd>Telescope file_browser path=%:p:h<cr>", "· Browse files…" },
      ["<leader>pb"] = { "<cmd>Telescope buffers<cr>", " List buffers…" },
      ["<leader>p/"] = { "<cmd>Telescope live_grep<cr>", " Find in files (telescope)…" },
      ["<leader>p*"] = { "<cmd>Telescope grep_string<cr>", " Find current word (telescope)…" },
      -- ["<leader>pf"] = { "<cmd>lua require('core.actions').open_file_picker()<cr>", "Open [f]ile…" },
      ["<leader>pz"] = {
        "<cmd>lua require('telescope').extensions.z.list({})<cr>",
        " Switch to dir [z]…",
      },
      ["<leader>pw"] = features.workspaces and {
        "<cmd>WorkspacesOpen<cr>",
        " Open workspace…",
      } or nil,
      ["<leader>pr"] = {
        "<cmd>Telescope oldfiles only_cwd=true<cr>",
        " Open recent file…",
      },
      ["<leader>pg"] = { [[<cmd>Telescope git_status<cr>]], " Files changed in Git…" },
      -- ["<leader>ps"] = { "<cmd>Telescope lsp_document_symbols<cr>", "Show [s]ymbols…" },
      ["<leader>ps*"] = {
        [[<cmd>lua require('spectre').open_visual({ select_word = true })<cr>]],
        "Find current word (spectre)…",
      },
      ["<leader>ps/"] = {
        [[<cmd>lua require('spectre').open({ is_insert_mode = true })<cr>]],
        "Find in files ([s]pectre)…",
      },
      -- ["<leader>pW"] = { name = "[w]orkspaces…" },
      ["<leader>pWa"] = features.workspaces and {
        "<cmd>WorkspacesAdd<cr>",
        "Workspace: [a]dd this folder",
      } or nil,
      ["<leader>pWd"] = features.workspaces and {
        "<cmd>WorkspacesRemove<cr>",
        "Workspace: [d]dd this folder",
      } or nil,

      -- Leader: [o] toggle
      ["<leader>o"] = { name = " Toggle…" },
      ["<leader>ow"] = { "<cmd>set wrap!<cr>", " Toggle word wrap" },
      ["<leader>os"] = { "<cmd>set spell!<cr>", " Toggle Spell check" },
      ["<leader>on"] = { "<cmd>set number!<cr>", " Toggle line numbers" },
      ["<leader>or"] = { "<cmd>set relativenumber!<cr>", " Toggle relative line number" },
      ["<leader>ob"] = {
        "<cmd>lua require('core.theme-utils').toggle_theme()<cr>",
        " Toggle light/dark theme",
      },
      ["<leader>oC"] = {
        "<cmd>lua vim.o.clipboard = vim.o.clipboard == 'unnamedplus' and '' or 'unnamedplus'<cr>",
        "· Toggle system clipboard",
      },
      ["<leader>oB"] = {
        "<cmd>lua vim.o.background = vim.o.background == 'light' and 'dark' or 'light'<cr>",
        " Toggle light/dark background",
      },
      ["<leader>oc"] = {
        "<cmd>lua vim.o.conceallevel = vim.o.conceallevel == 2 and 0 or 2<cr>",
        " Toggle conceal",
      },

      -- Leader: [od] diagnostic
      ["<leader>od"] = features.lsp and { name = " Diagnostic…" } or nil,
      ["<leader>odd"] = features.lsp and {
        "<cmd>lua vim.diagnostic.disable()<cr>",
        "[d]isable diagnostics",
      } or nil,
      ["<leader>ode"] = features.lsp and {
        "<cmd>lua vim.diagnostic.enable()<cr>",
        "[e]nable diagnostics",
      } or nil,
      ["<leader>odh"] = features.lsp and { "<cmd>lua vim.diagnostic.hide()<cr>", "[h]ide diagnostics" } or nil,
      ["<leader>ods"] = features.lsp and { "<cmd>lua vim.diagnostic.show()<cr>", "[s]how diagnostics" } or nil,

      -- [s] settings
      ["<leader>s"] = { name = " Settings…" },
      ["<leader>s,"] = {
        "<cmd>vsplit " .. vim.fn.stdpath("config") .. "/init.lua<cr>",
        " Edit Neovim settings",
      },
      ["<leader>sc"] = {
        "<cmd>lua require('core.actions').open_colorscheme_picker()<cr>",
        " Choose colorscheme…",
      },
      ["<leader>sk"] = {
        "<cmd>vsplit " .. vim.fn.stdpath("config") .. "/lua/core/keymap.lua<cr>",
        " Edit keymap",
      },
      ["<leader>sr"] = {
        "<cmd>lua require('core.reload-utils').reload()<cr>",
        " Reload config",
      },
      ["<leader>sU"] = {
        "<cmd>lua require('core.update-utils').update()<cr>",
        "· Pull vim settings",
      },
      ["<leader>su"] = {
        "<cmd>lua require('core.reload-utils').reload()<cr>:Lazy sync<cr>",
        " Lazy: Update packages",
      },
      ["<leader>sp"] = {
        "<cmd>Lazy profile<cr>",
        " Lazy: Profile packages",
      },

      -- Leader: [c] code
      ["<leader>c"] = features.lsp and { name = " Code…" } or nil,
      ["<leader>ci"] = features.lsp and features.lsp_installer and {
        "<cmd>Mason<cr>",
        " Install tool…",
      } or nil,
      ["<leader>ca"] = features.lsp and {
        "<cmd>lua vim.lsp.buf.code_action()<cr>",
        " Code actions…",
      } or nil,
      ["<leader>cr"] = features.lsp and {
        "<cmd>lua vim.lsp.buf.rename()<cr>",
        " Rename symbol…",
      } or nil,
      ["<leader>cd"] = features.lsp and { "<cmd>Trouble<CR>", " Show diagnostics…" } or nil,
      ["<leader>cf"] = features.lsp and {
        "<cmd>lua vim.lsp.buf.format()<cr>",
        " Format via LSP",
      } or nil,

      -- Leader: [b] buffers
      ["<leader>b"] = { name = " Buffers…" },
      ["<leader>bp"] = { "<cmd>BufferLinePick<cr>", " Pick…" },
      ["<leader>b<space>"] = { "<cmd>BufferLineTogglePin<cr>", " Toggle pin" },
      ["<leader>b."] = { "<cmd>BufferLineCloseRight<cr>", " Close to the right" },
      ["<leader>b,"] = { "<cmd>BufferLineCloseLeft<cr>", " Close to the left" },

      -- Leader: [x] exit
      ["<leader>x"] = { name = " Exit…" },
      ["<leader>xz"] = { "<cmd>cq<cr>", " Exit Neovim" },
      ["<leader>xd"] = { "<cmd>bd!<cr>", " Destroy [del]" },
      ["<leader>xc"] = { "<c-w>q", " Close" },
      ["<leader>xv"] = { "<cmd>w<cr>:bd<cr>", " Destroy and save [shift-del]" },
      ["<leader>xa"] = features.welcome_screen and {
        "<cmd>silent %bd! | Alpha<cr>",
        " Close all",
      } or {
        "<cmd>silent %bd!<cr>",
        " Close all",
      },
      ["<leader>xo"] = {
        "<cmd>lua require('close_buffers').delete({ type = 'hidden' })<cr>",
        " Close hidden tabs",
      },
      ["<leader>xO"] = {
        "<cmd>lua require('close_buffers').delete({ type = 'hidden', force = true })<cr>",
        " Close hidden tabs (force)",
      },

      -- [,] others
      ["<leader>,"] = { name = " Experimental…" },
      ["<leader>,e"] = { ":lua vim.notify(vim.inspect())<left><left>", "Evaluate lua line…" },
      ["<leader>,s"] = { "<cmd>split ~/.scratchpad<cr><C-w>H", "Open scratchpad" },
      ["<leader>,p"] = { "<cmd>StartupTime<cr>", "Profile startup time" },
      ["<leader>,h"] = { "<cmd>TSHighlightCapturesUnderCursor<cr>", "Show highlight info at cursor" },
      ["<leader><Space>"] = { "<cmd>lua require('core.actions').show_keymaps()<cr>", "Show keybindings…" },
    },
    t = {
      ["<c-x>"] = { "<c-\\><c-n>" }, -- escape
    },
    nv = {
      ["gl"] = features.hop and { "<cmd>HopLine<cr>", "Go to line" } or nil,
      ["gL"] = features.hop and { "<cmd>HopLineMW<cr>", "Go to line (all windows)…" } or nil,
      ["gw"] = features.hop and { "<cmd>HopWord<cr>", "Go to word" } or nil,
      ["gW"] = features.hop and { "<cmd>HopWordMW<cr>", "Go to word (all windows)…" } or nil,
      ["gp"] = features.hop and { "<cmd>HopPattern<cr>", "Find pattern…" } or nil,
      ["gP"] = features.hop and { "<cmd>HopPatternMW<cr>", "Find pattern (all windows)…" } or nil,
    },
    i = {
      ["<s-del>"] = { "<cmd>w<cr>:bd<cr>", "Save and close" },
    },
    v = {
      -- Better indenting
      ["<"] = { "<gv", "Reduce indent" },
      [">"] = { ">gv", "Increase indent" },

      -- Move selected line / block of text in visual mode
      -- Taken from nvchad. I don't like how it interferes with J
      -- ["K"] = { ":move '<-2<CR>gv-gv", "Move line down" },
      -- ["J"] = { ":move '>+1<CR>gv-gv", "Mode line up" },

      ["gs"] = { ":s~~", "Replace with..." },
      ["<leader>ca"] = features.lsp and {
        ":'<,'>lua vim.lsp.buf.range_code_action()<cr>",
        " Code actions…",
      } or nil,
      ["<leader>g"] = features.github_fugitive and { name = "Git…" } or nil,
      ["<leader>gy"] = features.github_fugitive and { ":GBrowse!<cr>", " Copy GitHub URL" } or nil,
      ["<leader>gY"] = features.github_fugitive and { ":GBrowse<cr>", " Open in GitHub" } or nil,
      ["<leader>r"] = features.refactoring and { name = "Refactoring…" },
      ["<leader>rr"] = features.refactoring and {
        ":lua require('telescope').extensions.refactoring.refactors()<cr>",
        "· Refactor…",
      } or nil,
      ["<leader>ps*"] = {
        [[<cmd>lua require('spectre').open_visual()<cr>]],
        "Find current word (spectre)…",
      },
    },
    ctrl = {
      ["<c-h>"] = { [[<cmd>lua require('core.pane-utils').next_pane()<cr>]], "Focus previous pane" },
      ["<c-n>"] = { [[<cmd>lua require('core.pane-utils').prev_pane()<cr>]], "Focus next pane" },
      ["<c-s>"] = { [[<cmd>w<cr><esc>]], "Save file" },
    },
  }
  return mappings
end

---@class RegisterOptions
---@field mode string

---@param mappings any
---@param options RegisterOptions
local function register_nvim(mappings, options)
  for key, value in pairs(mappings) do
    if value ~= nil then
      pcall(function()
        vim.api.nvim_set_keymap(options.mode, key, value[1], {
          noremap = true,
          silent = true,
          desc = value[2] or "",
        })
      end)
    end
  end
end

local function apply_mappings(mappings)
  local has, which_key = pcall(require, "which-key")
  if not has then
    return
  end

  which_key.register(mappings.nv, { mode = "n" })
  which_key.register(mappings.nv, { mode = "v" })
  which_key.register(mappings.i, { mode = "i" })
  which_key.register(mappings.n, { mode = "n" })
  which_key.register(mappings.ctrl, { mode = "i" })
  which_key.register(mappings.ctrl, { mode = "t" })
  which_key.register(mappings.ctrl, { mode = "n" })
  which_key.register(mappings.ctrl, { mode = "v" })

  -- Which-Key doesn't seem to handle terminal mappings
  register_nvim(mappings.t, { mode = "t" })
  register_nvim(mappings.v, { mode = "v" })

  -- idk, these key mappings don't like which-key
  register_nvim(mappings.n2, { mode = "n" })
end

local function setup()
  local mappings = get_default_mappings()
  apply_mappings(mappings)
end

return { setup = setup }

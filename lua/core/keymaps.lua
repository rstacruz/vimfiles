local function has_require(mod)
  return pcall(require, mod)
end

local wk = require("which-key")
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Keymap: general
map("n", [[gs]], [[:%s~~]], opts)
map("v", [[gs]], [[:s~~]], opts)
map("n", [[+]], [[za]], opts)
map("n", [[<del>]], [[:bwipe!<cr>]], opts)
map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)

map("v", "<leader>*", ":silent! Glcd | lua require('spectre').open_visual()<cr>", opts)

-- Keymap: terminal
map("t", [[<esc>]], [[<c-\><c-n>]], opts) -- Terminal esc
map("t", [[<c-n>]], [[<c-\><c-n><c-w>w]], opts) -- Terminal focus next
map("t", [[<c-h>]], [[<c-\><c-n><c-w>W]], opts) -- Terminal focus prev

-- Keymap: ctrl
map("n", [[<c-h>]], [[<c-w>W]], opts) -- Focus prev
map("i", [[<c-h>]], [[<esc><c-w>W]], opts) -- Focus prev (ins)
map("n", [[<c-n>]], [[<c-w>w]], opts) -- Focus next (ins)
map("i", [[<c-n>]], [[<esc><c-w>w]], opts) -- Focus next (ins)
map("n", [[<c-pageup>]], [[<c-w>W]], opts) -- Focus prev
map("i", [[<c-pageup>]], [[<esc><c-w>W]], opts) -- Focus prev (ins)
map("n", [[<c-pagedown>]], [[<c-w>w]], opts) -- Focus next (ins)
map("i", [[<c-pagedown>]], [[<esc><c-w>w]], opts) -- Focus next (ins)
map("n", [[<c-s>]], [[:w<cr>]], opts) -- Save
map("i", [[<c-s>]], [[<esc>:w<cr>]], opts) -- Save (ins)
map("v", [[<c-c>]], [["+y]], opts) -- Copy
map("i", [[<c-v>]], [[<esc>:set paste<cr>a<c-r>+<esc>:set nopaste<cr>a]], opts) -- Paste
if has_require("telescope") then
  map("n", [[<c-p>]], [[:silent! Glcd<cr>:Telescope find_files<cr>]], opts)
end
if has_require("nvim-tree") then
  map("n", [[<c-b>]], [[:NvimTreeToggle<cr>]], opts) -- Toggle sidebar
  map("n", [[-]], [[:silent! Glcd | :NvimTreeFindFile<cr>]], opts)
elseif has_require("neo-tree") then
  map("n", [[<c-b>]], [[:Neotree<cr>]], opts) -- Toggle sidebar
  map("n", [[-]], [[:silent! Glcd | :Neotree reveal<cr>]], opts)
end
if has_require("toggleterm") then
  map("n", [[<c-j>]], [[:ToggleTerm<cr>]], opts) -- Toggle terminal
  map("t", [[<esc><esc>]], [[<c-\><c-n>:ToggleTerm<cr>]], opts) -- Terminal esc
  -- map("t", [[<c-j>]], [[<c-\><c-n>:ToggleTerm<cr>]], opts) -- Toggle terminal
  -- map("t", [[<c-k>]], [[<c-\><c-n>:ToggleTerm<cr>]], opts) -- Toggle terminal
end

-- Keymap: general
wk.register({
  -- Buffer
  gb = { ":bnext<cr>", "Buffer: next" },
  gB = { ":bprev<cr>", "Buffer: previous" },
  ["<tab>"] = { ":bnext<cr>", "Buffer: next" },
  ["<s-tab>"] = { ":bprev<cr>", "Buffer: previous" },

  -- lsp
  gd = { ":Telescope lsp_definitions<cr>", "Definitions (lsp)..." },
  gr = { ":Telescope lsp_references<cr>", "References (lsp)..." },
  gh = { ":lua vim.lsp.buf.hover()<cr>", "Declaration (lsp)..." },
  gD = { ":lua vim.lsp.buf.declaration()<cr>", "Declaration (lsp)..." },
  gi = { ":lua vim.lsp.buf.implementation()<cr>", "Implementation (lsp)..." },
  ["<c-l>"] = { ":HopLine<cr>", "Hop to line" },
  ["<c-g>"] = { ":HopWord<cr>", "Hop to word" },
  ["gl"] = { ":HopLine<cr>", "Hop to line" },
  ["gw"] = { ":HopWord<cr>", "Hop to word" },

  ["<F1>"] = { "<cmd>lua require('core.actions').show_reference()<cr>", "Show reference" },
})

-- Keymap: cr
wk.register({
  ["<left>"] = { "<c-w>h", "Focus left" },
  ["<right>"] = { "<c-w>l", "Focus right" },
  ["<down>"] = { "<c-w>j", "Focus down" },
  ["<up>"] = { "<c-w>k", "Focus up" },
  ["1"] = { "<c-w>t", "Focus pane 1" },
  ["2"] = { ":2wincmd w<cr>", "Focus pane 2" },
  ["3"] = { ":3wincmd w<cr>", "Focus pane 3" },
  ["4"] = { ":4wincmd w<cr>", "Focus pane 4" },
  ["5"] = { ":5wincmd w<cr>", "Focus pane 5" },
  ["6"] = { ":6wincmd w<cr>", "Focus pane 6" },
  ["7"] = { ":7wincmd w<cr>", "Focus pane 7" },
  ["8"] = { ":8wincmd w<cr>", "Focus pane 8" },
  ["0"] = { "<c-w>b", "Focus last pane" },
  -- ["<Esc>"] = { ":FloatermToggle<cr>", "Toggle terminal" },
  -- t = { ":tab split<cr>", "New tab" },
}, { prefix = "<cr>" })

-- Keymap: leader
wk.register({
  ["."] = { ":vs<cr>:term fish<cr>", "Open terminal in buffer" },
  ["*"] = { ":silent! Glcd | lua require('spectre').open_visual({ select_word = true })<cr>", "Search this word" },
  ["?"] = { "<cmd>lua require('core.actions').show_reference()<cr>", "Show reference" },
  [","] = {
    name = "Experimental...",
    n = { ":noh<cr>", "Remove search highlighting" },
    g = { [[:lua require('core.actions').telescope_grep()<cr>]], "Search (telescope)..." },
    ["*"] = { ":GG <c-r><c-w><cr>", "Search from cursor (GG)..." },
  },
  w = {
    name = "[w]indow...",
    H = { "<c-w>H", "Move window left ←" },
    J = { "<c-w>J", "Move window down ↓" },
    K = { "<c-w>K", "Move window up ↑" },
    L = { "<c-w>L", "Move window right →" },
    h = { "<c-w>h", "Focus window left ←" },
    j = { "<c-w>j", "Focus window down ↓" },
    k = { "<c-w>k", "Focus window up ↑" },
    l = { "<c-w>l", "Focus window right →" },
    s = { "<c-w>s", "Split horizontal" },
    v = { "<c-w>v", "Split vertical" },
    q = { "<c-w>q", "Close window" },
    t = { "<cmd>tab split<cr>", "New tab" },
  },
  p = {
    name = "[p]ick...",
    g = { [[:silent! Glcd | lua require('spectre').open({ is_insert_mode = true })<cr>]], "Find in files..." },
    b = { "<cmd>Telescope buffers<cr>", "List buffers..." },
    m = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "Show bookmarks..." },
    w = { "<cmd>Telescope workspaces<cr>", "Open workspace..." },
    r = { "<cmd>lua require('telescope.builtin').oldfiles({only_cwd=true})<cr>", "Open recent file..." },
    s = { "<cmd>Telescope lsp_workspace_symbols<cr>", "Show symbols..." },
    W = {
      name = "[w]orkspaces...",
      a = { "<cmd>WorkspacesAdd<cr>", "Workspace: [a]dd this folder" },
    },
  },
  m = {
    name = "[m]arks...",
    a = { "<cmd>lua require('harpoon.mark').add_file()<cr>", "Bookmark this file" },
    ["."] = { "<cmd>lua require('harpoon.cmd-ui').toggle_quick_menu()<cr>", "Bookmark commands..." },
  },
  x = {
    name = "E[x]it...",
    o = { ":%bd!|e#|bd#<cr>", "Close all buffers" },
    r = {
      ":%bd!|e#|bd#<cr>:lua require('telescope.builtin').oldfiles({only_cwd=true})<cr>",
      "Close all and show recent",
    },
    x = { ":cq<cr>", "Exit" },
  },
  f = {
    name = "[f]ile...",
    w = { ":w<cr>", "Save file" },
    s = { ":noa w<cr>", "[s]ave without formatting" },
    r = { ":e!<cr>", "[r]evert changes in file" },
    -- g = { ":lua vim.ui.input('Find:', function(val) vim.cmd(':GG ' .. val) end)<cr>", "Find in project..." },
    y = { [[:let @+=@% | echo '→ ' . @%<cr>]], "Cop[y] current path" },
    Y = { [[:let @+=expand('%:p') | echo '→ ' . expand('%:p')<cr>]], "Cop[Y] full path" },
  },
  s = {
    name = "[s]ettings...",
    [","] = { "<cmd>vsplit ~/.config/nvim/init.lua<cr>", "Edit Vim settings" },
    k = { "<cmd>vsplit ~/.config/nvim/lua/core/keymaps.lua<cr>", "Edit [k]eybindings" },
    r = { "<cmd>lua require('core.utils').reload()<cr>", "[r]eload Vim config" },
    c = { "<cmd>Telescope colorscheme<cr>", "Choose [c]olour scheme" },
    u = { "<cmd>lua require('core.utils').reload()<cr>:PaqUpdate<cr>", "[u]pdate plugins" },
    P = { "<cmd>StartupTime<cr>", "[P]rofile startup time" },
    p = {
      name = "Packer...",
      c = { ":lua require('core.utils').reload()<cr>:PackerClean<cr>", "Packer: [c]lean unused packages" },
      i = { ":lua require('core.utils').reload()<cr>:PackerInstall<cr>", "Packer: [i]nstall new packages" },
      s = { ":lua require('core.utils').reload()<cr>:PackerSync<cr>", "Packer: [s]ync packages" },
    }
  },
  g = {
    name = "[g]it...",
    s = { ":Git<cr>", "Git status" },
    a = { ":silent! Glcd | Git add -u . | Git commit -v<cr>", "Add & commit" },
    A = { ":silent! Glcd | Git add -u . | Git commit --amend -v<cr>", "Add & amend" },
    h = { ":GBrowse<cr>", "Open in GitHub" },
    c = { ":Git commit -v<cr>", "Commit" },
    b = { ":Git blame<cr>", "Open file blame" },
    p = { ":silent! Glcd | lua require('core.actions').open_floating_cmd('git push')<cr>", "Push" },
    P = { ":silent! Glcd | lua require('core.actions').open_floating_cmd('git push -f')<cr>", "Push (force)" },
    t = { ":silent! Glcd | lua require ('core.actions').open_tig()<cr>", "Tig..." },
    r = {
      name = "Pull request...",
      c = { ":silent! Glcd | !gh pr create --web<cr>", "Create PR (web)" },
      v = { ":silent! Glcd | !gh pr view --web<cr>", "View PR (web)" },
    },
  },
  t = {
    name = "[t]erminal...",
    -- s = { ":ToggleTerm direction=vertical<cr>", "Open terminal to side" },
    -- f = { ":ToggleTerm direction=float<cr>", "Open terminal floating" },
    -- v = { ":ToggleTerm direction=horizontal<cr>", "Open terminal to bottom" },
    -- n = { ":ToggleTerm direction=tab<cr>", "Open terminal to tab" },
    ["."] = { ":ToggleTerm<cr>", "Toggle terminal" },
    a = { ":1ToggleTerm<cr>", "Terminal 1" },
    r = { ":2ToggleTerm<cr>", "Terminal 2" },
    s = { ":3ToggleTerm<cr>", "Terminal 3" },
    t = { ":4ToggleTerm<cr>", "Terminal 4" },
  },
  c = {
    name = "[c]ode...",
    a = { ":lua vim.lsp.buf.code_action()<cr>", "Actions" },
    r = { ":lua vim.lsp.buf.rename()<cr>", "Rename symbol..." },
    d = { ":Telescope diagnostics<CR>", "Diagnostics" },
    f = { ":lua vim.lsp.buf.formatting_seq_sync()<cr>", "Format (via LSP)" },
  },
  o = {
    name = "T[o]ggle...",
    d = { "<cmd>lua vim.o.winwidth = vim.o.winwidth == 85 and 45 or 85<cr>100<c-w><", "Toggle wi[d]e" },
    w = { ":set wrap!<cr>", "Toggle [w]ord wrap" },
    s = { ":set spell!<cr>", "Toggle [s]pell check" },
    n = { ":set number!<cr>", "Toggle line [n]umber" },
    r = { ":set relativenumber!<cr>", "Toggle [r]elative line number" },
    f = vim.fn.has("g:neovide") and { ":let g:neovide_fullscreen=!g:neovide_fullscreen<cr>", "Toggle [f]ullscreen" }
        or {},
    b = { ":lua Theme:toggle_theme()<cr>", "Toggle light/dark theme" },
    B = {
      ":lua vim.o.background = vim.o.background == 'light' and 'dark' or 'light'<cr>",
      "Toggle light/dark [B]ackground",
    },
    c = { ":lua vim.o.conceallevel = vim.o.conceallevel == 2 and 0 or 2<cr>", "Toggle [c]onceal" },
  },
}, { prefix = "<Leader>" })

-- localleader: lua
map("n", [[<localleader>s]], [[:w<cr>:luafile %<cr>]], opts)

-- Unimpaired
map("n", [[co]], [[<leader>o]], { silent = true })
map("n", [[yo]], [[<leader>o]], { silent = true })

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
map("n", [[<bs>]], [[:q<cr>]], opts)
map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)

-- Keymap: terminal
map("t", [[<esc>]], [[<c-\><c-n>]], opts) -- Terminal esc
map("t", [[<c-n>]], [[<c-\><c-n><c-w>w]], opts) -- Terminal focus next
map("t", [[<c-h>]], [[<c-\><c-n><c-w>W]], opts) -- Terminal focus prev

-- Keymap: ctrl
map("n", [[<c-h>]], [[<c-w>W]], opts) -- Focus prev
map("i", [[<c-h>]], [[<esc><c-w>W]], opts) -- Focus prev (ins)
map("n", [[<c-n>]], [[<c-w>w]], opts) -- Focus next (ins)
map("i", [[<c-n>]], [[<esc><c-w>w]], opts) -- Focus next (ins)
map("n", [[<c-s>]], [[:w<cr>]], opts) -- Save
map("i", [[<c-s>]], [[<esc>:w<cr>]], opts) -- Save (ins)
map("v", [[<c-c>]], [["+y]], opts) -- Copy
map("i", [[<c-v>]], [[<esc>:set paste<cr>a<c-r>+<esc>:set nopaste<cr>a]], opts) -- Paste
if has_require("telescope") then
  map("n", [[<c-p>]], [[:silent! Glcd<cr>:Telescope find_files<cr>]], opts)
end
if has_require("nvim-tree") then
  map("n", [[<c-b>]], [[:NvimTreeToggle<cr>]], opts) -- Toggle sidebar
  map("n", [[-]], [[:NvimTreeFindFile<cr>]], opts)
end
if has_require("toggleterm") then
  map("n", [[<c-j>]], [[:ToggleTerm<cr>]], opts) -- Toggle terminal
  map("t", [[<c-j>]], [[<c-\><c-n>:ToggleTerm<cr>]], opts) -- Toggle terminal
  map("t", [[<c-k>]], [[<c-\><c-n>:ToggleTerm<cr>]], opts) -- Toggle terminal
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
  ["<Esc>"] = { ":FloatermToggle<cr>", "Toggle terminal" },
  t = { ":tab split<cr>", "New tab" },
}, { prefix = "<cr>" })

-- Keymap: leader
wk.register({
  ["."] = { ":ToggleTerm<cr>", "Open terminal" },
  ["'"] = { ":term fish<cr>", "Open terminal in buffer" },
  [","] = { ":NvimTreeToggle<cr>", "Open sidebar" },
  ["*"] = { ":GG <c-r><c-w><cr>", "Search" },
  w = {
    name = "Window...",
    H = { "<c-w>H", "Move ←" },
    J = { "<c-w>J", "Move ↓" },
    K = { "<c-w>K", "Move ↑" },
    L = { "<c-w>L", "Move →" },
    h = { "<c-w>h", "Focus ←" },
    j = { "<c-w>j", "Focus ↓" },
    k = { "<c-w>k", "Focus ↑" },
    l = { "<c-w>l", "Focus →" },
    s = { "<c-w>s", "Split horizontal" },
    v = { "<c-w>v", "Split vertical" },
    q = { "<c-w>q", "Close" },
  },
  p = {
    name = "Pick...",
    b = { ":Telescope buffers<cr>", "Buffers" },
    r = { ":lua require('telescope.builtin').oldfiles({only_cwd=true})<cr>", "Recent files" },
    s = { ":Telescope lsp_workspace_symbols<cr>", "Symbols" },
  },
  x = {
    name = "Exit...",
    s = { ":%bd!<cr>", "Close all buffers" },
    r = { ":%bd!<cr>:lua require('telescope.builtin').oldfiles({only_cwd=true})<cr>", "Close all and show recent" },
    x = { ":cq<cr>", "Exit" },
    z = { ":lua require ('core.utils').zed()<cr>", "Switch to project..." },
  },
  f = {
    name = "File...",
    w = { ":w<cr>", "Save" },
    s = { ":noa w<cr>", "Save without formatting" },
    n = { ":noh<cr>", "Remove search highlighting" },
    r = { ":e!<cr>", "Revert" },
    f = { ":GG ", "Find in project..." },
    y = { [[:let @+=@% | echo '→ ' . @%<cr>]], "Copy current path" },
    Y = { [[:let @+=expand('%:p') | echo '→ ' . expand('%:p')<cr>]], "Copy full path" },
    ["/"] = { [[:silent! Glcd | lua require('spectre').open()<cr>]], "Search in project..." },
  },
  s = {
    name = "Settings...",
    [","] = { ":vsplit ~/.config/nvim/init.lua<cr>", "Edit Vim settings" },
    x = { ":vsplit ~/.config/nvim/init.lua<cr>", "Edit extensions" },
    k = { ":vsplit ~/.config/nvim/lua/core/keymaps.lua<cr>", "Edit keybindings" },
    r = { ":lua require('core.utils').reload()<cr>", "Reload" },
    s = { ":lua require('core.utils').reload()<cr>:PaqSync<cr>", "Sync plugins" },
    c = { ":Telescope colorscheme<cr>", "Choose colour scheme" },
    u = { ":lua require('core.utils').reload()<cr>:PaqUpdate<cr>", "Update plugins" },
    p = { ":StartupTime<cr>", "Profile startup time" },
  },
  g = {
    name = "Git...",
    s = { ":Git<cr>", "Git status" },
    a = { ":silent! Glcd | Git add -u . | Git commit -v<cr>", "Add & commit" },
    A = { ":silent! Glcd | Git add -u . | Git commit --amend -v<cr>", "Add & amend" },
    h = { ":GBrowse<cr>", "Open in GitHub" },
    c = { ":Git commit -v<cr>", "Commit" },
    b = { ":Git blame<cr>", "Open file blame" },
    p = { ":!git push<cr>", "Push" },
    P = { ":!git push -f<cr>", "Push (force)" },
    r = {
      name = "Pull request...",
      c = { ":silent! Glcd | !gh pr create --web<cr>", "Create PR (web)" },
      v = { ":silent! Glcd | !gh pr view --web<cr>", "View PR (web)" },
    },
  },
  t = {
    name = "Terminal...",
    s = { ":ToggleTerm direction=vertical<cr>", "Open terminal to side" },
    f = { ":ToggleTerm direction=float<cr>", "Open terminal floating" },
    v = { ":ToggleTerm direction=horizontal<cr>", "Open terminal to bottom" },
    n = { ":ToggleTerm direction=tab<cr>", "Open terminal to tab" },
    a = { ":1ToggleTerm<cr>", "Terminal 1" },
    z = { ":2ToggleTerm<cr>", "Terminal 2" },
    x = { ":3ToggleTerm<cr>", "Terminal 3" },
    c = { ":4ToggleTerm<cr>", "Terminal 4" },
  },
  c = {
    name = "Code (lsp)...",
    a = { ":lua vim.lsp.buf.code_action()<cr>", "Actions" },
    r = { ":lua vim.lsp.buf.rename()<cr>", "Rename symbol..." },
    d = { ":Telescope diagnostics<CR>", "Diagnostics" },
    f = { ":lua vim.lsp.buf.formatting_seq_sync()<cr>", "Format (via LSP)" },
  },
  o = {
    name = "Toggle...",
    w = { ":set wrap!<cr>", "Toggle word wrap" },
    n = { ":set number!<cr>", "Toggle line number" },
    b = { ":lua vim.o.background = vim.o.background == 'light' and 'dark' or 'light'<cr>", "Toggle light/dark" },
  },
}, { prefix = "<Leader>" })

-- localleader: lua
map("n", [[<localleader>s]], [[:w<cr>:luafile %<cr>]], opts)

-- Unimpaired
map("n", [[co]], [[<leader>o]], { silent = true })
map("n", [[yo]], [[<leader>o]], { silent = true })

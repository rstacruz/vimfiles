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
map("n", [[<del>]], [[<c-w>q]], opts)

-- Keymap: terminal
map("t", [[<esc>]], [[<c-\><c-n>]], opts) -- Terminal esc
map("t", [[<c-k>]], [[<c-\><c-n><c-w>k]], opts) -- Terminal focus up
map("t", [[<c-h>]], [[<c-\><c-n><c-w>h]], opts) -- Terminal focus left
map("t", [[<c-l>]], [[<c-\><c-n><c-w>l]], opts) -- Terminal focus right

-- Keymap: ctrl
map("n", [[<c-h>]], [[<c-w>h]], opts) -- Focus left
map("n", [[<c-l>]], [[<c-w>l]], opts) -- Focus right
map("n", [[<c-k>]], [[<c-w>k]], opts) -- Focus down
map("i", [[<c-h>]], [[<esc><c-w>h]], opts) -- Focus left (ins)
map("i", [[<c-l>]], [[<esc><c-w>l]], opts) -- Focus right (ins)
map("n", [[<c-s>]], [[:w<cr>]], opts) -- Save
map("i", [[<c-s>]], [[<esc>:w<cr>]], opts) -- Save (ins)
map("v", [[<c-c>]], [["+y]], opts) -- Copy
map("i", [[<c-v>]], [[<esc>:set paste<cr>a<c-r>+<esc>:set nopaste<cr>a]], opts) -- Paste
if has_require('telescope') then
  map("n", [[<c-p>]], [[:Glcd<cr>:Telescope find_files<cr>]], opts)
end
if has_require('nvim-tree') then
  map("n", [[<c-b>]], [[:NvimTreeToggle<cr>]], opts) -- Toggle sidebar
  map("n", [[-]], [[:NvimTreeFindFile<cr>]], opts)
end
if has_require('toggleterm') then
  map("n", [[<c-j>]], [[:ToggleTerm<cr>]], opts) -- Toggle terminal
  map("t", [[<c-j>]], [[<c-\><c-n>:ToggleTerm<cr>]], opts) -- Toggle terminal
end

-- Keymap: lsp
wk.register({
  gd = { ":Telescope lsp_definitions<cr>", "Definitions (lsp)..." },
  gr = { ":Telescope lsp_references<cr>", "References (lsp)..." },
  gD = { ":lua vim.lsp.buf.declaration()", "Declaration (lsp)..." },
  gi = { ":lua vim.lsp.buf.implementation()", "Implementation (lsp)..." },
  gw = { ":HopWord<cr>", "Hop to word" },
  gl = { ":HopLine<cr>", "Hop to line" },
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
  t = { ":tabnew<cr>", "New tab" },
}, { prefix = "<cr>" })

-- Keymap: leader
wk.register({
  ["."] = { ":term<cr>", "Open terminal here" },
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
    s = { ":Telescope lsp_workspace_symbols<cr>", "Symbols" },
  },
  x = {
    name = "Exit...",
    s = { ":SClose<cr>", "Close session" },
    x = { ":cq<cr>", "Exit" },
  },
  h = {
    name = "Hop to...",
    e = { ":HopLine<cr>", "Line" },
    i = { ":HopWord<cr>", "Word" },
    o = { ":HopChar1<cr>", "Character" },
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
  },
  [","] = {
    name = "Settings...",
    [","] = { ":tab split ~/.config/nvim/init.lua<cr>", "Edit Vim settings" },
    x = { ":tab split ~/.config/nvim/init.lua<cr>", "Edit extensions" },
    k = { ":tab split ~/.config/nvim/lua/keymaps.lua<cr>", "Edit keybindings" },
    s = { ":luafile ~/.config/nvim/init.lua<cr>:PaqSync<cr>", "Sync plugins" },
    u = { ":luafile ~/.config/nvim/init.lua<cr>:PaqUpdate<cr>", "Update plugins" },
  },
  g = {
    name = "Git...",
    s = { ":tab Git<cr>", "Git status" },
    a = { ":Glcd | Git add -u . | tab Git commit -v<cr>", "Git add and commit" },
    h = { ":GBrowse<cr>", "Open in GitHub" },
    c = { ":tab Git commit -v<cr>", "Git commit" },
    b = { ":Git blame<cr>", "Open file blame" },
    p = { ":FloatermNew --width=0.5 --height=0.3 git push<cr>", "Push" },
    r = {
      name = "Pull request...",
      c = { ":Glcd | !gh pr create --web<cr>", "Create PR (web)" },
      v = { ":Glcd | !gh pr view --web<cr>", "View PR (web)" },
    },
  },
  t = {
    name = "Terminal...",
    s = { ":ToggleTerm size=64 direction=vertical<cr>", "Open terminal to side" },
    f = { ":ToggleTerm size=64 direction=float<cr>", "Open terminal floating" },
    v = { ":ToggleTerm size=20 direction=horifloat<cr>", "Open terminal to bottom" },
  },
  l = {
    name = "Language (lsp)...",
    a = { ":lua vim.lsp.buf.code_action()<cr>", "Actions" },
    F = { ":lua vim.lsp.buf.formatting_seq_sync()<cr>", "Format (via LSP)" },
    f = { ":Neoformat<cr>", "Format (via Neoformat)" },
  },
}, { prefix = "<Leader>" })

-- localleader: lua
map("n", [[<localleader>s]], [[:w<cr>:luafile %<cr>]], opts)

-- Etc
map("n", [[co]], [[yo]], {}) -- Unimpaired

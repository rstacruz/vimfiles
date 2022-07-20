local wk = require("which-key")
vim.g.mapleader = " "
vim.g.maplocalleader = ","

local has_hop = pcall(require, "hop")
local has_neotree = pcall(require, "neo-tree")

-- Visual
wk.register({
  ["gl"] = { "<cmd>HopLine<cr>", "Go to line" },
  ["gw"] = { "<cmd>HopWord<cr>", "Go to word" },
  ["<leader>*"] = { "<cmd>silent! Glcd | lua require('spectre').open_visual()<cr>" },
  ["<leader>gy"] = { "<cmd>GBrowse!<cr>", "Cop[y] GitHub URL" },
  ["<leader>gY"] = { "<cmd>GBrowse<cr>", "Open in GitHub [Y]" },
}, { mode = "v" })

wk.register({
  -- Buffer
  ["gb"] = { ":bnext<cr>", "Buffer: next" },
  ["gB"] = { ":bprev<cr>", "Buffer: previous" },
  ["<tab>"] = { ":bnext<cr>", "Buffer: next" },
  ["<s-tab>"] = { ":bprev<cr>", "Buffer: previous" },

  -- lsp
  ["gd"] = { "<cmd>Telescope lsp_definitions<cr>", "Definitions (lsp)..." },
  ["gr"] = { "<cmd>Telescope lsp_references<cr>", "References (lsp)..." },
  ["gh"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Show hover" },
  ["gD"] = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Declaration (lsp)..." },
  ["gi"] = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Implementation (lsp)..." },
  ["K"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Show hover" },

  -- Hop
  ["gl"] = has_hop and { "<cmd>HopLine<cr>", "Hop to line" } or {},
  ["gw"] = has_hop and { "<cmd>HopWord<cr>", "Hop to word" } or {},

  -- Diagnostics
  ["[d"] = { "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Previous error" },
  ["]d"] = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "Next error" },

  -- Keymap: cr
  ["<cr><left>"] = { "<c-w>h", "Focus left" },
  ["<cr><right>"] = { "<c-w>l", "Focus right" },
  ["<cr><down>"] = { "<c-w>j", "Focus down" },
  ["<cr><up>"] = { "<c-w>k", "Focus up" },

  -- Leader
  ["<leader>."] = { "<cmd>ToggleTerm<cr>", "Toggle terminal" },
  ["<leader>*"] = { ":GG <c-r><c-w><cr>", "Search from cursor (GG)..." },

  -- Leader: [,] experimental
  ["<leader>,"] = { name = "Experimental..." },
  ["<leader>,s"] = { "<cmd>split ~/.scratchpad<cr><C-w>H", "Open [s]cratchpad" },
  ["<leader>,n"] = { ":noh<cr>", "Remove search highlighting [n]" },
  ["<leader>,g"] = { [[:lua require('core.actions').telescope_grep()<cr>]], "Search (telescope)..." },

  -- Leader: [w] window
  ["<leader>w"] = { name = "[w]indow..." },
  ["<leader>wH"] = { "<c-w>H", "Move window left ←" },
  ["<leader>wJ"] = { "<c-w>J", "Move window down ↓" },
  ["<leader>wK"] = { "<c-w>K", "Move window up ↑" },
  ["<leader>wL"] = { "<c-w>L", "Move window right →" },
  ["<leader>wh"] = { "<c-w>h", "Focus window left ←" },
  ["<leader>wj"] = { "<c-w>j", "Focus window down ↓" },
  ["<leader>wk"] = { "<c-w>k", "Focus window up ↑" },
  ["<leader>wl"] = { "<c-w>l", "Focus window right →" },
  ["<leader>ws"] = { "<c-w>s", "Split horizontal" },
  ["<leader>wv"] = { "<c-w>v", "Split vertical" },
  ["<leader>wq"] = { "<c-w>q", "Close window" },
  ["<leader>wt"] = { "<cmd>tab split<cr>", "New tab" },

  -- Leader: [x] exit
  ["<leader>x"] = { name = "E[x]it..." },
  ["<leader>xo"] = { ":%bd!|e#|bd#<cr>g;", "Close [o]ther buffers" },
  ["<leader>xh"] = { "<cmd>lua require('close_buffers').delete({ type = 'hidden' })<cr>", "Close [h]idden buffers" },
  ["<leader>xH"] = { "<cmd>lua require('close_buffers').delete({ type = 'hidden', force = true })<cr>",
    "Close [H]idden buffers (force)" },
  ["<leader>xc"] = { ":cq<cr>", "Exit [c]" },

  -- Leader: [s] settings
  ["<leader>s"] = { name = "[s]ettings..." },
  ["<leader>s,"] = { "<cmd>vsplit ~/.config/nvim/init.lua<cr>", "Edit Vim settings" },
  ["<leader>sk"] = { "<cmd>vsplit ~/.config/nvim/lua/core/keymaps.lua<cr>", "Edit [k]eybindings" },
  ["<leader>sr"] = { "<cmd>lua require('core.utils').reload()<cr>", "[r]eload Vim config" },
  ["<leader>sc"] = { "<cmd>Telescope colorscheme<cr>", "Choose [c]olour scheme" },
  ["<leader>st"] = { "<cmd>StartupTime<cr>", "Profile startup [t]ime" },

  -- Leader: [sp] packer
  ["<leader>sp"] = { name = "[p]acker..." },
  ["<leader>spc"] = { "<cmd>lua require('core.utils').reload()<cr>:PackerClean<cr>", "Packer: [c]lean unused packages", },
  ["<leader>spi"] = { "<cmd>lua require('core.utils').reload()<cr>:PackerInstall<cr>", "Packer: [i]nstall new packages", },
  ["<leader>sps"] = { "<cmd>lua require('core.utils').reload()<cr>:PackerSync<cr>", "Packer: [s]ync packages" },

  -- Leader: [t] terminal
  ["<leader>t"] = { name = "[t]erminal..." },
  ["<leader>ta"] = { "<cmd>1ToggleTerm<cr>", "Terminal 1" },
  ["<leader>tr"] = { "<cmd>2ToggleTerm<cr>", "Terminal 2" },
  ["<leader>ts"] = { "<cmd>3ToggleTerm<cr>", "Terminal 3" },
  ["<leader>tt"] = { "<cmd>4ToggleTerm<cr>", "Terminal 4" },
  ["<leader>th"] = { ":vs<cr>:term fish<cr>", "Open terminal [h]ere" },

  -- Leader: [c] code
  ["<leader>c"] = { name = "[c]ode..." },
  ["<leader>ca"] = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "[a]ctions..." },
  ["<leader>cr"] = { "<cmd>lua vim.lsp.buf.rename()<cr>", "[r]ename symbol..." },
  ["<leader>cd"] = { "<cmd>Telescope diagnostics<CR>", "Show [d]iagnostics" },
  ["<leader>cf"] = { "<cmd>lua vim.lsp.buf.formatting_seq_sync()<cr>", "[f]ormat via LSP" },

  -- Leader: [g] git
  ["<leader>g"] = { name = "[g]it..." },
  ["<leader>gs"] = { "<cmd>Neogit<cr>", "Git [s]tatus" },
  ["<leader>gS"] = { "<cmd>Neogit kind=vsplit<cr>", "Git [s]tatus, split" },
  ["<leader>ga"] = { ":silent! Glcd | Git add -u . | Git commit -v<cr>", "[a]dd & commit" },
  ["<leader>gA"] = { ":silent! Glcd | Git add -u . | Git commit --amend -v<cr>", "[A]dd & amend" },
  ["<leader>gy"] = { ":GBrowse!<cr>", "Cop[y] GitHub URL" },
  ["<leader>gY"] = { ":GBrowse<cr>", "Open in GitHub [Y]" },
  ["<leader>gc"] = { ":Git commit -v<cr>", "[c]ommit" },
  ["<leader>gb"] = { ":Git blame<cr>", "Open file [b]lame" },
  ["<leader>gp"] = { ":silent! Glcd | lua require('core.actions').open_floating_cmd('git push')<cr>", "[p]ush" },
  ["<leader>gP"] = { ":silent! Glcd | lua require('core.actions').open_floating_cmd('git push -f')<cr>", "[P]ush (force)" },
  ["<leader>gt"] = { ":silent! Glcd | lua require ('core.actions').open_tig()<cr>", "[t]ig... *" },

  -- Leader: [gh] github
  ["<leader>gh"] = { name = "Git[h]ub..." },
  ["<leader>ghp"] = { ":silent! Glcd | !gh pr create --web<cr>", "Create PR" },
  ["<leader>ghv"] = { ":silent! Glcd | !gh pr view --web<cr>", "View PR" },

  -- Leader: [p] pick
  ["<leader>p"] = { name = "[p]ick..." },
  ["<leader>pe"] = has_neotree and { "<cmd>Neotree float toggle<cr>", "[e]xplore files..." } or {},
  ["<leader>pb"] = { "<cmd>Telescope buffers<cr>", "List [B]uffers (telescope)..." },
  ["<leader>pB"] = has_neotree and { "<cmd>Neotree float buffers<cr>", "List [b]uffers..." } or {},
  ["<leader>pf"] = { "<cmd>Telescope fd<cr>", "Open [f]ile..." },
  ["<leader>pw"] = { "<cmd>Telescope workspaces<cr>", "Open [w]orkspace..." },
  ["<leader>pr"] = { "<cmd>lua require('telescope.builtin').oldfiles({only_cwd=true})<cr>", "Open [r]ecent file..." },
  ["<leader>ps"] = { "<cmd>SymbolsOutline<cr>", "Show [s]ymbols..." },
  ["<leader>pS"] = { "<cmd>Telescope lsp_document_symbols<cr>", "Show [S]ymbols (Tele)..." },
  ["<leader>pg"] = { [[:silent! Glcd | lua require('spectre').open({ is_insert_mode = true })<cr>]],
    "Find in files ([g]rep)...", },
  ["<leader>pW"] = { name = "[w]orkspaces..." },
  ["<leader>pWa"] = { "<cmd>WorkspacesAdd<cr>", "Workspace: [a]dd this folder" },

  -- Leader: [f] file
  ["<leader>f"] = { name = "[f]ile..." },
  ["<leader>fw"] = { ":w<cr>", "Save file [w]" },
  ["<leader>fs"] = { ":noa w<cr>", "[s]ave without formatting" },
  ["<leader>fr"] = { ":e!<cr>", "[r]evert changes in file" },
  ["<leader>fy"] = { [[:let @+=@% | echo '→ ' . @%<cr>]], "Cop[y] current path" },
  ["<leader>fY"] = { [[:let @+=expand('%:p') | echo '→ ' . expand('%:p')<cr>]], "Cop[Y] full path" },

  -- Leader: [o] toggle
  ["<leader>o"] = { name = "T[o]ggle..." },
  ["<leader>od"] = { "<cmd>lua vim.o.winwidth = vim.o.winwidth == 85 and 45 or 85<cr>100<c-w><", "Toggle wi[d]e" },
  ["<leader>ow"] = { "<cmd>set wrap!<cr>", "Toggle [w]ord wrap" },
  ["<leader>os"] = { "<cmd>set spell!<cr>", "Toggle [s]pell check" },
  ["<leader>on"] = { "<cmd>set number!<cr>", "Toggle line [n]umber" },
  ["<leader>or"] = { "<cmd>set relativenumber!<cr>", "Toggle [r]elative line number" },
  ["<leader>of"] = vim.fn.has("g:neovide") and
      { ":let g:neovide_fullscreen=!g:neovide_fullscreen<cr>", "Toggle [f]ullscreen" } or {},
  ["<leader>ob"] = { ":lua Theme:toggle_theme()<cr>", "Toggle light/dark theme" },
  ["<leader>ot"] = { "<cmd>Twilight<cr>", "Toggle [t]wilight mode" },
  ["<leader>oB"] = { ":lua vim.o.background = vim.o.background == 'light' and 'dark' or 'light'<cr>",
    "Toggle light/dark [B]ackground", },
  ["<leader>oc"] = { ":lua vim.o.conceallevel = vim.o.conceallevel == 2 and 0 or 2<cr>", "Toggle [c]onceal" },

  -- Leader: [oD] diagnostic
  ["<leader>oD"] = { name = "[D]iagnostic..." },
  ["<leader>oDd"] = { "<cmd>lua vim.diagnostic.disable()<cr>", "[d]isable diagnostics" },
  ["<leader>oDe"] = { "<cmd>lua vim.diagnostic.enable()<cr>", "[e]nable diagnostics" },
  ["<leader>oDh"] = { "<cmd>lua vim.diagnostic.hide()<cr>", "[h]ide diagnostics" },
  ["<leader>oDs"] = { "<cmd>lua vim.diagnostic.show()<cr>", "[s]how diagnostics" },
})

local function has_require(mod)
  return pcall(require, mod)
end

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Unimpaired
map("n", [[co]], [[<leader>o]], { silent = true })
map("n", [[yo]], [[<leader>o]], { silent = true })

-- Keymap: general
map("n", [[+]], [[za]], opts)
map("n", [[<del>]], [[:bwipe!<cr>]], opts)

-- Search/replace
map("n", [[gs]], [[:%s~~]], opts)
map("v", [[gs]], [[:s~~]], opts)

-- Keymap: terminal
map("t", [[<esc>]], [[<c-\><c-n>]], opts) -- Terminal esc
map("t", [[<c-n>]], [[<c-\><c-n><c-w>w]], opts) -- Terminal focus next
map("t", [[<c-h>]], [[<c-\><c-n><c-w>W]], opts) -- Terminal focus prev

-- Keymap: ctrl
map("i", [[<c-h>]], [[<esc><c-w>W]], opts) -- Focus prev (ins)
map("i", [[<c-n>]], [[<esc><c-w>w]], opts) -- Focus next (ins)
map("i", [[<c-pagedown>]], [[<esc><c-w>w]], opts) -- Focus next (ins)
map("i", [[<c-pageup>]], [[<esc><c-w>W]], opts) -- Focus prev (ins)
map("i", [[<c-s>]], [[<esc>:w<cr>]], opts) -- Save (ins)
map("i", [[<c-v>]], [[<esc>:set paste<cr>a<c-r>+<esc>:set nopaste<cr>a]], opts) -- Paste

map("n", [[<c-h>]], [[<c-w>W]], opts) -- Focus prev
map("n", [[<c-n>]], [[<c-w>w]], opts) -- Focus next (ins)
map("n", [[<c-pagedown>]], [[<c-w>w]], opts) -- Focus next (ins)
map("n", [[<c-pageup>]], [[<c-w>W]], opts) -- Focus prev
map("n", [[<c-s>]], [[:w<cr>]], opts) -- Save

map("v", [[<c-c>]], [["+y]], opts) -- Copy
if has_require("telescope") then
  map("n", [[<c-p>]], [[<cmd>Telescope fd<cr>]], opts)
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
  map("n", [[<esc><esc>]], [[<cmd>ToggleTerm<cr>]], opts) -- Terminal esc
  map("t", [[<esc><pagedown>]], [[<c-\><c-n>:ToggleTerm<cr>]], opts) -- Terminal esc
  map("n", [[<esc><pagedown>]], [[<cmd>ToggleTerm<cr>]], opts) -- Terminal esc
end

" vim:fdm=marker:foldmarker={{{,}}}:foldlevel=0

" close
nnoremap <Del> :q<CR>
nnoremap <S-Del> :bwipe!<CR>

" copy entire buffer
nnoremap <silent> <C-c> :%y+<CR>

" Folding
nnoremap + za
nnoremap _ zMzO
" i[s]olate: Close all folds, expect the ones for this
nnoremap <silent> zs zMzv
" isolate: Close all folds, then recursively open this one
nnoremap <silent> zg zMzvzczO

" [g] g customisations {{{
vnoremap gs :s~~
nnoremap gs :%s~~

if exists(':EasyAlign')
  " Start interactive EasyAlign in visual mode (e.g. vipga)
  xmap ga <Plug>(EasyAlign)
  " Start interactive EasyAlign for a motion/text object (e.g. gaip)
  nmap ga <Plug>(EasyAlign)
endif
" }}}

" [yo] Unimpaired-style toggles {{{
if exists(':GitGutterToggle')
  nnoremap <silent> yog :GitGutterToggle<cr>
  nnoremap <silent> cog :GitGutterToggle<cr>
endif
if exists(':Gitsigns')
  nnoremap <silent> yog :Gitsigns toggle_signs<cr>
  nnoremap <silent> cog :Gitsigns toggle_signs<cr>
endif
" }}}

" [-] NERDtree {{{
if exists(':NERDTree')
  nnoremap <silent> - :NERDTreeFind<CR>
endif
" }}}

" [-] Nvim-tree {{{
if exists(':NvimTreeFindFile')
  nnoremap <silent> - :NvimTreeFindFile<CR>
endif
" }}}

" [ctrl-s] Save {{{
if $GIT_EXEC_PATH != ''
  nnoremap <C-s> :wq<cr>
  inoremap <C-s> <esc>:wq<cr>
else
  nnoremap <C-s> :w<cr>
  inoremap <C-s> <esc>:w<cr>
endif
" }}}

" [f1...f12] fn keys {{{
" Quickfix
nnoremap <F2> :cclose<CR>
nnoremap <F4> :cnext<CR>

" Location list
nnoremap <S-F2> :lclose<CR>
nnoremap <S-F3> :lprev<CR>
nnoremap <S-F4> :lnext<CR>
" }}}

" [leader] Top-level maps {{{
let g:which_key_map = {}
let g:which_key_map.f = { 'name': '+File     ▶' }
" let g:which_key_map.a = { 'name': '+Apps' }
let g:which_key_map.f.e = { 'name': '+Settings  ▶' }
let g:which_key_map.k = { 'name': '+Editor   ▶' }
let g:which_key_map.g = { 'name': '+Git      ▶' }
let g:which_key_map.t = { 'name': '+Tabs     ▶' }
let g:which_key_map.c = { 'name': '+Code     ▶' }
let g:which_key_map.w = { 'name': '+Window   ▶' }
let g:which_key_map.p = { 'name': '+Pick     ▶' }
let g:which_key_map.x = { 'name': '+eXit     ▶' }

let g:which_key_map.z = 'Go to project...'
let g:which_key_map.Z = 'which_key_ignore'
nnoremap <leader>z :Z<Space>
nnoremap <leader>Z :ZZ<Space>
" }}}

" [leader-q] Close {{{
let g:which_key_map.x.q = 'Quit vim'
let g:which_key_map.x.c = 'Close window'
let g:which_key_map.x.x = 'Close window (force)'
let g:which_key_map.x.s = 'Save and close'
let g:which_key_map.x.o = 'Close others'
nnoremap <leader>xq :cq<cr>
nnoremap <leader>xc :q<cr>
nnoremap <leader>xx :bwipe!<cr>
nnoremap <leader>xs :wq<cr>
nnoremap <leader>xo <C-w>o<cr>

if exists(':Startify')
  let g:which_key_map.x.z = 'Close all (reset workspace)'
  nnoremap <leader>xz :tabonly<cr>:wincmd o<cr>:Startify<cr>:Bdelete! hidden<cr>
endif
" }}}

" [leader-w] Window {{{
let g:which_key_map.w.t = 'Go to top-left'
let g:which_key_map.w.b = 'Go to bot-right'
nnoremap <silent> <leader>wt <C-w>t<CR>
nnoremap <silent> <leader>wb <C-w>b<CR>
nnoremap <silent> <leader>wv :silent wincmd v<cr><C-w>l
nnoremap <silent> <leader>ws :silent wincmd s<cr><C-w>j

let g:which_key_map.w['1'] = 'Go to window 1'
let g:which_key_map.w['2'] = 'Go to window 2'
let g:which_key_map.w['3'] = 'Go to window 3'
let g:which_key_map.w['4'] = 'which_key_ignore'
let g:which_key_map.w['5'] = 'which_key_ignore'
let g:which_key_map.w['6'] = 'which_key_ignore'
let g:which_key_map.w['7'] = 'which_key_ignore'
let g:which_key_map.w['8'] = 'which_key_ignore'
let g:which_key_map.w['9'] = 'which_key_ignore'
nnoremap <silent> <leader>w1 :wincmd t<cr>
nnoremap <silent> <leader>w2 :2wincmd w<cr>
nnoremap <silent> <leader>w3 :3wincmd w<cr>
nnoremap <silent> <leader>w4 :4wincmd w<cr>
nnoremap <silent> <leader>w5 :5wincmd w<cr>
nnoremap <silent> <leader>w6 :6wincmd w<cr>
nnoremap <silent> <leader>w7 :7wincmd w<cr>
nnoremap <silent> <leader>w8 :8wincmd w<cr>
nnoremap <silent> <leader>w9 :wincmd b<cr>

let g:which_key_map.w.q = 'Close window'
let g:which_key_map.w.Q = 'Close everything'
nnoremap <silent> <leader>wq <C-w>q<CR>
nnoremap <silent> <leader>wQ :bufdo bwipe!<CR>

let g:which_key_map.w['_'] = 'Zoom'
nnoremap <silent> <leader>w_ <C-w>_<CR>

let g:which_key_map.w.o = 'Close others'
nnoremap <silent> <leader>wo <C-w>o<CR>

let g:which_key_map.w.h = 'Focus ←'
let g:which_key_map.w.j = 'Focus ↓'
let g:which_key_map.w.k = 'Focus ↑'
let g:which_key_map.w.l = 'Focus →'
nnoremap <silent> <leader>wh <C-w>h<CR>
nnoremap <silent> <leader>wj <C-w>j<CR>
nnoremap <silent> <leader>wk <C-w>k<CR>
nnoremap <silent> <leader>wl <C-w>l<CR>

let g:which_key_map.w.n = 'New'
let g:which_key_map.w.s = 'Split horiz'
let g:which_key_map.w.v = 'Split vert'
nnoremap <silent> <leader>wn <C-w>n<CR>
nnoremap <silent> <leader>ws <C-w>s<CR><C-w>j
nnoremap <silent> <leader>wv <C-w>v<CR><C-w>l

let g:which_key_map.w.S = 'Terminal (horiz)'
let g:which_key_map.w.V = 'Terminal (vert)'
nnoremap <silent> <leader>wV :silent wincmd v<cr><C-w>l:term<cr>
nnoremap <silent> <leader>wS :silent wincmd s<cr><C-w>j:term<cr>

let g:which_key_map.w.H = 'which_key_ignore'
let g:which_key_map.w.J = 'which_key_ignore'
let g:which_key_map.w.K = 'which_key_ignore'
let g:which_key_map.w.L = 'which_key_ignore'
nnoremap <silent> <leader>wH <C-w>H<CR>
nnoremap <silent> <leader>wJ <C-w>J<CR>
nnoremap <silent> <leader>wK <C-w>K<CR>
nnoremap <silent> <leader>wL <C-w>L<CR>
" }}}

" [leader-fi] Follow in... {{{{
let g:which_key_map.f.i = { 'name': '+Follow in...' }
let g:which_key_map.f.i.t = 'New tab'
let g:which_key_map.f.i.v = 'Vert split'
let g:which_key_map.f.i.s = 'Horiz split'
let g:which_key_map.f.i['.'] = 'Here'
nnoremap <leader>fit :tab split <cfile><CR>
nnoremap <leader>fiv :vsplit <cfile><CR>
nnoremap <leader>fis :ssplit <cfile><CR>
nnoremap <leader>fi. :e <cfile><CR>
" }}}

" [leader-fe] Config {{{
let g:which_key_map.f.e.k = 'Edit keys'
let g:which_key_map.f.e.c = 'Customizations'
let g:which_key_map.f.e.i = 'Edit init.vim'
let g:which_key_map.f.e.t = 'Edit theme'
let g:which_key_map.f.e.s = 'Edit snippets'
let g:which_key_map.f.e.u = 'Update config'
let g:which_key_map.f.e.p = 'Update plugins'
nnoremap <silent> <leader>fek :tabnew<cr>:e ~/.config/nvim/after/plugin/keys.vim<cr>
nnoremap <silent> <leader>fec :tabnew<cr>:e ~/.config/nvim/after/plugin/customizations.vim<cr>
nnoremap <silent> <leader>fei :tabnew<cr>:e ~/.config/nvim/init.vim<cr>
nnoremap <silent> <leader>fes :tabnew<cr>:e ~/.config/nvim/ultisnips<cr>
nnoremap <silent> <leader>fet :tabnew<cr>:e ~/.config/nvim/modules/dynamic-theme/color/dyntheme.vim<cr>
nnoremap <silent> <leader>feu :UpdateVimConfig<cr>
nnoremap <silent> <leader>fep :UpdateVimPlugins<cr>
" }}}

" [leader-g] Git {{{
if exists(':Gstatus')
  let g:which_key_map.g.h = { 'name': '+GitHub...' }
  let g:which_key_map.g.s = 'Status'
  let g:which_key_map.g.c = 'Commit -a (add)'
  let g:which_key_map.g.A = 'Commit --amend -a (amend)'
  let g:which_key_map.g.b = 'Blame'
  let g:which_key_map.g.d = 'cd to Git root (local)'
  let g:which_key_map.g.D = 'cd to Git root (global)'
  let g:which_key_map.g.y = 'GitHub: Copy URL'

  nnoremap <silent> <leader>gs :tab Git<cr>
  nnoremap <silent> <leader>gc :Git add --all \| tab Git commit -v<cr>
  nnoremap <silent> <leader>gA :Git add --all \| tab Git commit --amend -v<cr>
  nnoremap <silent> <leader>gb :Git blame<cr>
  nnoremap <silent> <leader>gd :Glcd<cr>
  nnoremap <silent> <leader>gD :Gcd<cr>

  let g:which_key_map.g.h = 'GitHub: Open in browser'
  nnoremap <silent> <leader>gh :GBrowse<cr>
  vnoremap <silent> <leader>gh :GBrowse<cr>

  nnoremap <silent> <leader>gy :GBrowse!<cr>
  vnoremap <silent> <leader>gy :GBrowse!<cr>

  if exists(':FloatermNew')
    let g:which_key_map.g.p = 'Push'
    let g:which_key_map.g.P = 'Push (force)'
    nnoremap <silent> <leader>gp :exec "FloatermNew --autoclose=1 --height=8 --width=0.9 --title=push... --position=bottom git push" \| wincmd p<cr>
    nnoremap <silent> <leader>gP :exec "FloatermNew --autoclose=1 --height=8 --width=0.9 --title=pushforce... --position=bottom git push --force-with-lease --set-upstream origin (git rev-parse --abbrev-ref HEAD)" \| wincmd p<cr>

    let g:which_key_map.g.r = 'Open pull request'
    let g:which_key_map.g.R = 'Create pull request'
    nnoremap <silent> <leader>gr :FloatermNew gh pr create --web<cr>
    nnoremap <silent> <leader>gR :FloatermNew --height=3 --width=0.9 --position=bottom gh pr view --web<cr>
  endif
endif

if exists(':GV')
  let g:which_key_map.g.l = 'Log'
  nnoremap <silent> <leader>gl :GV<cr>
endif
" }}}

" [leader-p] Pick {{{
if exists(':Telescope')
  nnoremap <silent> <C-p> :Telescope git_files<cr>
  let g:which_key_map.p.b = 'Buffers...'
  nnoremap <silent> <leader>pb :Telescope buffers<cr>
  let g:which_key_map.p.g = 'Git files...'
  nnoremap <silent> <leader>pg :Telescope git_files<cr>
elseif exists(':Flies')
  nnoremap <silent> <C-p> :GFiles --exclude-standard --others --cached<cr>
  let g:which_key_map.p.b = 'Buffers...'
  nnoremap <silent> <leader>pb :Buffers<cr>
  let g:which_key_map.p.g = 'Git files...'
  nnoremap <silent> <leader>pg :GFiles --exclude-standard --others --cached<cr>
endif

if exists(':Files')
  let g:which_key_map.p.f = 'Files...'
  nnoremap <silent> <leader>pf :Files<cr>
  let g:which_key_map.p.s = 'Git status...'
  nnoremap <silent> <leader>ps :GFiles?<cr>
  let g:which_key_map.p.w = 'Switch to window...'
  nnoremap <silent> <leader>pw :Windows<cr>
  let g:which_key_map.p['.'] = 'Search in this file...'
  nnoremap <silent> <leader>p. :BLines<cr>
  let g:which_key_map.p['*'] = 'Search for this word...'
  nnoremap <silent> <leader>p* :BLines <C-r><C-w><cr>
endif
" }}}

" [leader-f] File {{{
let g:which_key_map.f.s = 'Save without formatting'
let g:which_key_map.f.a = 'Save'
nnoremap <leader>fs :noa w<cr>
nnoremap <leader>fa :w<cr>

if exists(':FloatermToggle')
  let g:which_key_map.f.b = 'Browse...'
  nnoremap <leader>fb :FloatermNew --title=ranger ranger<cr>
endif

if exists('*OpenOrCreateFile')
  let g:which_key_map.f.f = 'Open or create file'
  nnoremap <silent> <leader>ff :call OpenOrCreateFile()<cr>
  let g:which_key_map.f.F = 'Open or create file (split)'
  nnoremap <silent> <leader>fF :call OpenOrCreateFile('split')<cr>

  " Overrides gF, which normally accounts for line numbers
  nnoremap <silent> gF :call OpenOrCreateFile()<cr>
  nnoremap <silent> <C-w>F :call OpenOrCreateFile('split')<cr>
endif

" if exists(':tabclose')
"   let g:which_key_map.t['.'] = 'Shell in new tab'
"   let g:which_key_map.t.n = 'New tab'
"   let g:which_key_map.t.c = 'Close tab'
"   nnoremap <leader>tc :tabclose<cr> -- see <del>
"   nnoremap <leader>tn :tabnew<cr>:Startify<cr> " -- see enter-t
"   nnoremap <leader>t. :tabnew<cr>:term<cr> -- see enter-T
" endif

let g:which_key_map.f.r = 'Revert file'
nnoremap <leader>fr :e!<CR>

" if exists(':Quickterm')
"   let g:which_key_map["'"] = 'Terminal'
"   nnoremap <leader>' :Quickterm<CR>
"   " Like vscode
"   nnoremap <C-j> :Quickterm<CR>
" endif

" if exists(':FloatermToggle')
"   let g:which_key_map["'"] = 'Terminal'
"   nnoremap <leader>' <Esc>:FloatermToggle<CR> -- see enter-esc
" endif

let g:which_key_map.f.y = 'Copy current path'
nnoremap <leader>fy :let @+=@% \| echo '[' .  getcwd() . '] → ' . @%<cr>

let g:which_key_map.f.Y = 'Copy full path'
nnoremap <leader>fY :let @+=expand('%:p') \| echo '→ ' . expand('%:p')<cr>
" }}}

" [leader-s] vim-test {{{
if exists(':TestNearest')
  let g:which_key_map.s = { 'name': '+Test' }
  let g:which_key_map.s.n = 'Test nearest'
  let g:which_key_map.s.f = 'Test this file'
  let g:which_key_map.s.r = 'Rerun last test'
  nmap <silent> <leader>sn :TestNearest<CR><C-\><C-n><C-w>p
  nmap <silent> <leader>sf :TestFile<CR><C-\><C-n><C-w>p
  nmap <silent> <leader>sr :TestLast<CR><C-\><C-n><C-w>p
  " nmap <silent> <leader>sv :TestVisit<CR>
  " nmap <silent> <leader>ss :TestSuite<CR><C-W>p
endif
" }}}

" [leader-*/] Search {{{
if exists(':GG')
  let g:which_key_map['*'] = 'Search'
  let g:which_key_map['/'] = 'Search...'
  nnoremap <leader>/  :GG!<space>
  nnoremap <leader>*  :GG! <C-r><C-w><CR>
  vnoremap <leader>*  y:GG! <C-r>"<C-b><CR>
endif
" }}}

" [leader-k] Editor {{{
if exists(':Goyo')
  let g:which_key_map.k.z = 'Toggle zen mode'
  nmap <leader>kz :Goyo<cr>:echo "Zen mode"<cr>
end

if exists(':Autofold')
  let g:which_key_map.k.a = 'Toggle autofold'
  nmap <leader>ka :Autofold<cr>
end

if exists(':ContextToggle')
  let g:which_key_map.k.c = 'Toggle context'
  nnoremap <leader>kc :ContextToggle<cr>
endif
" }}}

" [leader-c] Coc {{{
if exists(':CocAction')
  let g:which_key_map.c.c = 'Show commands'
  let g:which_key_map.c.d = 'Show errors'
  let g:which_key_map.c.f = 'Format'
  let g:which_key_map.c.r = 'Rename symbol...'
  let g:which_key_map.c.R = 'Refactor...'
  let g:which_key_map.c.a = 'Actions (selected)...'
  let g:which_key_map.c.A = 'Actions (file)...'
  let g:which_key_map.c.h = 'Show hover'
  let g:which_key_map.c.s = 'Symbols...'

  " https://github.com/neoclide/coc.nvim#example-vim-configuration
  inoremap <silent><expr> <c-space> coc#refresh()

  " Go to...
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gD <Plug>(coc-diagnostic-info)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Hover
  nnoremap <silent> gh :call CocActionAsync('doHover')<CR>
  nnoremap <silent> <leader>ch :call CocActionAsync('doHover')<CR>

  " format region
  nnoremap <leader>cf :call CocAction('format')<CR>
  vmap <leader>cf <Plug>(coc-format-selected)

  nmap <leader>cr <Plug>(coc-rename)
  xmap <leader>cr <Plug>(coc-rename)
  nmap <leader>cR <Plug>(coc-refactor)
  xmap <leader>cR <Plug>(coc-refactor)
  nmap <leader>ca <Plug>(coc-codeaction-cursor)
  xmap <leader>ca <Plug>(coc-codeaction-selected)
  nmap <leader>cA <Plug>(coc-codeaction)
  xmap <leader>cA <Plug>(coc-codeaction)
  nnoremap <leader>cc :CocCommand<CR>
  nnoremap <leader>cd :CocList diagnostics<CR>
  nnoremap <leader>cs :CocList symbols<CR>
endif
" }}}

" [leader-m] Marks (harpoon) {{{
if globpath(&rtp, "plugin/mark.vim") != ""
  let g:which_key_map.m = { 'name': '+Marks' }
  let g:which_key_map.m.a = 'Add file'
  nnoremap <silent> <leader>ma :lua require('harpoon.mark').add_file()<CR>

  let g:which_key_map.p.m = 'List marks...'
  nnoremap <silent> <leader>pm :lua require('harpoon.ui').toggle_quick_menu()<CR>

  let g:which_key_map.m.l = 'List marks...'
  nnoremap <silent> <leader>ml :lua require('harpoon.ui').toggle_quick_menu()<CR>
  let g:which_key_map.m.x = 'Terminal 1'
  nnoremap <silent> <leader>mx :lua require('harpoon.term').gotoTerminal(1)<CR>
  let g:which_key_map.m.c = 'Terminal 2'
  nnoremap <silent> <leader>mc :lua require('harpoon.term').gotoTerminal(2)<CR>
  let g:which_key_map.m.d = 'Terminal 3'
  nnoremap <silent> <leader>md :lua require('harpoon.term').gotoTerminal(3)<CR>

  nnoremap <silent> <F1> :lua require('harpoon.ui').nav_file(1)<CR>
  nnoremap <silent> <F2> :lua require('harpoon.ui').nav_file(2)<CR>
  nnoremap <silent> <F3> :lua require('harpoon.ui').nav_file(3)<CR>
  nnoremap <silent> <F4> :lua require('harpoon.ui').nav_file(4)<CR>
  nnoremap <silent> <F5> :lua require('harpoon.ui').nav_file(5)<CR>
  " nnoremap <silent> <F7> :lua require('harpoon.term').gotoTerminal(1)<CR>
  " nnoremap <silent> <F8> :lua require('harpoon.term').gotoTerminal(2)<CR>
  " nnoremap <silent> <F9> :lua require('harpoon.term').gotoTerminal(3)<CR>

  inoremap <silent> <F1> <Esc>:lua require('harpoon.ui').nav_file(1)<CR>
  inoremap <silent> <F2> <Esc>:lua require('harpoon.ui').nav_file(2)<CR>
  inoremap <silent> <F3> <Esc>:lua require('harpoon.ui').nav_file(3)<CR>
  inoremap <silent> <F4> <Esc>:lua require('harpoon.ui').nav_file(4)<CR>
  inoremap <silent> <F5> <Esc>:lua require('harpoon.ui').nav_file(5)<CR>
  inoremap <silent> <F7> <Esc>:lua require('harpoon.term').gotoTerminal(1)<CR>
  inoremap <silent> <F8> <Esc>:lua require('harpoon.term').gotoTerminal(2)<CR>
  inoremap <silent> <F9> <Esc>:lua require('harpoon.term').gotoTerminal(3)<CR>
endif
" }}}

" [leader-cm] Macros {{{
let g:which_key_map.c.m = { 'name': '+Macros' }
let g:which_key_map.c.m.f = 'JS arrow-func to func-decl'
nnoremap <leader>cmf ^/const<cr>cwfunction<esc>f=xxf=xxx^
let g:which_key_map.c.m.d = 'Date (Sun 1 Apr)'
nnoremap <leader>cmd a<C-r>=strftime('%a %e %b')<cr>
" }}}

" [leader-.] Terminal {{{
if exists(':term')
  " Different ways to escape
  tnoremap <C-b><C-n> <C-\><C-n>
  tnoremap <C-]> <C-\><C-n>
  tnoremap <C-[> <C-\><C-n>

  let g:which_key_map['.'] = 'Terminal here'
  nnoremap <silent> <leader>. :term<CR>
endif
" }}}

" [enter] window {{{
let g:which_key_cr = {
  \ '1': 'Pane 1',
  \ '2': 'Pane 2',
  \ '3': 'Pane 3',
  \ '4': 'which_key_ignore',
  \ '5': 'which_key_ignore',
  \ '6': 'which_key_ignore',
  \ '9': 'Pane 9',
  \ 'n': 'New',
  \ 'o': 'Only',
  \ 's': 'Split horiz',
  \ 't': 'Tab',
  \ 'v': 'Split vert',
  \ 'x': 'Close',
  \ 'X': 'Force-close',
  \ '<Esc>': 'Terminal',
  \ '<Home>': 'Prev tab',
  \ '<End>': 'Next tab',
  \ '<Up>': 'Focus ↑',
  \ '<Down>': 'Focus ↓',
  \ '<Left>': 'Focus ←',
  \ '<Right>': 'Focus →',
  \ 'H': 'Move ←',
  \ 'J': 'Move ↑',
  \ 'K': 'Move ↓',
  \ 'L': 'Move →',
  \ 'S': 'Terminal →',
  \ 'T': 'Terminal tab',
  \ 'V': 'Terminal ↓',
  \ 'z': 'Zen mode',
  \ }

nnoremap <silent> <cr><Space> za
nnoremap <silent> <cr><PageUp> :tabnew<cr>:Startify<cr>
nnoremap <silent> <cr><PageDown> :FloatermToggle<cr>
nnoremap <silent> <cr>9 :wincmd b<cr>
nnoremap <silent> <cr>1 :wincmd t<cr>
nnoremap <silent> <cr>2 :2wincmd w<cr>
nnoremap <silent> <cr>3 :3wincmd w<cr>
nnoremap <silent> <cr>4 :4wincmd w<cr>
nnoremap <silent> <cr>5 :5wincmd w<cr>
nnoremap <silent> <cr>6 :6wincmd w<cr>
nnoremap <silent> <cr>, :Buffers<cr>
nnoremap <silent> <cr><Home>  gT
nnoremap <silent> <cr><End>   gt
nnoremap <silent> <cr><Up>    :silent wincmd k<cr>
nnoremap <silent> <cr><Down>  :silent wincmd j<cr>
nnoremap <silent> <cr><Left>  :silent wincmd h<cr>
nnoremap <silent> <cr><Right> :silent wincmd l<cr>
nnoremap <silent> <cr>t :silent tabnew<cr>:Startify<cr>
nnoremap <silent> <cr>T :silent tabnew<cr>:term<cr>
nnoremap <silent> <cr>n :silent wincmd n<cr>
nnoremap <silent> <cr>o :silent wincmd o<cr>
nnoremap <silent> <cr>v :silent wincmd v<cr><C-w>l
nnoremap <silent> <cr>V :silent wincmd v<cr><C-w>l:term<cr>
nnoremap <silent> <cr>s :silent wincmd s<cr><C-w>j
nnoremap <silent> <cr>S :silent wincmd s<cr><C-w>j:term<cr>
nnoremap <silent> <cr>k :silent wincmd k<cr>
nnoremap <silent> <cr>j :silent wincmd j<cr>
nnoremap <silent> <cr>h :silent wincmd h<cr>
nnoremap <silent> <cr>l :silent wincmd l<cr>
nnoremap <silent> <cr>K :silent wincmd K<cr>
nnoremap <silent> <cr>J :silent wincmd J<cr>
nnoremap <silent> <cr>H :silent wincmd H<cr>
nnoremap <silent> <cr>L :silent wincmd L<cr>
nnoremap <silent> <cr>x :q<cr>
nnoremap <silent> <cr>X :bwipe!<cr>
nnoremap <silent> <cr>z :Goyo<cr>

nnoremap <silent> <CR> :exec ":WhichKey '\<CR\>'"<CR>
" }}}

" localleader: markdown? {{{
nnoremap <silent> , :WhichKey ','<CR>

" Markdown
augroup local_markdown
  autocmd FileType markdown nnoremap <silent> <buffer> <localleader>v :MarkdownPreview<cr>
  autocmd FileType markdown nnoremap <silent> <buffer> <localleader>p :call mdip#MarkdownClipboardImage()<cr>
  autocmd FileType markdown nnoremap <silent> <buffer> <localleader>b ysiw-<cr>
  autocmd FileType markdown vnoremap <silent> <buffer> <localleader>b S-<cr>
augroup END

augroup local_vim
  autocmd FileType vim nnoremap <silent> <buffer> <localleader>s :so %<CR>
augroup END

let g:which_key_labels = {
  \ 'MarkdownPreview': 'Markdown preview',
  \ 'call mdip#MarkdownClipboardImage()': 'Paste image',
  \ 'so %': 'Load file',
  \ }
" }}}

" Chromebook keyboard {{{
if hostname() == "penguin" || $TERMUX_VERSION != ""
  inoremap ,; <Esc>:
  inoremap ,. <Esc>
vnoremap ,. :
endif
" }}}

" Alias for spacebar?
nnoremap <silent> & :WhichKey '<space>'<cr>

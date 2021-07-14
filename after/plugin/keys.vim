" close
nnoremap <Del> :q<CR>
nnoremap <S-Del> :bwipe!<CR>

" g customisations
vnoremap gs :s~~
nnoremap gs :%s~~

" Folding
nnoremap + za

" Ctrl-s
if $GIT_EXEC_PATH != ''
  nnoremap <C-s> :wq<cr>
  inoremap <C-s> <esc>:wq<cr>
else
  nnoremap <C-s> :w<cr>
  inoremap <C-s> <esc>:w<cr>
endif

" Which key
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
let g:which_key_map.q = { 'name': '+Quit     ▶' }

nnoremap <leader><space> :Files<CR>
nnoremap <leader>, :Files<CR>

" File
let g:which_key_map.f.s = 'Save without formatting'
let g:which_key_map.f.a = 'Save'
nnoremap <leader>fs :noa w<cr>
nnoremap <leader>fa :w<cr>

if exists(':FloatermToggle')
  let g:which_key_map.f.b = 'Browse...'
  nnoremap <leader>fb :FloatermNew --title=ranger ranger<cr>
endif

" Close
let g:which_key_map.q.q = 'Quit vim'
let g:which_key_map.q.w = 'Close window'
let g:which_key_map.q.y = 'which_key_ignore' " convenience for colemak
let g:which_key_map.q.x = 'Close window (force)'
let g:which_key_map.q.s = 'Save and close'
let g:which_key_map.q.o = 'Close others'
nnoremap <leader>qq :cq<cr>
nnoremap <leader>qw :q<cr>
nnoremap <leader>qy :q<cr>
nnoremap <leader>qx :bwipe!<cr>
nnoremap <leader>qs :wq<cr>
nnoremap <leader>qo <C-w>o<cr>

if exists(':Startify')
  let g:which_key_map.q.r = 'Close all (reset workspace)'
  nnoremap <leader>qr :tabonly<cr>:StartifyReset<cr>
endif

" Window
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
nnoremap <silent> <leader>w1 :1wincmd w<cr>
nnoremap <silent> <leader>w2 :2wincmd w<cr>
nnoremap <silent> <leader>w3 :3wincmd w<cr>
nnoremap <silent> <leader>w4 :4wincmd w<cr>
nnoremap <silent> <leader>w5 :5wincmd w<cr>
nnoremap <silent> <leader>w6 :6wincmd w<cr>
nnoremap <silent> <leader>w7 :7wincmd w<cr>
nnoremap <silent> <leader>w8 :8wincmd w<cr>
nnoremap <silent> <leader>w9 :9wincmd w<cr>

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

" Open config
let g:which_key_map.f.e.k = 'Edit keys'
let g:which_key_map.f.e.c = 'Customizations'
let g:which_key_map.f.e.i = 'Edit init.vim'
let g:which_key_map.f.e.t = 'Edit theme'
let g:which_key_map.f.e.s = 'Edit snippets'
nnoremap <leader>fek :tabnew<cr>:e ~/.config/nvim/after/plugin/keys.vim<cr>
nnoremap <leader>fec :tabnew<cr>:e ~/.config/nvim/after/plugin/customizations.vim<cr>
nnoremap <leader>fei :tabnew<cr>:e ~/.config/nvim/init.vim<cr>
nnoremap <leader>fes :tabnew<cr>:e ~/.config/nvim/ultisnips<cr>
nnoremap <leader>fet :tabnew<cr>:e ~/.config/nvim/modules/dynamic-theme/color/dyntheme.vim<cr>

if exists(':Gstatus')
  let g:which_key_map.g.h = { 'name': '+GitHub...' }
  let g:which_key_map.g.s = 'Status'
  let g:which_key_map.g.c = 'Commit -a (add)'
  let g:which_key_map.g.A = 'Commit --amend -a (amend)'
  let g:which_key_map.g.b = 'Blame'
  let g:which_key_map.g.d = 'cd to Git root (local)'
  let g:which_key_map.g.D = 'cd to Git root (global)'
  let g:which_key_map.g.y = 'GitHub: Copy URL'

  nnoremap <leader>gs :tab Git<cr>
  nnoremap <leader>gc :Git add --all \| tab Git commit -v<cr>
  nnoremap <leader>gA :Git add --all \| tab Git commit --amend -v<cr>
  nnoremap <leader>gb :Git blame<cr>
  nnoremap <leader>gd :Glcd<cr>
  nnoremap <leader>gD :Gcd<cr>

  let g:which_key_map.g.h['h'] = 'Open in GitHub'
  nnoremap <leader>ghh :GBrowse<cr>
  vnoremap <leader>ghh :GBrowse<cr>

  nnoremap <leader>gy :GBrowse!<cr>
  vnoremap <leader>gy :GBrowse!<cr>

  if exists(':Dispatch')
    let g:which_key_map.g.p = 'Push'
    let g:which_key_map.g.P = 'Push (force)'
    nnoremap <leader>gp :Dispatch git push<cr>
    nnoremap <leader>gP :Dispatch git push --force-with-lease --set-upstream origin (git rev-parse --abbrev-ref HEAD)<cr>

    let g:which_key_map.g.h.p = 'Open pull request'
    let g:which_key_map.g.h.P = 'Create pull request'
    nnoremap <leader>ghP :FloatermNew gh pr create<cr>
    nnoremap <leader>ghp :FloatermNew gh pr view --web<cr>
  endif
endif

if exists(':GV')
  let g:which_key_map.g.l = 'Log'
  nnoremap <leader>gl :GV<cr>
endif

" if exists(':Clap')
"   let g:which_key_map.k.b = 'List buffers...'
"   let g:which_key_map.k.h = 'History'
"   nnoremap <leader>kb :Clap buffers<cr>
"   nnoremap <leader>kh :Clap history<cr>

"   let g:which_key_map[';'] = 'List buffers...'
"   nnoremap <leader>; :Clap buffers<cr>

"   " let g:which_key_map.f.g = 'List modified files...'
"   " nnoremap <leader>fg :Clap git_diff_files<cr>

"   " nnoremap <C-p> :Clap files<cr>
if exists(':Buffers')
  let g:which_key_map.p.b = 'Buffers...'
  nnoremap <leader>pb :Buffers<cr>
endif

if exists(':FZF')
  nnoremap <C-p> :Files<cr>
  let g:which_key_map.p.f = 'Files...'
  nnoremap <leader>pf :Files<cr>
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

if exists(':term')
  " Different ways to escape
  tnoremap <C-b><C-n> <C-\><C-n>
  tnoremap <C-]> <C-\><C-n>
  tnoremap <C-[> <C-\><C-n>

  let g:which_key_map['.'] = 'Terminal here'
  nnoremap <silent> <leader>. :term<CR>

"   let g:which_key_map.t.t = 'Terminal (tab)'
"   let g:which_key_map.t.s = 'Terminal (split)'
"   let g:which_key_map.t.v = 'Terminal (vert)'
"   nnoremap <leader>t. :term<CR>
"   nnoremap <leader>tt :tabnew<CR><Esc>:term<CR>
"   nnoremap <leader>ts :split<CR><Esc>:term<CR>
"   nnoremap <leader>tv :vsplit<CR><C-w>l:term<CR>

  " Term repeat thing
    let g:which_key_map.t.r = 'Repeat command in last term'
    " nnoremap <leader>tr :w<cr>:call keys#switch_to_term()<cr><C-\><C-n>a<Up><CR><C-\><C-n><C-w>p
    nnoremap <leader>tr :w<cr><C-w>p<C-\><C-n>a<Up><CR><C-\><C-n><C-w>p
endif

" vim-test
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

" if exists(':CHADopen')
"   nnoremap _ :silent! :Glcd<CR>:CHADopen<CR>
"   nnoremap <silent> - :CHADopen<CR>
  " nnoremap _ :Glcd<CR>:silent! NERDTreeFind<CR>
if exists(':NERDTree')
  nnoremap <silent> _ :NERDTreeFind<CR>
  nnoremap <silent> - :NERDTree<CR>
  " nnoremap <silent> - :exec 'e '.expand('%:h')<CR>
  " nnoremap _ :Glcd<CR>:silent! NERDTreeFind<CR>
endif

if exists(':GG')
  let g:which_key_map['*'] = 'Search'
  let g:which_key_map['/'] = 'Search...'
  nnoremap <leader>/  :GG!<space>
  nnoremap <leader>*  :GG! <C-r><C-w><CR>
  vnoremap <leader>*  y:GG! <C-r>"<C-b><CR>
endif

" Switch focus
" not a good thing to remap because it is also used as <C-i>
" nnoremap <tab>      <C-w>w
" nnoremap <s-tab>    <C-w>W

if exists(':Goyo')
  let g:which_key_map.k.z = 'Toggle zen mode'
  nmap <leader>kz :Goyo<cr>:echo "Zen mode"<cr>
end

if exists(':EasyAlign')
  " Start interactive EasyAlign in visual mode (e.g. vipga)
  xmap ga <Plug>(EasyAlign)
  " Start interactive EasyAlign for a motion/text object (e.g. gaip)
  nmap ga <Plug>(EasyAlign)
endif

" if exists(':bnext')
"   let g:which_key_map.b = { 'name': '+Buffer' } 
"   let g:which_key_map.b.n = 'Next buffer'
"   let g:which_key_map.b.p = 'Previous buffer'
"   nnoremap <silent> <leader>bp :bprev<CR>
"   nnoremap <silent> <leader>bn :bnext<CR>

"   let g:which_key_map.b.l = 'List buffers'
"   nnoremap <silent> <leader>bl :Clap buffers<cr>
" endif

" if exists(':term')
"   if executable('nnn')
"     let g:which_key_map.a.n = 'nnn'
"     nnoremap <silent> <leader>an :tabnew<CR><Esc>:term env EDITOR=nvr nnn<CR>
"   endif
"   if executable('tig')
"     let g:which_key_map.a.t = 'tig log'
"     let g:which_key_map.a.s = 'tig status'
"     nnoremap <silent> <leader>at :tabnew<CR><Esc>:term tig<CR>
"     nnoremap <silent> <leader>as :tabnew<CR><Esc>:term tig status<CR>
"   endif
"   if executable('ranger')
"     let g:which_key_map.a.r = 'ranger'
"     nnoremap <silent> <leader>ar :tabnew<CR><Esc>:term ranger<CR>
"   endif
" endif

if exists(':CocAction')
  let g:which_key_map.c.c = 'Show commands'
  let g:which_key_map.c.d = 'Show errors'
  let g:which_key_map.c.f = 'Format'
  let g:which_key_map.c.r = 'Rename symbol...'
  let g:which_key_map.c.a = 'Actions'
  let g:which_key_map.c.h = 'Show hover'
  let g:which_key_map.c.s = 'Edit snippets'

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

  " like ctrl-dot in vscode
  vnoremap gA :CocAction<cr>
  nnoremap gA :CocAction<cr>

  " Rename
  nmap <leader>cr <Plug>(coc-rename)
  xmap <leader>cr <Plug>(coc-rename)

  nnoremap <leader>ca :CocAction<CR>
  nnoremap <leader>cc :CocCommand<CR>
  nnoremap <leader>cd :CocList diagnostics<CR>
  nnoremap <leader>cs :CocList snippets<CR>
endif

" Macros
let g:which_key_map.c.m = { 'name': '+Macros' }
let g:which_key_map.c.m.f = 'JS arrow-func to func-decl'
nnoremap <leader>cmf ^/const<cr>cwfunction<esc>f=xxf=xxx^
let g:which_key_map.c.m.d = 'Date (Sun 1 Apr)'
nnoremap <leader>cmd a<C-r>=strftime('%a %e %b')<cr>

" Quickfix
nnoremap <F2> :cclose<CR>
nnoremap <F4> :cnext<CR>

" Location list
nnoremap <S-F2> :lclose<CR>
nnoremap <S-F3> :lprev<CR>
nnoremap <S-F4> :lnext<CR>

let g:which_key_map.f.y = 'Copy current path'
nnoremap <leader>fy :let @+=@% \| echo '[' .  getcwd() . '] → ' . @%<cr>

let g:which_key_map.f.Y = 'Copy full path'
nnoremap <leader>fY :let @+=expand('%:p') \| echo '→ ' . expand('%:p')<cr>

augroup keys
  autocmd FileType markdown nnoremap <buffer> <leader>mv :MarkdownPreview<cr>
  autocmd FileType markdown nnoremap <buffer> <leader>mp :call mdip#MarkdownClipboardImage()<cr>
augroup END

" For autocmds
let g:which_key_labels = {
  \ 'MarkdownPreview': 'Markdown preview',
  \ 'call mdip#MarkdownClipboardImage()': 'Paste image',
  \ }

if exists(':ContextToggle')
  let g:which_key_map.k.c = 'Toggle context'
  nnoremap <leader>kc :ContextToggle<cr>
endif

function keys#switch_to_term()
  let buf = bufnr('term')
  if buf == -1 | return | endif

  let win = bufwinnr(buf)
  if win == -1 | return | endif

  exe win 'wincmd w'
endfunction

" nnoremap <F1> :1wincmd w<cr>
" nnoremap <F2> :2wincmd w<cr>
" nnoremap <F3> :3wincmd w<cr>
" nnoremap <F4> :4wincmd w<cr>
" nnoremap <F5> :5wincmd w<cr>
" nnoremap <F6> :6wincmd w<cr>

" inoremap <F1> <Esc>:1wincmd w<cr>
" inoremap <F2> <Esc>:2wincmd w<cr>
" inoremap <F3> <Esc>:4wincmd w<cr>
" inoremap <F4> <Esc>:4wincmd w<cr>
" inoremap <F5> <Esc>:5wincmd w<cr>
" inoremap <F6> <Esc>:6wincmd w<cr>

" tnoremap <F1> <C-\><C-n>:1wincmd w<cr>
" tnoremap <F2> <C-\><C-n>:2wincmd w<cr>
" tnoremap <F3> <C-\><C-n>:3wincmd w<cr>
" tnoremap <F4> <C-\><C-n>:4wincmd w<cr>
" tnoremap <F5> <C-\><C-n>:5wincmd w<cr>
" tnoremap <F6> <C-\><C-n>:6wincmd w<cr>

" " Switch panes
" let g:which_key_map['0'] = 'which_key_ignore'
" let g:which_key_map['1'] = 'which_key_ignore'
" let g:which_key_map['2'] = 'which_key_ignore'
" let g:which_key_map['3'] = 'which_key_ignore'
" let g:which_key_map['4'] = 'which_key_ignore'
" let g:which_key_map['5'] = 'which_key_ignore'
" let g:which_key_map['6'] = 'which_key_ignore'
" let g:which_key_map['7'] = 'which_key_ignore'
" let g:which_key_map['8'] = 'which_key_ignore'
" let g:which_key_map['9'] = 'which_key_ignore'
" let g:which_key_map['<Up>']    = 'which_key_ignore'
" let g:which_key_map['<Down>']  = 'which_key_ignore'
" let g:which_key_map['<Left>']  = 'which_key_ignore'
" let g:which_key_map['<Right>'] = 'which_key_ignore'
" nnoremap <silent> <leader>0 <C-w>b
" nnoremap <silent> <leader>1 :1wincmd w<cr>
" nnoremap <silent> <leader>2 :2wincmd w<cr>
" nnoremap <silent> <leader>3 :3wincmd w<cr>
" nnoremap <silent> <leader>4 :4wincmd w<cr>
" nnoremap <silent> <leader>5 :5wincmd w<cr>
" nnoremap <silent> <leader>6 :6wincmd w<cr>
" nnoremap <silent> <leader>7 :7wincmd w<cr>
" nnoremap <silent> <leader>8 :8wincmd w<cr>
" nnoremap <silent> <leader>9 :9wincmd w<cr>
" nnoremap <silent> <leader><Up>    :silent wincmd k<cr>
" nnoremap <silent> <leader><Down>  :silent wincmd j<cr>
" nnoremap <silent> <leader><Left>  :silent wincmd h<cr>
" nnoremap <silent> <leader><Right> :silent wincmd l<cr>

" Which key for enter
let g:which_key_cr = {
  \ '1': 'Pane 1',
  \ '2': 'Pane 2',
  \ '3': 'Pane 3',
  \ '4': 'Pane 4',
  \ '5': 'Pane 5',
  \ '6': 'Pane 6',
  \ '9': 'Pane 9',
  \ 'n': 'New',
  \ 'o': 'Only',
  \ 's': 'Split horiz',
  \ 't': 'Tab',
  \ 'v': 'Split vert',
  \ 'x': 'Close',
  \ 'X': 'Force-close',
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
  \ }

nnoremap <silent> <cr><Space> za
nnoremap <silent> <cr>9 :FloatermToggle<cr>
nnoremap <silent> <cr>1 :1wincmd w<cr>
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
nnoremap <silent> <cr>K :silent wincmd K<cr>
nnoremap <silent> <cr>J :silent wincmd J<cr>
nnoremap <silent> <cr>H :silent wincmd H<cr>
nnoremap <silent> <cr>L :silent wincmd L<cr>
nnoremap <silent> <cr>x :q<cr>
nnoremap <silent> <cr>X :bwipe!<cr>

nnoremap <silent> <CR> :exec ":WhichKey '\<CR\>'"<CR>

if exists(':ChooseWin')
  nmap <C-b>q <Plug>(choosewin)

  " let g:which_key_map.s = 'Switch to...'
  " nmap <leader>s <Plug>(choosewin)
  " nmap <Tab> <Plug>(choosewin)
endif

if exists(':GitGutterToggle')
  nnoremap <silent> yog :GitGutterToggle<cr>
  nnoremap <silent> cog :GitGutterToggle<cr>
endif

" close
nnoremap <Backspace> <C-w>q
nnoremap <Del> :bwipe!<CR>
nnoremap <S-Del> :qa<CR>
nnoremap <S-Del><S-Del> :qa!<CR>

" g customisations
vnoremap gs :s~~
nnoremap gs :%s~~

" Folding
nnoremap + za

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
let g:which_key_map.q = { 'name': '+Quit     ▶' }

if $GIT_EXEC_PATH != ''
  nnoremap <C-s> :wq<cr>
  inoremap <C-s> <esc>:wq<cr>
else
  nnoremap <C-s> :w<cr>
  inoremap <C-s> <esc>:w<cr>
endif

" File
let g:which_key_map.f.s = 'Save without formatting'
let g:which_key_map.f.a = 'Save'
nnoremap <leader>fs :noa w<cr>
nnoremap <leader>fa :w<cr>

" Close
let g:which_key_map.q.q = 'Quit vim'
let g:which_key_map.q.Q = 'Quit vim (force)'
let g:which_key_map.q.w = 'Close window'
let g:which_key_map.q.W = 'Close window (force)'
nnoremap <leader>qa :qa<cr>
nnoremap <leader>qq :qa<cr>
nnoremap <leader>qQ :cq<cr>
nnoremap <leader>qw :q<cr>
nnoremap <leader>qW :bwipe!<cr>

if exists(':Startify')
  let g:which_key_map.q.a = 'Close all'
  nnoremap <leader>qa :tabonly<cr>:StartifyReset<cr>
endif

" Window
let g:which_key_map.w.q = 'Close window'
let g:which_key_map.w.Q = 'Close everything'
nnoremap <silent> <leader>wq <C-w>q<CR>
nnoremap <silent> <leader>wQ :bufdo bwipe!<CR>

let g:which_key_map.w.q = 'Close others'
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
nnoremap <silent> <leader>ws <C-w>s<CR>
nnoremap <silent> <leader>wv <C-w>v<CR>

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
  let g:which_key_map.g.s = 'Status'
  let g:which_key_map.g.c = 'Commit'
  let g:which_key_map.g.C = 'Add and commit'
  let g:which_key_map.g.A = 'Amend commit'
  let g:which_key_map.g.b = 'Blame'
  let g:which_key_map.g.h = 'Open in GitHub'
  let g:which_key_map.g.y = 'Copy GitHub URL'
  let g:which_key_map.g.d = 'cd to Git root'
  let g:which_key_map.g.D = 'cd to Git root (global)'

  nnoremap <leader>gs :tabnew<cr>:Gstatus<cr><C-W>o
  nnoremap <leader>gc :Gcommit -v<cr>
  nnoremap <leader>gC :Gcommit -av<cr>
  nnoremap <leader>gA :Gcommit --amend -av<cr>
  nnoremap <leader>gb :Gblame<cr>
  nnoremap <leader>gh :Gbrowse<cr>
  nnoremap <leader>gy :Gbrowse!<cr>
  nnoremap <leader>gd :Glcd<cr>
  nnoremap <leader>gD :Gcd<cr>
  vnoremap <leader>gy :Gbrowse!<cr>

  if exists(':Dispatch')
    let g:which_key_map.g.p = 'Push'
    let g:which_key_map.g.P = 'Push (force)'
    let g:which_key_map.g.H = 'Open pull request'
    nnoremap <leader>gp :Dispatch git push<cr>
    nnoremap <leader>gP :Dispatch git push --force-with-lease --set-upstream origin (git rev-parse --abbrev-ref HEAD)<cr>
    nnoremap <leader>gH :Dispatch gh pr view --web<cr>
  endif
endif

if exists(':Magit')
  " Automatically bound by the plugin
  let g:which_key_map.M = 'which_key_ignore'

  let g:which_key_map.g.m = 'Magit...'
  nnoremap <leader>gm :Magit<cr>
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
  let g:which_key_map.k.b = 'List buffers'
  let g:which_key_map.k.b = 'History'
  nnoremap <leader>kb :Buffers<cr>
  nnoremap <leader>kh :History<cr>
endif

if exists(':FZF')
  nnoremap <C-p> :Files<cr>
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

if exists(':tabclose')
  let g:which_key_map.t.s = 'Shell in new tab'
  let g:which_key_map.t.n = 'New tab'
  let g:which_key_map.t.c = 'Close tab'
  nnoremap <leader>tc :tabclose<cr>
  nnoremap <leader>tn :tabnew<cr><Esc>:Startify<cr>
  nnoremap <leader>ts :tabnew<cr><Esc>:term<cr>
endif

if exists(':Startify')
  let g:which_key_map.k.w = 'Close all'
  nnoremap <leader>kw :tabonly<cr>:StartifyReset<cr>
endif

let g:which_key_map.f.r = 'Revert file'
nnoremap <leader>fr :e!<CR>

" if exists(':q')
"   let g:which_key_map.f.x = 'Quit vim...'
"   let g:which_key_map.f.X = 'Quit vim!'
"   nnoremap <leader>fx :qa<CR>
"   nnoremap <leader>fX :qa!<CR>
" endif

if exists(':Quickterm')
  let g:which_key_map["'"] = 'Terminal'
  nnoremap <leader>' :Quickterm<CR>
  " Like vscode
  nnoremap <C-j> :Quickterm<CR>
endif

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
    let g:which_key_map.t.r = 'Repeat command'
    nnoremap <leader>tr :w<cr>:call keys#switch_to_term()<cr><C-\><C-n>a<Up><CR><C-\><C-n><C-w>p
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
  nnoremap <silent> - :exec 'e '.expand('%:h')<CR>
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

" Quickfix
nnoremap <F2> :cclose<CR>
nnoremap <F3> :cprev<CR>
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

nnoremap <F1> :1wincmd w<cr>
nnoremap <F2> :2wincmd w<cr>
nnoremap <F3> :3wincmd w<cr>
nnoremap <F4> :4wincmd w<cr>
nnoremap <F5> :5wincmd w<cr>
nnoremap <F6> :6wincmd w<cr>

inoremap <F1> <Esc>:1wincmd w<cr>
inoremap <F2> <Esc>:2wincmd w<cr>
inoremap <F3> <Esc>:4wincmd w<cr>
inoremap <F4> <Esc>:4wincmd w<cr>
inoremap <F5> <Esc>:5wincmd w<cr>
inoremap <F6> <Esc>:6wincmd w<cr>

tnoremap <F1> <C-\><C-n>:1wincmd w<cr>
tnoremap <F2> <C-\><C-n>:2wincmd w<cr>
tnoremap <F3> <C-\><C-n>:3wincmd w<cr>
tnoremap <F4> <C-\><C-n>:4wincmd w<cr>
tnoremap <F5> <C-\><C-n>:5wincmd w<cr>
tnoremap <F6> <C-\><C-n>:6wincmd w<cr>

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

nnoremap <silent> <cr> <C-w>
nnoremap <silent> <cr><cr> za
nnoremap <silent> <cr>1 :1wincmd w<cr>
nnoremap <silent> <cr>2 :2wincmd w<cr>
nnoremap <silent> <cr>3 :3wincmd w<cr>
nnoremap <silent> <cr>4 :4wincmd w<cr>
nnoremap <silent> <cr>5 :5wincmd w<cr>
nnoremap <silent> <cr>6 :6wincmd w<cr>
nnoremap <silent> <cr>7 :7wincmd w<cr>
nnoremap <silent> <cr>8 :8wincmd w<cr>
nnoremap <silent> <cr>9 :9wincmd w<cr>
nnoremap <silent> <cr>, :Buffers<cr>
nnoremap <silent> <cr><Home>  gT
nnoremap <silent> <cr><End>   gt
nnoremap <silent> <cr><Up>    :silent wincmd k<cr>
nnoremap <silent> <cr><Down>  :silent wincmd j<cr>
nnoremap <silent> <cr><Left>  :silent wincmd h<cr>
nnoremap <silent> <cr><Right> :silent wincmd l<cr>
nnoremap <silent> <cr>n :silent wincmd n<cr>
nnoremap <silent> <cr>v :silent wincmd v<cr>
nnoremap <silent> <cr>s :silent wincmd s<cr>
nnoremap <silent> <cr>0<Up>    :silent wincmd K<cr>
nnoremap <silent> <cr>0<Down>  :silent wincmd J<cr>
nnoremap <silent> <cr>0<Left>  :silent wincmd H<cr>
nnoremap <silent> <cr>0<Right> :silent wincmd L<cr>
nnoremap <silent> <cr>0t       :silent tabnew<cr>

if exists(':ChooseWin')
  nmap <C-b>q <Plug>(choosewin)

  " let g:which_key_map.s = 'Switch to...'
  " nmap <leader>s <Plug>(choosewin)
  " nmap <Tab> <Plug>(choosewin)
endif

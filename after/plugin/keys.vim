let g:which_key_map = {}
let g:which_key_map.f = { 'name': '+File' }
let g:which_key_map.a = { 'name': '+Apps' }
let g:which_key_map.f.e = { 'name': '+Settings' }
let g:which_key_map.k = { 'name': '+Editor' }
let g:which_key_map.g = { 'name': '+Git' }
let g:which_key_map.t = { 'name': '+Tabs' }
let g:which_key_map.c = { 'name': '+COC' }

nnoremap <Enter> za
nnoremap <S-Enter> zO
nnoremap <C-Enter> zC

if $GIT_AUTHOR_DATE != ''
  nnoremap <C-s> :wq<cr>
  inoremap <C-s> <esc>:wq<cr>
else
  nnoremap <C-s> :w<cr>
  inoremap <C-s> <esc>:w<cr>
endif

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
  let g:which_key_map.g.o = 'Open in GitHub'
  let g:which_key_map.g.y = 'Copy GitHub URL'
  let g:which_key_map.g.d = 'cd to Git root'
  let g:which_key_map.g.D = 'cd to Git root (global)'

  nnoremap <leader>gs :tabnew<cr>:Gstatus<cr><C-W>o
  nnoremap <leader>gc :Gcommit -v<cr>
  nnoremap <leader>gC :Gcommit -av<cr>
  nnoremap <leader>gA :Gcommit --amend -av<cr>
  nnoremap <leader>gb :Gblame<cr>
  nnoremap <leader>go :Gbrowse<cr>
  nnoremap <leader>gy :Gbrowse!<cr>
  nnoremap <leader>gd :Glcd<cr>
  nnoremap <leader>gD :Gcd<cr>
endif

if exists(':GV')
  let g:which_key_map.g.l = 'Log'
  nnoremap <leader>gl :GV<cr>
endif

if exists(':Clap')
  let g:which_key_map.k.b = 'List buffers'
  let g:which_key_map.k.h = 'History'
  nnoremap <leader>kb :Clap buffers<cr>
  nnoremap <leader>kh :Clap history<cr>

  let g:which_key_map.f.r = 'Recent files'
  let g:which_key_map.f.f = 'Files'
  let g:which_key_map.f.g = 'Modified files'
  nnoremap <leader>fr :Clap history<cr>
  nnoremap <leader>ff :Clap files<cr>
  nnoremap <leader>fg :Clap git_diff_files<cr>

  nnoremap <C-p> :Clap files<cr>
elseif exists(':Buffers')
  let g:which_key_map.k.b = 'List buffers'
  nnoremap <leader>kb :Buffers<cr>
endif

if exists(':tabclose')
  let g:which_key_map.t.n = 'New tab'
  let g:which_key_map.t.c = 'Close tab'
  nnoremap <leader>tc :tabclose<cr>
  nnoremap <leader>tn :tabnew<cr><Esc>:Startify<cr>
endif

if exists(':Startify')
  let g:which_key_map.k.w = 'Close all'
  nnoremap <leader>kw :tabonly<cr>:StartifyReset<cr>
endif

if exists(':q')
  let g:which_key_map.f.x = 'Quit vim...'
  let g:which_key_map.f.X = 'Quit vim!'
  nnoremap <leader>fx :qa<CR>
  nnoremap <leader>fX :qa!<CR>
endif

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

  let g:which_key_map.t['.'] = 'Open terminal'
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

if exists(':NERDTree')
  nnoremap - :silent! NERDTreeFind<CR>
  nnoremap _ :Glcd<CR>:silent! NERDTreeFind<CR>
endif

if exists(':GG')
  let g:which_key_map['*'] = 'Search'
  let g:which_key_map['/'] = 'Search...'
  nnoremap <leader>/  :GG!<space>
  nnoremap <leader>*  :GG! <C-r><C-w><CR>
  vnoremap <leader>*  y:GG! <C-r>"<C-b><CR>
endif

" if exists(':bnext')
"   nnoremap <tab>      :bnext<cr>
"   nnoremap <s-tab>    :bprev<cr>
" endif

" Switch focus
nnoremap <tab>      <C-w>w
nnoremap <s-tab>    <C-w>W

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

if exists(':term')
  if executable('nnn')
    let g:which_key_map.a.n = 'nnn'
    let g:which_key_map.a.N = 'which_key_ignore'
    nnoremap <silent> <leader>an :term EDITOR=e nnn<CR>
    nnoremap <silent> <leader>aN :tabnew<CR><Esc>:term nnn<CR>
  endif

  if executable('tig')
    let g:which_key_map.a.s = 'tig status'
    let g:which_key_map.a.S = 'which_key_ignore'
    nnoremap <silent> <leader>as :term tig status<CR>
    nnoremap <silent> <leader>aS :tabnew<CR><Esc>:term tig status<CR>
  endif

  if executable('ranger')
    let g:which_key_map.a.r = 'ranger'
    let g:which_key_map.a.R = 'which_key_ignore'
    nnoremap <silent> <leader>ar :term ranger<CR>
    nnoremap <silent> <leader>aR :tabnew<CR><Esc>:term ranger<CR>
  endif
endif

if exists(':CocAction')
  let g:which_key_map.c.c = 'Show commands'
  let g:which_key_map.c.d = 'Show errors'
  let g:which_key_map.c.f = 'Format'
  let g:which_key_map.c.r = 'Rename symbol...'
  let g:which_key_map.c.a = 'Actions'
  let g:which_key_map.c.s = 'Edit snippets'

  " https://github.com/neoclide/coc.nvim#example-vim-configuration
  inoremap <silent><expr> <c-space> coc#refresh()

  " Go to...
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Hover
  nnoremap <silent> gh :call CocActionAsync('highlight')<CR>:call CocAction('doHover')<CR>

  " format region
  xmap <leader>cf <Plug>(coc-format-selected)
  nmap <leader>cf <Plug>(coc-format-selected)

  " code action
  xmap <leader>ca <Plug>(coc-codeaction-selected)
  nmap <leader>ca <Plug>(coc-codeaction-selected)

  " like ctrl-dot in vscode
  vnoremap g0 :CocAction<cr>
  nnoremap g0 :CocAction<cr>

  " Rename
  nmap <leader>cr <Plug>(coc-rename)
  xmap <leader>cr <Plug>(coc-rename)

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

nnoremap <leader>fy :let @+=@% \| echo @%<cr>

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


" Kinda like ctrl-1 and ctrl-2
let g:which_key_map.1 = 'which_key_ignore'
let g:which_key_map.2 = 'which_key_ignore'
let g:which_key_map.3 = 'which_key_ignore'
let g:which_key_map.4 = 'which_key_ignore'
let g:which_key_map.5 = 'which_key_ignore'
let g:which_key_map.6 = 'which_key_ignore'
let g:which_key_map.7 = 'which_key_ignore'

nnoremap <F1> <C-w>t
nnoremap <F2> <C-w>t<C-w>w
nnoremap <F3> <C-w>t<C-w>w<C-w>w
nnoremap <F4> <C-w>t<C-w>w<C-w>w<C-w>w
nnoremap <F5> <C-w>t<C-w>w<C-w>w<C-w>w<C-w>w

tnoremap <F1> <C-\><C-n><C-w>t
tnoremap <F2> <C-\><C-n><C-w>t<C-w>w
tnoremap <F3> <C-\><C-n><C-w>t<C-w>w<C-w>w
tnoremap <F4> <C-\><C-n><C-w>t<C-w>w<C-w>w<C-w>w
tnoremap <F5> <C-\><C-n><C-w>t<C-w>w<C-w>w<C-w>w<C-w>w

nnoremap <S-F1> gt
nnoremap <S-F2> gT

nnoremap <leader>1 <C-w>t
nnoremap <leader>2 <C-w>t<C-w>w
nnoremap <leader>3 <C-w>t<C-w>w<C-w>w
nnoremap <leader>4 <C-w>t<C-w>w<C-w>w<C-w>w
nnoremap <leader>5 <C-w>t<C-w>w<C-w>w<C-w>w<C-w>w

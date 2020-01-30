let g:which_key_map = {}
let g:which_key_map.f = { 'name': '+File' }
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
nnoremap <leader>fek :tabnew<cr>:e ~/.config/nvim/after/plugin/keys.vim<cr>
nnoremap <leader>fec :tabnew<cr>:e ~/.config/nvim/after/plugin/customizations.vim<cr>
nnoremap <leader>fei :tabnew<cr>:e ~/.config/nvim/init.vim<cr>
nnoremap <leader>fet :tabnew<cr>:e ~/.config/nvim/modules/dynamic-theme/autoload/dyntheme.vim<cr>

if exists(':Gstatus')
  let g:which_key_map.g.s = 'Status'
  let g:which_key_map.g.c = 'Commit'
  let g:which_key_map.g.C = 'Add and commit'
  let g:which_key_map.g.b = 'Blame'
  let g:which_key_map.g.o = 'Open in GitHub'
  let g:which_key_map.g.y = 'Copy GitHub URL'

  let g:which_key_map.g.t = { 'name': '+Tig' }
  let g:which_key_map.g.t.s = 'Status'
  nnoremap <leader>gs :tabnew<cr>:Gstatus<cr><C-W>o
  nnoremap <leader>gts :tabnew<cr>:term tig status<cr>
  nnoremap <leader>gc :Gcommit -v<cr>
  nnoremap <leader>gC :Gcommit -av<cr>
  nnoremap <leader>gb :Gblame<cr>
  nnoremap <leader>go :Gbrowse<cr>
  nnoremap <leader>gy :Gbrowse!<cr>
endif

if exists(':GV')
  let g:which_key_map.g.l = 'Log'
  nnoremap <leader>gl :GV<cr>
endif

if exists(':Buffers')
  let g:which_key_map.k.b = 'List buffers'
  nnoremap <leader>kb :Buffers<cr>
endif

if exists(':tabclose')
  let g:which_key_map.t.n = 'New tab'
  let g:which_key_map.t.c = 'Close tab'
  let g:which_key_map.t['.'] = 'Open terminal'
  nnoremap <leader>tc :tabclose<cr>
  nnoremap <leader>tn :tabnew<cr>:Startify<cr>
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
endif

if exists(':term')
  " Different ways to escape
  tnoremap <C-b><C-n> <C-\><C-n>
  tnoremap <C-]> <C-\><C-n>
  tnoremap <C-[> <C-\><C-n>

  tnoremap <C-b><C-x> <C-\><C-n>:q!<CR>
  nnoremap <leader>t. :term<CR>
endif

if exists(':NERDTree')
  nnoremap - :Gcd<CR>:silent! NERDTreeFind<CR>
  nnoremap _ :NERDTreeVCS<CR>
endif

if exists(':GG')
  let g:which_key_map['*'] = 'Search'
  let g:which_key_map['/'] = 'Search...'
  nnoremap <leader>/  :VG!<space>
  nnoremap <leader>*  :VG! <C-r><C-w><CR>
  vnoremap <leader>*  y:VG! <C-r>"<C-b><CR>
endif

if exists(':Files')
  nnoremap <C-p>      :Gcd<cr>:Files<cr>
  nnoremap <tab>      :bnext<cr>
  nnoremap <s-tab>    :bprev<cr>
endif

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

if exists(':CocAction')
  let g:which_key_map.c.c = 'Show commands'
  let g:which_key_map.c.d = 'Show errors'
  let g:which_key_map.c.f = 'Format'
  let g:which_key_map.c.r = 'Rename symbol...'
  let g:which_key_map.c.a = 'Actions'

  " https://github.com/neoclide/coc.nvim#example-vim-configuration
  inoremap <silent><expr> <c-space> coc#refresh()

  " Go to...
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Hover
  nnoremap <silent> gh :call CocAction('doHover')<CR>

  " format region
  xmap <leader>cf <Plug>(coc-format-selected)
  nmap <leader>cf <Plug>(coc-format-selected)

  " code action
  xmap <leader>ca <Plug>(coc-codeaction-selected)
  nmap <leader>ca <Plug>(coc-codeaction-selected)

  " Rename
  nmap <leader>cr <Plug>(coc-rename)
  xmap <leader>cr <Plug>(coc-rename)

  nnoremap <leader>cc :CocCommand<CR>
  nnoremap <leader>cd :CocList diagnostics<CR>
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
augroup END

" For autocmds
let g:which_key_labels = {
  \ 'MarkdownPreview': 'Markdown preview',
  \ }

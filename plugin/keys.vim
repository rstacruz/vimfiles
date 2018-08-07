" Buffer navigation
nnoremap <C-H> :bprev<CR>
nnoremap <C-L> :bnext<CR>
inoremap <C-H> <Esc>:bprev<CR>
inoremap <C-L> <Esc>:bnext<CR>

"" [N] <CR> -- Open fold
nnoremap <Enter> za

"" [N] <leader>T -- Tab: open a new tab
nnoremap <leader>T :tabnew<cr>

"" [N] <leader>as -- Apps: show scope
" Useful for creating color schemes
nmap <Leader>as :echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')<CR>

"" [N] <leader>as -- Apps: show scope
" Useful for creating color schemes
nmap <Leader>as :echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')<CR>

"" [N] - -- Open tree
nnoremap - :NERDTreeFind<CR>

if globpath(&rtp, "plugin/NERD_tree.vim") != ""
  "" [N] - -- Open tree
  nnoremap - :NERDTreeFind<CR>

  " [N] <leader>pt -- Project: open tree
  nnoremap <leader>pt :NERDTreeFind<CR>
endif

if globpath(&rtp, "plugin/ale.vim") != ""
  "" [N] <Leader>ef -- Errors: run formatter
  nmap <Leader>ef <Plug>(ale_fix)

  "" [N] <Leader>ev -- Errors: verify ale setup
  "" [N] <Leader>en -- Errors: next
  "" [N] <Leader>ep -- Errors: previous
  "" [N] <Leader>ec -- Errors: clear errors
  nnoremap <Leader>ev :ALEVerify<CR>
  nnoremap <Leader>en :ALENextWrap<CR>
  nnoremap <Leader>ep :ALEPreviousWrap<CR>
  nnoremap <Leader>eN :ALEPreviousWrap<CR>
  nnoremap <Leader>ec :ALEResetBuffer<CR>
endif

if globpath(&rtp, "plugin/commentary.vim") != ""
  "" [V] /  -- Commentary: comment selection
  "" [N] gc  -- Commentary: comment line
  vmap / gc
endif

if globpath(&rtp, "plugin/easymotion.vim") != ""
  "" [N] <leader>.k -- Easymotion: jump to a line above
  "" [N] <leader>.j -- Easymotion: jump to a line below
  "" [N] <leader>.f -- Easymotion: jump to a character above
  "" [N] <leader>.F -- Easymotion: jump to a character below
  map <leader>. <Plug>(easymotion-prefix)
endif

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
nnoremap <leader>fek :tabnew<cr>:e ~/.config/nvim/after/plugin/keys.vim<cr>
nnoremap <leader>fec :tabnew<cr>:e ~/.config/nvim/after/plugin/customizations.vim<cr>
nnoremap <leader>fei :tabnew<cr>:e ~/.config/nvim/init.vim<cr>
nnoremap <leader>fet :tabnew<cr>:e ~/.config/nvim/modules/dynamic-theme/plugin/theme.vim<cr>

if exists(':Gstatus')
  nnoremap <leader>gs :tabnew<cr>:Gstatus<cr><C-W>o
  nnoremap <leader>gts :tabnew<cr>:term tig status<cr>
  nnoremap <leader>gc :Gcommit -v<cr>
  " nnoremap <leader>gl :Glog<cr>
  nnoremap <leader>gb :Gblame<cr>
  nnoremap <leader>go :Gbrowse<cr>
  nnoremap <leader>gO :Gbrowse!<cr>
endif

if exists(':GV')
  nnoremap <leader>gl :GV<cr>
endif

if exists(':Buffers')
  nnoremap <leader>bb :Buffers<cr>
endif

if exists(':tabclose')
  nnoremap <leader>tc :tabclose<cr>
  nnoremap <leader>tn :tabnew<cr>:Startify<cr>
endif

if exists(':Startify')
  nnoremap <leader>sc :tabonly<cr>:StartifyReset<cr>
  " nnoremap <leader>sc :tabonly<cr>:SClose<cr>
  " nnoremap <leader>st :only<cr>:Startify<cr>
  " nnoremap <leader>sT :tabonly<cr>:only<cr>:Startify<cr>
endif

if exists(':q')
  nnoremap <leader>qa :qa<CR>
  nnoremap <leader>qA :qa!<CR>
  nnoremap <leader>qc :cq!<CR>
endif

if exists(':Quickterm')
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
  nnoremap - :Gcd<CR>:NERDTreeFind<CR>
  nnoremap _ :NERDTreeVCS<CR>
endif

if exists(':GG')
  nnoremap <leader>/  :VG<space>
  nnoremap <leader>*  :VG <C-r><C-w><CR>
  vnoremap <leader>*  y:VG <C-r>"<C-b><CR>
endif

if exists(':Files')
  nnoremap <C-p>      :Gcd<cr>:Files<cr>
  nnoremap <tab>      :bnext<cr>
  nnoremap <s-tab>    :bprev<cr>
endif

if exists(':EasyAlign')
  " Start interactive EasyAlign in visual mode (e.g. vipga)
  xmap ga <Plug>(EasyAlign)
  " Start interactive EasyAlign for a motion/text object (e.g. gaip)
  nmap ga <Plug>(EasyAlign)
endif

if exists(':CocAction')
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

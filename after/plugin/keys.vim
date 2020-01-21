nnoremap <Enter> za
nnoremap <S-Enter> zO
nnoremap <C-Enter> zC
nnoremap <C-s> :w<cr>

if exists(':NERDTree')
  nnoremap - :Gcd<CR>:NERDTreeFind<CR>
  nnoremap _ :NERDTreeVCS<CR>
endif

if exists(':Files')
  nnoremap <C-p>      :Gcd<cr>:Files<cr>
  nnoremap <leader>bb :Buffers<cr>
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

  nnoremap <leader>cd :CocList diagnostics<CR>
endif


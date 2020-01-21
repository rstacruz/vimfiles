if exists(':NERDTree')
  nnoremap - :Gcd<CR>:NERDTreeFind<CR>
  nnoremap _ :NERDTreeVCS<CR>
endif

nnoremap <Enter> za
nnoremap <S-Enter> zO
nnoremap <C-Enter> zC

if exists(':Files')
  nnoremap <C-p> :Gcd<cr>:Files<cr>
endif

nnoremap <C-s> :w<cr>

nnoremap <leader>bb :Buffers<cr>
nnoremap <tab> :bnext<cr>
nnoremap <s-tab> :bprev<cr>

if exists(':EasyAlign')
  " Start interactive EasyAlign in visual mode (e.g. vipga)
  xmap ga <Plug>(EasyAlign)

  " Start interactive EasyAlign for a motion/text object (e.g. gaip)
  nmap ga <Plug>(EasyAlign)
endif

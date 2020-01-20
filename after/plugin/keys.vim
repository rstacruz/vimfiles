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

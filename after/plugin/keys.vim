nnoremap <Enter> za
nnoremap <S-Enter> zO
nnoremap <C-Enter> zC
nnoremap <C-s> :w<cr>

if exists(':NERDTree')
  nnoremap - :Gcd<CR>:NERDTreeFind<CR>
  nnoremap _ :NERDTreeVCS<CR>
endif

if exists(':Gstatus')
  nnoremap <leader>gs :Gstatus<cr>
  nnoremap <leader>gc :Gcommit -v<cr>:set nonumber<cr>a
  nnoremap <leader>gl :Glog<cr>
  nnoremap <leader>gb :Gblame<cr>
  nnoremap <leader>go :Gbrowse<cr>
  nnoremap <leader>gO :Gbrowse!<cr>
end

if exists(':Files')
  nnoremap <C-p>      :Gcd<cr>:Files<cr>
  nnoremap <leader>bb :Buffers<cr>
  nnoremap <tab>      :bnext<cr>
  nnoremap <s-tab>    :bprev<cr>
  nnoremap <leader>/  :Ag<cr>
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

" Quickfix
nnoremap <F2> :cclose<CR>
nnoremap <F3> :cprev<CR>
nnoremap <F4> :cnext<CR>

" Location list
nnoremap <S-F2> :lclose<CR>
nnoremap <S-F3> :lprev<CR>
nnoremap <S-F4> :lnext<CR>

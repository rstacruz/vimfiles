augroup coffeescript
  au!
  au BufNewFile,BufReadPost *.coffee nnoremap <leader>C :CoffeeWatch vert<CR>i
  au BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable
augroup END

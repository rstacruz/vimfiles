if has("nvim")
  nnoremap <Leader>tn <C-w>n:te<CR>
  nnoremap <Leader>ts <C-w>n:te<CR>
  nnoremap <Leader>tv <C-w>v<C-w>l:te<CR>
  nnoremap <Leader>tt :tabnew<CR>:te<CR>
  nnoremap <Leader>t. :te<CR>

  " :h terminal-emulator-input
  tnoremap <C-]> <C-\><C-n>
  tnoremap <C-[> <C-\><C-n>
endif

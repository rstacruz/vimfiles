"" [N] <leader>tn -- Terminal: open in new split
"" [N] <leader>ts -- Terminal: open in new split
"" [N] <leader>tv -- Terminal: open in new vertical split
"" [N] <leader>tt -- Terminal: open in new tab
"" [N] <leader>t. -- Terminal: open here

if has("nvim")
  nnoremap <Leader>' <C-w>n:te<CR>a
  nnoremap <Leader>tn <C-w>n:te<CR>
  nnoremap <Leader>ts <C-w>n:te<CR>
  nnoremap <Leader>tv <C-w>v<C-w>l:te<CR>
  nnoremap <Leader>tt :tabnew<CR>:te<CR>
  nnoremap <Leader>t. :te<CR>

  " :h terminal-emulator-input
  tnoremap <C-]> <C-\><C-n>
  tnoremap <C-[> <C-\><C-n>
endif

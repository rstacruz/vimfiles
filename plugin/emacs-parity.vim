" Bringing some emacs into vim

" C-x C-s -- Save file
inoremap <C-x><C-s> <Esc>:w<CR>a
nnoremap <C-x><C-s> :w<CR>
inoremap <C-a> <Esc>zaa
nnoremap <C-a> za
nnoremap <CR> za

" Escape/save
inoremap <C-s> <Esc>
noremap <C-s> :w<CR>

" Bringing some emacs into vim

" C-x C-s -- Save file
inoremap <C-x><C-s> <Esc>:w<CR>a
nnoremap <C-x><C-s> :w<CR>

" [N] <leader> f e d -- File: edit config
nnoremap <leader>fed :e ~/.vimrc<CR>

"" [N] <leader>bn -- Buffer: next
"" [N] <leader>bp -- Buffer: prev
"" [N] <leader>bd -- Buffer: delete
"" [N] <leader>bD -- Buffer: delete!
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bd :bdelete<CR>
nnoremap <leader>bD :bdelete!<CR>
nnoremap <leader>bp :bprev<CR>

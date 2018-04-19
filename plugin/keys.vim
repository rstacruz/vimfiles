"
" Dvorak helpers
"

" imap ,. <Esc>
" vmap ,. <Esc>

"
" Buffer navigation
"

nnoremap <C-H> :bprev<CR>
nnoremap <C-L> :bnext<CR>
inoremap <C-H> <Esc>:bprev<CR>
inoremap <C-L> <Esc>:bnext<CR>

"
" Convenience shortcuts for window ops
"

" map <leader>j <C-W>j
" map <leader>k <C-W>k
" map <leader>h <C-W>h
" map <leader>l <C-W>l
" 
" map <leader>J <C-W>J
" map <leader>K <C-W>K
" map <leader>H <C-W>H
" map <leader>L <C-W>L
" 
" map <leader>w <C-W>w
" map <leader>n <C-W>n
" map <leader>q <C-W>q
" map <leader>s <C-W>s
" map <leader>v <C-W>v
" " map <leader>t <C-W>t
" map <leader>b <C-W>b
" map <leader>o <C-W>o
" map <leader>- <C-W>_

" Alt keys
" if has("nvim")
"   tnoremap <A-h> <C-\><C-n><C-w>h
"   tnoremap <A-j> <C-\><C-n><C-w>j
"   tnoremap <A-k> <C-\><C-n><C-w>k
"   tnoremap <A-l> <C-\><C-n><C-w>l
" endif

" nnoremap <A-h> <C-w>h
" nnoremap <A-j> <C-w>j
" nnoremap <A-k> <C-w>k
" nnoremap <A-l> <C-w>l
" 
" nnoremap <A-H> <C-w>H
" nnoremap <A-J> <C-w>J
" nnoremap <A-K> <C-w>K
" nnoremap <A-L> <C-w>L
" 
" nnoremap <A-t> <C-w>t
" nnoremap <A-b> <C-w>b
" 
" nnoremap <A-1> gT
" nnoremap <A-2> gt
" 
" nnoremap <A-[> gT
" nnoremap <A-]> gt

"" [N] <leader>c0 -- Keys: set conceallevel=0
"" [N] <leader>c2 -- Keys: set conceallevel=2

" nmap <leader>c0 :set conceallevel=0<CR>
" nmap <leader>c2 :set conceallevel=2<CR>

"
" Enter to toggle folds
"   Enter - recursive open
"   Space - toggle
"

" nnoremap <Enter> za
" nnoremap <Space> za

"" [N] <leader>T -- Tab: open a new tab
nnoremap <leader>T :tabnew<cr>

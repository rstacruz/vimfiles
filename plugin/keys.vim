"
" Dvorak helpers
"

" imap ,. <Esc>
" vmap ,. <Esc>

"
" Collapse (like on a sidebar)
"

map <leader>< <C-W>15<
map <leader>> <C-W>15>
map <leader>,, <C-W>15<
map <leader>,. <C-W>15>

"
" Buffer navigation
"

nmap <C-H> :bprev<CR>
nmap <C-L> :bnext<CR>
imap <C-H> <Esc>:bprev<CR>
imap <C-L> <Esc>:bnext<CR>

"
" Convenience shortcuts for window ops
"

map <leader>j <C-W>j
map <leader>k <C-W>k
map <leader>h <C-W>h
map <leader>l <C-W>l

map <leader>J <C-W>J
map <leader>K <C-W>K
map <leader>H <C-W>H
map <leader>L <C-W>L

map <leader>w <C-W>w
map <leader>n <C-W>n
map <leader>q <C-W>q
map <leader>s <C-W>s
map <leader>v <C-W>v
" map <leader>t <C-W>t
map <leader>b <C-W>b
map <leader>o <C-W>o
map <leader>- <C-W>_

" Alt keys
if has("nvim")
  tnoremap <A-h> <C-\><C-n><C-w>h
  tnoremap <A-j> <C-\><C-n><C-w>j
  tnoremap <A-k> <C-\><C-n><C-w>k
  tnoremap <A-l> <C-\><C-n><C-w>l
endif

nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

nnoremap <A-H> <C-w>H
nnoremap <A-J> <C-w>J
nnoremap <A-K> <C-w>K
nnoremap <A-L> <C-w>L

nnoremap <A-t> <C-w>t
nnoremap <A-b> <C-w>b

nnoremap <A-1> gT
nnoremap <A-2> gt

nnoremap <A-[> gT
nnoremap <A-]> gt

"
" Code folding options
" https://github.com/spf13/spf13-vim/blob/3.0/.vimrc#L353
"
"" [N] <leader>f0 -- Keys: set foldlevel=0
"" [N] <leader>f1 -- Keys: set foldlevel=1
nmap <leader>f0 :set foldlevel=0<CR>
nmap <leader>f1 :set foldlevel=1<CR>
nmap <leader>f2 :set foldlevel=2<CR>
nmap <leader>f3 :set foldlevel=3<CR>
nmap <leader>f4 :set foldlevel=4<CR>
nmap <leader>f5 :set foldlevel=5<CR>
nmap <leader>f6 :set foldlevel=6<CR>
nmap <leader>f7 :set foldlevel=7<CR>
nmap <leader>f8 :set foldlevel=8<CR>
nmap <leader>f9 :set foldlevel=9<CR>

"" [N] <leader>c0 -- Keys: set conceallevel=0
"" [N] <leader>c2 -- Keys: set conceallevel=2

nmap <leader>c0 :set conceallevel=0<CR>
nmap <leader>c2 :set conceallevel=2<CR>

"
" Enter to toggle folds
"   Enter - recursive open
"   Space - toggle
"

" nnoremap <Enter> za
nnoremap <Space> za

"" [N] <leader>T -- Tab: open a new tab
nnoremap <leader>T :tabnew<cr>

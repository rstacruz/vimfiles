if globpath(&rtp, "plugin/fzf.vim") == "" | finish | endif

"" [N] <C-p> -- FZF: open file
nnoremap  <C-p> :GFiles<cr>

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

"" [N] <leader><TAB> -- FZF: complete commands
"" [I] <c-x><c-f> -- FZF: complete file
"" [I] <c-x><c-j> -- FZF: complete file (via ag)
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

inoremap <expr> <c-x><c-n> fzf#vim#complete#path("git ls-files \| xargs realpath")

"" [N] <leader>bb -- FZF: buffers
"" [N] <leader>bn -- FZF: buffer, next
"" [N] <leader>bp -- FZF: buffer, prev
"" [N] <leader>bh -- FZF: history
nmap <leader>bb :Buffers<CR>
nmap <leader>bh :History<CR>
nmap <leader>bn :bnext<CR>
nmap <leader>bd :bdelete<CR>
nmap <leader>bp :bprev<CR>

"" [N] <leader>ff -- FZF: All files
"" [N] <leader>fa -- FZF: Search via ag
"" [N] <leader>fg -- FZF: Git changed files
"" [N] <leader>ft -- FZF: Search ctags
nmap <leader>ff :Files<CR>
nmap <leader>fg :GFiles?<CR>
nmap <leader>fa :Ag<CR>
nmap <leader>ft :Tags<CR>

if globpath(&rtp, "plugin/fzf.vim") == "" | finish | endif

"" [N] <C-p> -- FZF: open file
nnoremap  <C-p> :GFiles<cr>
nnoremap <leader>pf :GFiles<cr>

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

"" [N] <leader>bb -- Buffer: buffers (fzf)
"" [N] <leader>bh -- Buffer: history (fzf)
nnoremap <leader>bb :Buffers<CR>
nnoremap <leader>bh :History<CR>

"" [N] <leader>ff -- FZF: All files
"" [N] <leader>fg -- FZF: Git changed files
"" [N] <leader>ft -- FZF: Search ctags
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fg :GFiles?<CR>
nnoremap <leader>ft :Tags<CR>

"" [N] <leader>/ -- FZF: find in project
nnoremap <leader>/ :Ag<CR>

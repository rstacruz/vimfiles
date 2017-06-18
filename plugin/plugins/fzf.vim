if globpath(&rtp, "plugin/fzf.vim") == "" | finish | endif

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

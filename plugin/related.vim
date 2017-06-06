"" [N] <leader>re -- Related: show related files (tests, etc)
nnoremap <Leader>re :exe 'FZF -q ' . join(split(join(split(expand('%:t:r'), '_'), ''), '-'), '')<CR>

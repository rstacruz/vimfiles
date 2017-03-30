nnoremap <Leader>re :exe 'FZF -q ' . join(split(join(split(expand('%:t:r'), '_'), ''), '-'), '')<CR>

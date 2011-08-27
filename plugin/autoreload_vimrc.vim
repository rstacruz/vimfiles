" Auto-reload .vimrc when it's saved.
" http://vim.wikia.com/wiki/Change_vimrc_with_auto_reload

autocmd! bufwritepost .vimrc source %
autocmd! bufwritepost vimrc.vim source %

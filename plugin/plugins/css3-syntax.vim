" if globpath(&rtp, "after/syntax/scss.vim") == "" | finish | endif

" https://github.com/hail2u/vim-css3-syntax#notes
augroup VimCSS3Syntax
  autocmd!

  autocmd FileType css,scss,sass setlocal iskeyword+=-
augroup END

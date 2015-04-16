if globpath(&rtp, "syntax/ghmarkdown.vim") == ""
  finish
endif

augroup markdown
  au!
  au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END

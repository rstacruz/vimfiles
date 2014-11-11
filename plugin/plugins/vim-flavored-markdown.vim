if globpath(&rtp, "syntax/ghmarkdown.vim") != ""
  augroup markdown
      au!
      au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
  augroup END
endif

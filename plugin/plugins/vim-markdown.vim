if globpath(&rtp, "syntax/mkd.vim") == ""
  finish
endif

let g:vim_markdown_frontmatter=1

if globpath(&rtp, "ftplugin/markdown.vim") == "" | finish | endif

let g:vim_markdown_folding_style_pythonic = 1
let g:vim_markdown_frontmatter = 1

let g:vim_markdown_fenced_languages = [
  \ 'c++=cpp', 'viml=vim', 'bash=sh', 'ini=dosini',
  \ 'jsx=javascript.jsx',
  \ 'js=javascript.jsx'
  \ ]

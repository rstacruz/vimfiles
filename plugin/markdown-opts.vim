" https://github.com/plasticboy/vim-markdown
" This uses vim-markdown rather than vim-polyglot since folding and other
" features work better there.
let g:vim_markdown_fenced_languages = [
  \ 'ini=dosini',
  \ 'viml=vim',
  \ 'bash=sh',
  \ 'c\+\+=cpp',
  \ 'css',
  \ 'js=javascriptreact',
  \ ]

let g:vim_markdown_conceal = 1
let g:vim_markdown_conceal_code_blocks = 0

let g:vim_markdown_folding_style_pythonic = 1

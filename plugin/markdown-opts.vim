let g:vim_markdown_fenced_languages = [
  \ 'ini=dosini',
  \ 'viml=vim',
  \ 'bash=sh',
  \ 'c\+\+=cpp',
  \ 'css',
  \ 'js=javascriptreact',
  \ ]

" https://github.com/plasticboy/vim-markdown
let g:vim_markdown_conceal = 1
let g:vim_markdown_conceal_code_blocks = 0

augroup Vim
  au!
  au BufEnter *.md setlocal conceallevel=2
augroup END

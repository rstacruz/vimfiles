" https://github.com/plasticboy/vim-markdown
" This uses vim-markdown rather than vim-polyglot since folding and other
" features work better there.
let g:vim_markdown_fenced_languages = [
  \ 'ini=dosini',
  \ 'viml=vim',
  \ 'bash=sh',
  \ 'rb=ruby',
  \ 'c\+\+=cpp',
  \ 'css',
  \ 'js=javascriptreact',
  \ ]

" Enable conceal features
let g:vim_markdown_conceal = 1

" Don't conceal ``` in code blocks
let g:vim_markdown_conceal_code_blocks = 0

" ge: have 'ge' open in new tab
let g:vim_markdown_edit_url_in = 'tab'

" ge: automatically save after pressing 'ge'
let g:vim_markdown_autowrite = 1

" ge: follow #anchors in links
let g:vim_markdown_follow_anchor = 1

" I dunno but its cool
let g:vim_markdown_folding_style_pythonic = 1

" Disable auto-inserting bullet points
" https://github.com/plasticboy/vim-markdown#do-not-automatically-insert-bulletpoints
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_new_list_item_indent = 0

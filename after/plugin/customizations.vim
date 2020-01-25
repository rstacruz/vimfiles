" don't give |ins-completion-menu| messages.
set shortmess+=c
set noruler

if has('nvim')
  " no line number in :term
  " https://github.com/neovim/neovim/issues/6832#issuecomment-305507194
  au TermOpen * setlocal nonumber norelativenumber
  au TermOpen * startinsert
endif

au BufNewfile,BufRead COMMIT_EDITMSG startinsert

" No status when editing Git commit messages
if $GIT_AUTHOR_DATE != ''
  set laststatus=0
  set nonumber
  set norelativenumber
endif

" No line numbers on git status
au FileType fugitive setlocal nonumber norelativenumber

" Close terminal
if has('nvim')
  au TermClose *tig* silent bwipe! | silent close
endif

set cursorline

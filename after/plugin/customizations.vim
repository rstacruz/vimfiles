" don't give |ins-completion-menu| messages.
set shortmess+=c
set noruler

if has('nvim')
  " no line number in :term
  " https://github.com/neovim/neovim/issues/6832#issuecomment-305507194
  au TermOpen * setlocal nonumber norelativenumber
  au TermOpen * startinsert
endif

au BufNewfile,BufRead COMMIT_EDITMSG setlocal nonumber norelativenumber

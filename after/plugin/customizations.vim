" don't give |ins-completion-menu| messages.
set shortmess+=c
set noruler

if has('nvim')
  " no line number in :term
  " https://github.com/neovim/neovim/issues/6832#issuecomment-305507194
  au TermOpen * setlocal nonumber norelativenumber
  au TermOpen * startinsert
endif

augroup customisations
  au FileType gitcommit,pullrequest startinsert
  au FileType gitcommit,pullrequest setlocal nonumber norelativenumber
  au FileType gitcommit,pullrequest inoremap <buffer> <C-s> <Esc>:wq<cr>
  au FileType gitcommit,pullrequest noremap <buffer> <C-s> :wq<cr>
  au FileType gitcommit setlocal statusline=──\ Git\ commit\ message\ ──
  au FileType pullrequest setlocal statusline=──\ Git\ pull\ request\ ──
  au FileType markdown setlocal wrap linebreak nonumber norelativenumber
  au FileType yaml setlocal foldmethod=indent
augroup END

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
  au TermClose *tig* silent bwipe!
endif

set cursorline " highlight current line
set linebreak  " lbr: break on words

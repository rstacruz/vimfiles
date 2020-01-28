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
  au FileType gitcommit startinsert
  au FileType gitcommit setlocal nonumber norelativenumber
  au FileType gitcommit setlocal statusline=──\ Git\ commit\ message\ ──
  au FileType gitcommit inoremap <buffer> <C-s> <Esc>:wq<cr>
  au FileType gitcommit noremap <buffer> <C-s> :wq<cr>
  au FileType markdown setlocal wrap linebreak nonumber norelativenumber
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

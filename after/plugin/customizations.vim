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
au BufNewfile,BufRead COMMIT_EDITMSG setlocal nonumber norelativenumber
au BufNewfile,BufRead COMMIT_EDITMSG setlocal statusline=──\ Git\ commit\ message\ ──
au BufNewfile,BufRead COMMIT_EDITMSG inoremap <buffer> <C-s> <Esc>:wq<cr>
au BufNewfile,BufRead COMMIT_EDITMSG noremap <buffer> <C-s> :wq<cr>

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

au BufNewfile,BufRead *.md setlocal wrap linebreak

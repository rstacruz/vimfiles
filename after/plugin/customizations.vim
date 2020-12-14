" don't give |ins-completion-menu| messages.
set shortmess+=c
set noruler
set nonumber
set noshowmode " no -- INSERT -- in the status line

if has('nvim')
  " no line number in :term
  " https://github.com/neovim/neovim/issues/6832#issuecomment-305507194
  au TermOpen * setlocal nonumber norelativenumber nocursorline
  au TermOpen * startinsert
endif

augroup customisations
  au FileType gitcommit,pullrequest,gitrebase startinsert
  au FileType gitcommit,pullrequest,gitrebase setlocal nonumber norelativenumber nowrap
  if $GIT_EXEC_PATH != ''
    au FileType gitcommit,pullrequest,gitrebase inoremap <buffer> <C-s> <Esc>:wq<cr>
    au FileType gitcommit,pullrequest,gitrebase noremap <buffer> <C-s> :wq<cr>
  else
    au FileType gitcommit,pullrequest,gitrebase inoremap <buffer> <C-s> <Esc>:w<cr>:bwipeout!<cr>
    au FileType gitcommit,pullrequest,gitrebase noremap <buffer> <C-s> :w<cr>:bwipeout!<cr>
  end
  au FileType gitcommit setlocal statusline=──\ Git\ commit\ message\ ──
  au FileType pullrequest setlocal statusline=──\ Git\ pull\ request\ ──
  au FileType markdown setlocal wrap linebreak nonumber norelativenumber
  au FileType yaml setlocal foldmethod=indent
  " Allow spaces in filenames to 'gf' inside taskpaper files
  au FileType taskpaper setlocal isfname+=32,[,],' ts=2 nowrap
  au! BufRead,BufNewFile *.ttxt setfiletype taskpaper
  " Allow auto-completion of beancount accounts (eg, Assets:Bank-Stuff)
  au! BufRead,BufNewFile *.beancount setlocal iskeyword+=-,58
augroup END

" No status when editing Git commit messages
if $GIT_EXEC_PATH != ''
  set laststatus=0
endif

" No line numbers on git status
au FileType fugitive setlocal nonumber norelativenumber

" Close terminal
if has('nvim')
  au TermClose *tig* silent bwipe!
endif

set linebreak  " lbr: break on words

" Markdown tools
function! MkdnRemoveAnnotations()
  silent! %s/^###\n\n//
  silent! %s/^<!-- {.*\n\n//
endfunction

" In the rstacruz/til blog
function! MkdnConvertFigures()
  silent! %s#<figure class='cover'>\n\(.*\)\n</figure>#<Figure cover>\r\1\r</Figure>#g
  silent! %s#<figure class='table'>\n\(.*\)\n</figure>#<Figure table>\r\1\r</Figure>#g
endfunction

" Like 'gf' but creates a file if it's not there
function! OpenOrCreateFile(...)
  let fname=expand('%:h') . '/' . expand('<cfile>')
  let cmd=(a:0 == '' ? 'e' : 'split')
  silent! exec cmd . ' ' . fname
endfunction

" Typo corrections
augroup abbreviations
  au FileType typescript,typescriptreact iabbrev <buffer> conts const
  au FileType typescript,typescriptreact iabbrev <buffer> improt import
  au FileType text,markdown iabbrev <buffer> SFT ⇧
  au FileType text,markdown iabbrev <buffer> TAB ↹
  au FileType text,markdown iabbrev <buffer> OPT ⌥
  au FileType text,markdown iabbrev <buffer> CMD ⌘
  au FileType text,markdown iabbrev <buffer> SPC ␣
  au FileType text,markdown iabbrev <buffer> BSPC ⌫
augroup END

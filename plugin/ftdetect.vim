" Additional filename auto-detection schemes.

augroup filetypedetect
  au! BufNewFile,BufRead Gemfile   setf ruby
  au! BufNewFile,BufRead Thorfile  setf ruby
  au! BufNewFile,BufRead config.ru setf ruby
  au! BufNewFile,BufRead *.rake    setf ruby
  au! BufNewFile,BufRead *.thor    setf ruby
  au! BufNewFile,BufRead *.styl    setf sass
augroup END

" Auto spellcheck
if has('spell')
  au BufNewFile,BufRead COMMIT_EDITMSG setlocal spell
  au Filetype markdown setlocal spell
  au Filetype textile setlocal spell
endif

" DelimitMate sucks with these two.
au FileType scss let b:delimitMate_matchpairs="(:),[:],<:>"
au FileType css  let b:delimitMate_matchpairs="(:),[:],<:>"

au FileType html set foldmethod=indent
au FileType sass set foldmethod=indent


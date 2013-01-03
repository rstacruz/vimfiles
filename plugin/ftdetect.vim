" Additional filename auto-detection schemes.

augroup filetypedetect
  au! BufNewFile,BufRead Gemfile   setf ruby
  au! BufNewFile,BufRead Thorfile  setf ruby
  au! BufNewFile,BufRead config.ru setf ruby
  au! BufNewFile,BufRead *.rake    setf ruby
  au! BufNewFile,BufRead *.thor    setf ruby
  au! BufNewFile,BufRead *.styl    setf sass
  au! BufNewFile,BufRead *.json    setf javascript
  au! BufNewFile,BufRead *.hamljs  setf haml
augroup END

" Auto spellcheck
if has('spell')
  au BufNewFile,BufRead COMMIT_EDITMSG setlocal spell
  au Filetype markdown setlocal spell
  au Filetype textile  setlocal spell
endif

" DelimitMate sucks with these two.
au FileType scss let b:delimitMate_matchpairs="(:),[:],<:>"
au FileType css  let b:delimitMate_matchpairs="(:),[:],<:>"

au FileType html set fdm=indent
au FileType sass set fdm=indent

au FileType ruby       setlocal sw=2 sts=2
au FileType javascript setlocal nocindent smartindent sw=2 sts=2
au FileType python     setlocal sw=4 sts=4

" Treat '-' as part of words in CSS
au FileType css,scss,html setlocal iskeyword+=-

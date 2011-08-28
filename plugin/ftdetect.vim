" Additional filename auto-detection schemes.

augroup filetypedetect
  au! BufNewFile,BufRead Gemfile   setf ruby
  au! BufNewFile,BufRead Thorfile  setf ruby
  au! BufNewFile,BufRead config.ru setf ruby
  au! BufNewFile,BufRead *.rake    setf ruby
  au! BufNewFile,BufRead *.thor    setf ruby
augroup END

" DelimitMate sucks with these two.
au FileType scss let b:delimitMate_matchpairs="(:),[:],<:>"
au FileType css  let b:delimitMate_matchpairs="(:),[:],<:>"

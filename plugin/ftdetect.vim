" Additional filename auto-detection schemes.

augroup filetypedetect
  au! BufNewFile,BufRead Gemfile  setf ruby
  au! BufNewFile,BufRead Thorfile setf ruby
  au! BufNewFile,BufRead *.rake   setf ruby
  au! BufNewFile,BufRead *.thor   setf ruby
augroup END

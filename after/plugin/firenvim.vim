if exists('g:started_by_firenvim')
  set nonumber norelativenumber wrap linebreak nocursorline laststatus=0
  augroup firenvim
    au BufEnter github.com_*.txt set filetype=markdown
  augroup END
endif

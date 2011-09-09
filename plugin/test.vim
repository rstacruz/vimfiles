" Run tests
function! s:Test(...)
  silent! exec '![ -e .rvmrc ] && source .rvmrc; git autotest run &'
  redraw!
endfunction

com! -nargs=* Test call s:Test(<f-args>)

" Simple command to switch to a new workspace

if !exists('g:workPath')
  let g:workPath = '~/Workdesk/'
endif

function! s:Work(...)
    let dir = a:1
    exec 'cd ' . g:workPath . dir
    silent! new
    silent! only
    NERDTree
endfunction

com! -nargs=* Work call s:Work(<f-args>)

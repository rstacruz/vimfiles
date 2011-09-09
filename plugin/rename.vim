function! s:Rename(...)
    exec 'saveas '.a:1
    exec '!rm %'
    exec 'e '.a:1
endfunction

com! -nargs=* Rename call s:Rename(<f-args>)

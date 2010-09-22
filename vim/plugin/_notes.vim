function! s:Notes()
    exec 'cd ~/Workdesk/notes'
    NERDTree
endfunction

com! Notes call s:Notes()

function! s:Work(...)
    let dir = a:1
    exec 'cd ~/Workdesk/' . dir
    silent! new
    silent! only
    NERDTree
endfunction

com! -nargs=* Work call s:Work(<f-args>)

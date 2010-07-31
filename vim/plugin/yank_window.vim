" http://stackoverflow.com/questions/2228353/how-to-swap-files-between-windows-in-vim
"
" ,d      = delete (cut) a win
" ,y      = yank (copy) a window
" ,pp     = paste window here
" ,pj ,pk = paste window above/below
"
if version >= 700
function! HOpen(dir,what_to_open)

    let [type,name] = a:what_to_open

    if a:dir=='left' || a:dir=='right'
        vsplit
    elseif a:dir=='up' || a:dir=='down'
        split
    end

    if a:dir=='down' || a:dir=='right'
        exec "normal! \<c-w>\<c-w>"
    end

    if type=='buffer'
        exec 'buffer '.name
    else
        exec 'edit '.name
    end
endfunction

function! HYankWindow()
    let g:window = winnr()
    let g:buffer = bufnr('%')
    let g:bufhidden = &bufhidden
endfunction

function! HDeleteWindow()
    call HYankWindow()
    set bufhidden=hide
    close
endfunction

function! HPasteWindow(direction)
    let old_buffer = bufnr('%')
    call HOpen(a:direction,['buffer',g:buffer])
    let g:buffer = old_buffer
    let &bufhidden = g:bufhidden
endfunction

noremap <c-w>d :call HDeleteWindow()<cr>
noremap <c-w>y :call HYankWindow()<cr>
noremap <c-w>p<up> :call HPasteWindow('up')<cr>
noremap <c-w>p<down> :call HPasteWindow('down')<cr>
noremap <c-w>p<left> :call HPasteWindow('left')<cr>
noremap <c-w>p<right> :call HPasteWindow('right')<cr>
noremap <c-w>pk :call HPasteWindow('up')<cr>
noremap <c-w>pj :call HPasteWindow('down')<cr>
noremap <c-w>ph :call HPasteWindow('left')<cr>
noremap <c-w>pl :call HPasteWindow('right')<cr>
noremap <c-w>pp :call HPasteWindow('here')<cr>
noremap <c-w>P :call HPasteWindow('here')<cr>

noremap ,d :call HDeleteWindow()<cr>
noremap ,y :call HYankWindow()<cr>
noremap ,pk :call HPasteWindow('up')<cr>
noremap ,pj :call HPasteWindow('down')<cr>
noremap ,ph :call HPasteWindow('left')<cr>
noremap ,pl :call HPasteWindow('right')<cr>
noremap ,pp :call HPasteWindow('here')<cr>
noremap ,P :call HPasteWindow('here')<cr>

endif


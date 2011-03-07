function! s:ToggleFullscreen()
    if &fullscreen == 0
        execute 'set fullscreen'
        execute 'set guioptions-=e'
        execute 'set guioptions-=L'
        execute 'set guioptions-=r'
        execute 'redraw'
    else
        execute 'set nofullscreen'
        execute 'set guioptions+=e'
        execute 'redraw'
    endif
endfunction

command! ToggleFullscreen :call <SID>ToggleFullscreen()
map <C-F> :ToggleFullscreen<CR>

if exists('g:autoloaded_quickterm') || &compatible | finish | endif
let g:autoloaded_quickterm = 1

if !has('g:quickterm_name')
  let g:quickterm_name = 'Quickterm'
endif

if !has('g:quickterm_height')
  let g:quickterm_height = 20
endif

if !has('g:quickterm_position')
  let g:quickterm_position = 'bottom'
endif


function! quickterm#activate()
  " see if there's already an open buffer
  let buf = bufnr(g:quickterm_name)
  let win = bufwinnr(buf)

  if buf == -1
    call quickterm#open_split_window()
    " Open a terminal
    term
    " Rename the buffer
    exec 'file ' . g:quickterm_name
    call quickterm#bind_buffer_keys()
  elseif win == -1
    " Buffer is alive, but window is not open
    call quickterm#open_split_window()
    exec 'b ' . g:quickterm_name
    norm a
  else
    " Window is open Focus on the open window
    exec '' . win . 'wincmd w'
    norm a
  endif
endfunction

" Opens a split window
function! quickterm#open_split_window()
  let pos = g:quickterm_position == 'bottom' ? 'bot' : 'top'
  exe '' . pos . ' new'
  exe 'resize ' . g:quickterm_height
endfunction

function! quickterm#bind_buffer_keys()
  " Hide window
  tnoremap <buffer> <C-]> <C-\><C-n>:q<cr>
  tnoremap <buffer> <C-/> <C-\><C-n>:q<cr>
  nnoremap <buffer> <C-]> :q<cr>
  nnoremap <buffer> <C-/> :q<cr>
endfunction

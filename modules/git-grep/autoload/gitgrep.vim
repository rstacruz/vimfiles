" Include guard
if exists('g:autoloaded_gitgrep') || &compatible | finish | endif
let g:autoloaded_gitgrep = 1

" Name of the gitgrep window
if !exists('g:gitgrep_window')
  let g:gitgrep_window = 'GitGrep'
endif

" Position in :VG (right or left)
if !exists('g:gitgrep_vertical_position')
  let g:gitgrep_vertical_position = 'left'
endif

" Position in :SG (top or bottom)
if !exists('g:gitgrep_horizontal_position')
  let g:gitgrep_horizontal_position = 'bottom'
endif

" Height for the window
if !exists('g:gitgrep_height')
  let g:gitgrep_height = 20
endif

" Store the last known search here
if !exists('g:gitgrep_last_query')
  let g:gitgrep_last_query = ''
endif

" Opens a window for [v]ertical, [s]plit, [t]ab or [max]imised
function gitgrep#open_window(win_mode)
  if a:win_mode == 'v'
    let pos = g:gitgrep_vertical_position == 'right' ? 'botright' : 'topleft'
    exe 'vert ' . pos . ' new'
  elseif a:win_mode == 's'
    let pos = g:gitgrep_horizontal_position == 'bottom' ? 'bot' : 'top'
    exe '' . pos . ' new'
    exe 'resize ' . g:gitgrep_height
  elseif a:win_mode == 't'
    tabnew
  else
    new
    resize
  endif
endfunction

" Opens a window, or focuses if it's already there
" Returns:
"  - `0` if it's a new window
"  - `1` if it's a new window & existing buffer
"  - `2` if it's an existing window & existing buffer
"
function! gitgrep#prepare_window(win_mode)
  let buf = bufnr(g:gitgrep_window)
  let win = bufwinnr(buf)

  if buf == -1
    " New buffer/window
    call gitgrep#open_window(a:win_mode)
    " set buffer name
    exe 'file ' . g:gitgrep_window
    call gitgrep#bind_buffer_keys()
    return 0
  elseif win == -1
    " Old buffer, new window (reuse the old buffer)
    call gitgrep#open_window(a:win_mode)
    exe 'b ' . buf
    return 1
  else
    " Old buffer, old window (focus on open window)
    exec '' . win . 'wincmd w'
    return 2
  endif
endfunction

function! gitgrep#run(win_mode, query)
  " Get query
  if a:query == ''
    if g:gitgrep_last_query == ''
      echo "What do you want to search for?"
      return
    else
      " Repeat the last query
      let query = g:gitgrep_last_query
    end
  else
    " New query
    let query = a:query
  endif

  " Open and focus on the window
  let window_mode = gitgrep#prepare_window(a:win_mode)
  if window_mode > 0
    if g:gitgrep_last_query == query
      " If it's just refocusing, and the query hasn't changed,
      " don't do anything
      return
    else
      " Otherwise, clear out the entire buffer
      setlocal noreadonly modifiable
      norm ggVG"_d
    endif
  endif

  " Perform an git grep search
  let escaped_query = shellescape(a:query)
  silent! exec 'r!git grep --heading --line-number -E ' . escaped_query
  setlocal filetype=help buftype=nofile

  " check line count to see if there are results
  if line('$') != 1
    " Highlight currenty query
    let @/ = query

    try
      " Format lines
      silent! %s#^\d\+:#  &  #g

      " Format filenames
      silent! %s#^[^ ]\+$#\r|&| >#g
    catch /./
    endtry

    " Move cursor to top, remove 2 lines
    normal gg
    normal "_2dd
  else
    normal o
    exec "normal a     No results found for `" . query . "`"
    normal o
  endif

  " Prevent it from being written
  setlocal readonly nomodifiable nonumber
  set hlsearch

  " Finally, let it be picked up later
  let g:gitgrep_last_query = a:query
endfunction

function! gitgrep#bind_buffer_keys()
  nnoremap <buffer> <cr> gf
  nnoremap <buffer> v <c-w>f
endfunction

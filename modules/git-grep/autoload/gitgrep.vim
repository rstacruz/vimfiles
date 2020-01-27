" Include guard
if exists('g:autoloaded_gitgrep') || &compatible | finish | endif
let g:autoloaded_gitgrep = 1

" Name of the gitgrep window
if !exists('g:gitgrep_window')
  let g:gitgrep_window = 'GitGrep'
endif

" Position in :VG (right or left)
if !exists('g:gitgrep_vertical_position')
  let g:gitgrep_vertical_position = 'right'
endif

if !exists('g:gitgrep_use_cursor_line')
  let g:gitgrep_use_cursor_line = 1
endif

" Position in :SG (top or bottom)
if !exists('g:gitgrep_horizontal_position')
  let g:gitgrep_horizontal_position = 'bottom'
endif

" Height for the window
if !exists('g:gitgrep_height')
  let g:gitgrep_height = 30
endif

" Store the last known search here
if !exists('g:gitgrep_last_query')
  let g:gitgrep_last_query = ''
endif

if !exists('g:gitgrep_keep_focus')
  let g:gitgrep_keep_focus = 1
endif

" The main entrypoint
function! gitgrep#run(win_mode, bang, query) " {{{
  " What invoked it
  let source = winnr()

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

  let grep_params = ''
  if a:bang == 1
    let grep_params = '-i '
  endif

  silent! exec 'r!git grep --heading --line-number -E ' . grep_params . escaped_query

  " check line count to see if there are results
  if line('$') != 1
    try
      " Format lines
      silent! %s#^\d\+:#  & #g

      " Format filenames
      silent! %s#^[^ ]\+$#\r&#g
    catch /./
    endtry

    " Move cursor to top, remove first 2 lines
    normal gg
    normal "_2dd

    " Highlight currenty query
    let @/ = query
  else
    exec "normal a!    No results found for `" . query . "`"
  endif

  " Prevent it from being written, and other stuff
  " (Setting the filetype will bind buffer keys)
  silent! setlocal
    \ nocursorcolumn nobuflisted foldcolumn=0
    \ nolist nonumber norelativenumber nospell noswapfile signcolumn=no
    \ nomodifiable nonumber foldmethod=indent filetype=gitgrep buftype=nofile hlsearch ignorecase

  if g:gitgrep_use_cursor_line == 1
    silent! setlocal cursorline
  endif

  " Finally, let it be picked up later
  let g:gitgrep_last_query = a:query
endfunction " }}}

" Opens a window and focuses on it
function gitgrep#open_window(win_mode) " {{{
  " `winmode` can be [v]ertical, [s]plit, [t]ab or [max]imised
  let mode = a:win_mode == '' ? 'm' : a:win_mode

  " save the referer window for splits
  let referer = winnr()

  if mode == 'v'
    let pos = g:gitgrep_vertical_position == 'right' ? 'botright' : 'topleft'
    exe 'vert ' . pos . ' new'
    let b:referer = referer
  elseif mode == 't'
    tabnew
  elseif mode == 's'
    let pos = g:gitgrep_horizontal_position == 'bottom' ? 'bot' : 'top'
    exe '' . pos . ' new'
    exe 'resize ' . g:gitgrep_height
    let b:referer = referer
  elseif mode == 'm'
    " always opens on top
    exe 'top new'
    resize
  endif
endfunction " }}}

" Opens a window, or focuses if it's already there
function! gitgrep#prepare_window(win_mode) " {{{
  " Returns...
  "  - `0` if it's a new window
  "  - `1` if it's a new window & existing buffer
  "  - `2` if it's an existing window & existing buffer

  let buf = bufnr(g:gitgrep_window)
  let win = bufwinnr(buf)

  if buf == -1
    " New buffer/window
    call gitgrep#open_window(a:win_mode)
    " set buffer name
    exe 'file ' . g:gitgrep_window
    let b:gitgrep_buffer = 1
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
endfunction " }}}

" Binds keys
function! gitgrep#bind_buffer_keys() " {{{
  nnoremap <silent> <buffer> <cr> :call gitgrep#navigate('open')<cr>
  nnoremap <silent> <buffer> f    :call gitgrep#toggle_follow_cursor()<cr>
  autocmd CursorMoved <buffer> call gitgrep#on_cursor_move()
endfunction " }}}

function! gitgrep#on_cursor_move() " {{{
  if exists('b:follow_cursor') && b:follow_cursor == 1
    call gitgrep#navigate('hover')
  endif
endfunction " }}}

" Navigates to a selected line in the search buffer
function! gitgrep#navigate(mode) " {{{
  " TODO: this is being double-called, lets optimise that
  " only operate on the gitgrep buffer
  if b:gitgrep_buffer != 1 | return | endif

  let old_g = @g
  let follow_cursor = exists('b:follow_cursor') && b:follow_cursor == 1

  " keep track of original cursor location
  normal mg

  " copy the first word. it might be the line number
  normal ^"gyw

  " use it as the line number if it's numeric
  if @g =~? '^\d\+$'
    let linenr = @g
  else
    let linenr = '1'
  endif

  " move to the filename and copy
  normal {
  if line('.') != '1'
    normal j
  endif
  " normal 0v$l"gy
  normal "gyy

  " snap back to old location
  normal 'g

  " keep a reference to the search results window
  let src = winnr()

  let filepath = @g
  " use the referer window if possible. winwidth() will check
  " if the window is still open
  if exists('b:referer') && winwidth(b:referer) != -1
    let win = b:referer
  else
    vert bot new
    let win = winnr()
    silent! exe '' . src . 'windo w'
    let b:referer = win
  endif
  silent exe '' . win . 'windo edit +' . linenr . ' ' . filepath

  " refocus back to the search results window
  if follow_cursor
    setlocal cursorline
    silent! exe '' . src . 'windo w'
  endif

  " restore old register
  let @g = old_g

  " Turn off follow cursor mode
  if a:mode == 'open'
    let b:follow_cursor = 0
  endif
endfunction " }}}

function gitgrep#toggle_follow_cursor() " {{{
  " only operate on the gitgrep buffer
  if b:gitgrep_buffer != 1 | return | endif

  if exists('b:follow_cursor') && b:follow_cursor == 1
    echo "Follow cursor [off]"
    let b:follow_cursor = 0
  else
    echo "Follow cursor [on] - experimental!"
    let b:follow_cursor = 1
  end
endfunction " }}}

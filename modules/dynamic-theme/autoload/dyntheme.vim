function! dyntheme#is_light()
  let cachedir = dyntheme#get_cachedir()
  if filereadable(cachedir . '/light') | return 1 | endif
  if !filereadable(cachedir . '/wal/colors') | return 0 | endif
  let bgcolor = system("cat ".$HOME."/.cache/wal/colors | head -n 1")
  if matchstr(bgcolor, '#[efEF]') != "" | return 1 | endif
  return 0
endfunction

function! dyntheme#restore_theme() " {{{
  if has("gui_running")
    call dyntheme#gui_theme()
  elseif $LIGHT_MODE == '1' || dyntheme#is_light()
    call dyntheme#light_theme()
  else
    call dyntheme#dark_theme()
  endif
endfunction " }}}

function! dyntheme#get_cachedir() " {{{
  if $XDG_CACHE_DIR != '' | return $XDG_CACHE_DIR | endif
  return $HOME . '/.cache'
endfunction

function! dyntheme#persist_dark() " {{{
  let cachedir = dyntheme#get_cachedir()
  call delete('' . cachedir . '/light')
endfunction " }}}

function! dyntheme#persist_light() " {{{
  let cachedir = dyntheme#get_cachedir()
  call writefile([''], cachedir . '/light')
endfunction " }}}

function! dyntheme#dark_theme() " {{{
  set bg=dark
  color dyntheme
  call dyntheme#persist_dark()
  silent! doautocmd User DynthemeChange
  silent! doautocmd User DynthemeDark
endfunction

function! dyntheme#light_theme() " {{{
  set bg=light
  color dyntheme
  call dyntheme#persist_light()
  silent! doautocmd User DynthemeChange
  silent! doautocmd User DynthemeLight
endfunction

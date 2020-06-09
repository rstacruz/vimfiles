function! dyntheme#is_light()
  if filereadable($HOME.'/.cache/light') | return 1 | endif
  if !filereadable($HOME.'/.cache/wal/colors') | return 0 | endif
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

function! dyntheme#dark_theme() " {{{
  set bg=dark
  color dyntheme
  doautocmd User DynthemeChange
  doautocmd User DynthemeDark
endfunction

function! dyntheme#light_theme() " {{{
  set bg=light
  color dyntheme
  doautocmd User DynthemeChange
  doautocmd User DynthemeLight
endfunction

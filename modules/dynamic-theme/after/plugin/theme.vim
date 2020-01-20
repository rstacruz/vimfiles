function! s:is_light()
  " Don't bother if there's no xrdb
  if !filereadable($HOME.'/.cache/wal/colors') | return 0 | endif
  let bgcolor = system("cat ".$HOME."/.cache/wal/colors | head -n 1")
  if matchstr(bgcolor, '#[efEF]') != "" | return 1 | endif

  return 0
endfunction

if has("gui_running")
  Guitheme
elseif $LIGHT_MODE == '1' || s:is_light()
  Light
else
  Dark
endif

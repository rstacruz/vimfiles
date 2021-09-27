" Allow ^C and ^V in the console

if !has("gui_running") && !has('gui_vimr')
  vnoremap <slient> <C-c> "+y
  vnoremap <slient> <C-v> "+p
  inoremap <slient> <C-v> <Esc>"+pa
end


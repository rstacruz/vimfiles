" Allow ^C and ^V in the console

if !has("gui_running")
  vnoremap <C-c> "+y
  vnoremap <C-v> "+p
  inoremap <C-v> <Esc>"+pa
end


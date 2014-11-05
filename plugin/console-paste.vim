" Allow ^V in the console

if !has("gui_running")
  vmap <C-c> "+y
  vmap <C-v> "+p
  imap <C-v> <Esc>"+pi
end

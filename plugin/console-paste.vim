if !has("gui_running")
  vmap <C-c> "+y

  map <C-v> "+p
  vmap <C-v> "+p
  imap <C-v> <Esc><C-v>i
end

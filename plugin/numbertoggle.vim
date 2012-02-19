if !exists('g:loaded_numbertoggle')
  function! g:ToggleNuMode()
    if (&rnu == 1)
      set nu
      highlight LineNr gui=none term=none
    else
      set rnu
      highlight LineNr gui=reverse term=reverse
    endif
  endfunction

  nnoremap <C-n> :call g:ToggleNuMode()<Cr>
endif

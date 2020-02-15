command! Dark :call dyntheme#dark_theme()
command! Light :call dyntheme#light_theme()
command! RestoreTheme :call dyntheme#restore_theme()

augroup goyo_extensions
  autocmd! User GoyoEnter nested RestoreTheme
  autocmd! User GoyoEnter nested hi StatusLine ctermbg=none
  autocmd! User GoyoEnter nested hi StatusLineNC ctermbg=none
  autocmd! User GoyoLeave nested RestoreTheme
augroup END

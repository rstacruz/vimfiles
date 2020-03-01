command! Dark :call dyntheme#dark_theme()
command! Light :call dyntheme#light_theme()
command! RestoreTheme :call dyntheme#restore_theme()
command! Theme1 :call dyntheme#base#set_theme_1()
command! Theme2 :call dyntheme#base#set_theme_2()

augroup goyo_extensions
  autocmd! User GoyoEnter nested hi StatusLine ctermbg=none
  autocmd! User GoyoEnter nested hi StatusLineNC ctermbg=none
augroup END

command! Dark :call dyntheme#dark_theme()
command! Guitheme :call dyntheme#gui_theme()
command! Light :call dyntheme#light_theme()
command! RestoreTheme :call dyntheme#restore_theme()

autocmd! User GoyoEnter nested RestoreTheme
autocmd! User GoyoLeave nested RestoreTheme

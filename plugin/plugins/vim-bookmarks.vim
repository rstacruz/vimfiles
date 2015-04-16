if globpath(&rtp, "plugin/bookmark.vim") != ""
  let g:bookmark_save_per_working_dir = 1
  let g:bookmark_auto_save = 1
endif

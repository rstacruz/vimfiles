" Git grep
command! -bang -nargs=* GG call gitgrep#run('', <q-args>, { 'ignorecase': <bang>0 })

augroup gitgrep
  autocmd FileType gitgrep call gitgrep#bind_buffer_keys()
augroup END

" junegunn/vim-slash
if globpath(&rtp, "plugin/slash.vim") != ""
  augroup gitgrep_slash
    autocmd FileType gitgrep autocmd! slash CursorMoved,CursorMovedI *
  augroup END
endif

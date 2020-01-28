" Git grep
command! -bang -nargs=* GG call gitgrep#run('m', <bang>0, <q-args>)
command! -bang -nargs=* VG call gitgrep#run('v', <bang>0, <q-args>)
command! -bang -nargs=* SG call gitgrep#run('s', <bang>0, <q-args>)
command! -bang -nargs=* TG call gitgrep#run('t', <bang>0, <q-args>)

augroup gitgrep
  autocmd FileType gitgrep call gitgrep#bind_buffer_keys()
augroup END

" junegunn/vim-slash
if globpath(&rtp, "plugin/slash.vim") != ""
  augroup gitgrep_slash
    autocmd FileType gitgrep autocmd! slash CursorMoved,CursorMovedI *
  augroup END
endif

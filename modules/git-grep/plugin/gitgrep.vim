" Git grep
command! -bang -nargs=* GG call gitgrep#run('m', <q-args>, { 'ignorecase': <bang>0 })
command! -bang -nargs=* VG call gitgrep#run('v', <q-args>, { 'ignorecase': <bang>0 })
command! -bang -nargs=* SG call gitgrep#run('s', <q-args>, { 'ignorecase': <bang>0 })
command! -bang -nargs=* TG call gitgrep#run('t', <q-args>, { 'ignorecase': <bang>0 })

augroup gitgrep
  autocmd FileType gitgrep call gitgrep#bind_buffer_keys()
augroup END

" junegunn/vim-slash
if globpath(&rtp, "plugin/slash.vim") != ""
  augroup gitgrep_slash
    autocmd FileType gitgrep autocmd! slash CursorMoved,CursorMovedI *
  augroup END
endif

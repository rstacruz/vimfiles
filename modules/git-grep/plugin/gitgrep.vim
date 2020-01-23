" Git grep
command! -bang -nargs=* GG call gitgrep#run('m', <bang>0, <q-args>)
command! -bang -nargs=* VG call gitgrep#run('v', <bang>0, <q-args>)
command! -bang -nargs=* SG call gitgrep#run('s', <bang>0, <q-args>)
command! -bang -nargs=* TG call gitgrep#run('t', <bang>0, <q-args>)


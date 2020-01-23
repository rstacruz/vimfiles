" Git grep
command! -nargs=* GG call gitgrep#run('max', <q-args>)
command! -nargs=* VG call gitgrep#run('v', <q-args>)
command! -nargs=* SG call gitgrep#run('s', <q-args>)
command! -nargs=* TG call gitgrep#run('t', <q-args>)


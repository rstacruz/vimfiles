function! s:CRefresh()
    let paths = substitute(escape(&runtimepath, ' '), '\(,\|$\)', '/**\1', 'g')
    let cmd = findfile('cssrefresh.sh', paths)

    let fn = expand("%:t:r")
    let cmdline = cmd . ' ' . fn
    exec '!' . cmdline . ' 2>&1 >/dev/null'
endfunction

function! s:CAutoRefresh()
    autocmd! bufwritepost *.less,*.css,*.sass,*.scss CRefresh
endfunction

com! CRefresh call s:CRefresh()
com! CAutoRefresh call s:CAutoRefresh()

" By default, autorefresh is always on.
" Comment this out to disable that; you can type :CAutoRefresh to start it
" again later.
"
call s:CAutoRefresh()

function! s:RefreshSafariCSS()
    let paths = substitute(escape(&runtimepath, ' '), '\(,\|$\)', '/**\1', 'g')
    let cmd = findfile('cssrefresh.sh', paths)

    let fn = expand("%:t:r")
    let cmdline = cmd . ' ' . fn
    silent! exec '!' . cmdline
endfunction

function! s:RefreshSafari()
    let paths = substitute(escape(&runtimepath, ' '), '\(,\|$\)', '/**\1', 'g')
    let cmd = findfile('safari_refresh.sh', paths)
    silent! exec '!' . cmd
endfunction

function! s:AutoRefreshSafariCSS()
    autocmd! bufwritepost *.less,*.css,*.sass,*.scss RefreshSafariCSS
endfunction

com! RefreshSafariCSS call s:RefreshSafariCSS()
com! CAutoRefreshSafariCSS call s:AutoRefreshSafariCSS()
com! RefreshSafari call s:RefreshSafari()

" By default, autorefresh is always on.
" Comment this out to disable that; you can type :CAutoRefreshSafariCSS to start it
" again later.
"
call s:AutoRefreshSafariCSS()

" Recommended vimrc settings:
"
"   map <F5> :RefreshSafari<CR>
"   imap <F5> <Esc>:RefreshSafari<CR>
"   let g:cssRefreshAll = 1
"   let g:cssRefreshAuto = 1
"
" Commands:
"
"   :RefreshSafariCSS
"     Refreshes the CSS of the active Safari tab. By default,
"     CssRefresh gets the filename of the current Vim file and tries
"     to reload just that file.
"
"   :RefreshSafari
"     Reloads the active Safari tab completely.
"
" Options:
"
"   let g:cssRefreshAll = 1
"     Refresh /all/ stylesheets, instead of just the one that matches.
"
"   let g:cssRefreshAuto = 1
"     Enables auto refreshing.
"

function! s:RefreshSafariCSS()
    let paths = substitute(escape(&runtimepath, ' '), '\(,\|$\)', '/**\1', 'g')
    let cmd = findfile('cssrefresh.sh', paths)

    let fn = ''
    if !exists("g:cssRefreshAll")
      let fn = expand("%:t:r")
    endif
    let cmdline = cmd . ' ' .fn
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
com! RefreshSafari call s:RefreshSafari()

" By default, autorefresh is always on.
" Comment this out to disable that; you can type :CAutoRefreshSafariCSS to start it
" again later.
"
if exists("g:cssRefreshAuto")
  call s:AutoRefreshSafariCSS()
endif

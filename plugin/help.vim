if $VIM_MINIMAL != '' || $GIT_AUTHOR_DATE != '' | finish | endif

"" [:] :Usage -- Vimfiles: show usage information
command! Usage call <SID>help()

function! s:help()
  silent new
  set ft=help
  let vimpath = get(split(&rtp, ','), 0)
  exec "r!cd " . vimpath . "; bash _tools/help.sh"
  normal gg"_dd
endfunction

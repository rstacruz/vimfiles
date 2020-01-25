if globpath(&rtp, "autoload/startify.vim") == "" | finish | endif

"
" Bookmark commands
"

function! s:get_bookmark_commands()
  if has('nvim')
    let vim_path = stdpath('config')
  else
    let vim_path = $HOME . '/.vim'
  endif

  let bookmarks_path = vim_path . '/bookmarks'

  let globs = globpath(bookmarks_path, '*', 0, 1)
  let paths = filter(globs, "fnamemodify(v:val, ':t') != 'README.md'")
  " Let's use 'lcd' so multiple tabs can have different projects
  let commands = map(paths, "startify_x#to_banner(v:val)")
  return commands
endfunction

let g:startify_commands = s:get_bookmark_commands()


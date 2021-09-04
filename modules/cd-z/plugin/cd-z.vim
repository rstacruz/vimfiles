if !exists('g:z_data_path')
  if filereadable($HOME . '/.local/share/z/data')
    let g:z_data_path = $HOME . '/.local/share/z/data'
  elseif filereadable($HOME . '/.z')
    let g:z_data_path = $HOME . '/.z'
  endif
endif

" When true, will trigger autocmd instead
if !exists('g:z_autocmd')
  let g:z_autocmd = 0
endif

function! s:cd_to_z(input, options)
  let bang = get(a:options, 'bang', 0)

  if !filereadable(g:z_data_path)
    echomsg "Can't read Z data file. Is fish-z or zsh-z installed?"
    return
  endif

  let data_path = g:z_data_path
  let awk_script = "BEGIN{IGNORECASE=1} /" . a:input . "/ { print $2, $1 }"
  let cmd = "awk -F'|' " . shellescape(awk_script) . " " . data_path .
    \ " | sort -rn | head -n 1 | cut -d' ' -f2-"

  let result = trim(system(cmd))
  if result == ""
    echomsg "! No results found for '" . a:input . "'"
    return
  endif

  if bang
    echomsg "→  lcd [" . result . "]"
    exec "lcd " . result
    if g:z_autocmd == 1
      doautocmd User ZChangedDirLocal
      doautocmd User ZChangedDir
    else
      call s:on_open(result)
    end
  else
    echomsg "→  cd [" . result . "]"
    exec "cd " . result
    if g:z_autocmd == 1
      doautocmd User ZChangedDirGlobal
      doautocmd User ZChangedDir
    else
      call s:on_open_bang(result)
    end
  end
endfunction

function! s:on_open(cwd)
  e .
endfunction

function! s:on_open_bang(cwd)
  e .
  silent wincmd o
  silent tabonly
endfunction

command! -bang -nargs=1 Z call s:cd_to_z(<q-args>, { 'bang': <bang>0 })
command! -nargs=1 ZZ call s:cd_to_z(<q-args>, { 'bang': 1 })


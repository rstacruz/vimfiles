if !exists('g:z_data_path')
  if filereadable($HOME . '/.local/share/z/data')
    let g:z_data_path = $HOME . '/.local/share/z/data'
  endif
endif

function! s:cd_to_z(input)
  if !filereadable(g:z_data_path)
    echomsg "Can't read Z data file. Is fish-z installed?"
    return
  endif

  let data_path = g:z_data_path
  let cmd = "cat " .data_path .
    \ " | awk -F'|' '{ print $2, $1 }'" .
    \ " | grep -i ".shellescape(a:input) .
    \ " | sort -rn | head -n 1 | cut -d' ' -f2-"

  let result = system(cmd)
  exec "cd " . result
  doautocmd User ZChangedDir
endfunction

command! -nargs=1 Z call s:cd_to_z(<q-args>)


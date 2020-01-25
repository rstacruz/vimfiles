function startify_x#plug#get_days_since_last_update()
  let seconds = startify_x#plug#get_last_update_age()
  return seconds / 86400
endfunction

function startify_x#plug#get_last_update_age()
  " Only work if vim-plug is loaded
  if !exists('g:plug_home')
    return 0
  endif

  let now = system('bash -c ' . shellescape('date +%s'))
  let last = startify_x#plug#get_last_commit_date()
  return now - last
endfunction

function startify_x#plug#get_last_commit_date()
  let path = g:plug_home
  let cmd = 'cd ' . shellescape(path) .
    \ ' && for fn in *; do ' .
    \ '( cd $fn; git log -1 --format=%ct ); ' .
    \ 'done | sort -rn | head -n 1'
  return system('bash -c ' . shellescape(cmd))
endfunction


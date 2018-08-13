command! ALEToggleFixOnSave call <SID>ale_toggle_fix_on_save()

" Toggles fix_on_save for the current buffer.
function! s:ale_toggle_fix_on_save()
  if exists('b:ale_fix_on_save') && b:ale_fix_on_save == '0'
    let b:ale_fix_on_save=1
  else
    let b:ale_fix_on_save=0
  endif
  echo "b:ale_fix_on_save = " . b:ale_fix_on_save
endfunction

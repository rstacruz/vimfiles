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

command! ShowSyntaxStack :call <SID>show_syntax_stack()

function! s:show_syntax_stack()
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction

command! OpenRangerSplit :call <SID>open_ranger_split()

function! s:open_ranger_split()
  split
  terminal env EDITOR='nvim -cc split' ranger
endfunction

command! MyJournal :call <SID>my_journal()

function! s:my_journal()
  let journal_path = "~/org/journal"
  execute "cd " . journal_path
  let week = substitute(system("date '+%Y-W%U'"), '\n\+$', '', '')
  " let month = substitute(system("date '+%Y-%m'"), '\n\+$', '', '')
  " let today = substitute(system("date '+%Y-%m-%d-%a'"), '\n\+$', '', '')
  " let month_path = "." . "/README." . month . ".md"
  let week_path = "." . "/" . week . ".md"
  execute "edit " . week_path
  " vsplit
  " execute "edit " . month_path
endfunction

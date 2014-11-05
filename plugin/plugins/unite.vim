if $VIM_MINIMAL != '1'
  call unite#filters#matcher_default#use(['matcher_fuzzy'])
  let g:unite_winheight = 10
  let g:unite_win_split_rule = 'botright'
  let g:unite_prompt = '▸ '

  " also consider -no-split
  nnoremap <C-p> :<C-u>Unite -start-insert file_rec/async:!<CR>
  nnoremap <leader>ua :<C-u>Unite -start-insert file_rec/async:!<CR>
  nnoremap <leader>uf :<C-u>Unite -start-insert file<CR>
  nnoremap <leader>ub :<C-u>Unite -quick-match buffer<CR>
  nnoremap <leader>ut :<C-u>Unite -start-insert tag<CR>

  nnoremap <leader>ug :<C-u>Unite -no-quit -winheight=10 grep:.<CR>
  nnoremap <leader>uo :<C-u>Unite -no-split -auto-preview -winheight=20 outline<CR>

  nnoremap <leader>uA :<C-u>Unite -start-insert file_rec/async<CR>
  nnoremap <leader>uF :<C-u>Unite -start-insert file buffer<CR>
  nnoremap <leader>uB :<C-u>Unite -start-insert buffer<CR>
endif

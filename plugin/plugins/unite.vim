if globpath(&rtp, "plugin/unite.vim") != ""
  "
  " Unite settings
  "
  call unite#filters#matcher_default#use(['matcher_fuzzy'])
  let g:unite_data_directory = expand("~/.cache/unite")
  let g:unite_winheight = 10
  let g:unite_prompt = '▸ '
  let g:unite_source_mark_marks = "abcdefghijklmnopqrstuvwxyz" . "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

  "
  " Prefix key
  "

  nnoremap [unite] <Nop>
  nmap <leader>u [unite]

  "
  " Keys. for no-splits, exit using C-o
  "

  nnoremap <silent> [unite]b :<C-u>Unite -start-insert buffer<CR>
  nnoremap <silent> [unite]B :<C-u>UniteBookmarkAdd<CR>
  nnoremap <silent> [unite]t :<C-u>Unite -start-insert tag<CR>
  nnoremap <silent> [unite]g :<C-u>Unite -winheight=30 -truncate grep:.<CR>
  nnoremap <silent> [unite]o :<C-u>Unite -auto-highlight -vertical -winwidth=30 outline<CR>
  nnoremap <silent> [unite]O :<C-u>Unite -no-quit -vertical -winwidth=30 outline<CR>

  "
  " aliases
  "

  map  <C-p>     [unite]a
  nmap <leader>t [unite]o

  "
  " Use ag for search
  "
  if executable('ag')
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--nogroup --nocolor --column --ignore vendor --ignore public'
    let g:unite_source_grep_recursive_opt = ''
  endif

  " if has("nvim")
  "   nnoremap <silent> [unite]a :<C-u>Unite -start-insert -hide-source-names file_rec/neovim<CR>
  " else
    nnoremap <silent> [unite]a :<C-u>Unite -start-insert -hide-source-names file_rec/git<CR>
    " let g:unite_source_rec_async_command="git ls-files"
  " endif

endif

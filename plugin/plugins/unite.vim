if globpath(&rtp, "plugin/unite.vim") == ""
  finish
endif

"
" Unite settings
"

let g:unite_data_directory = expand("~/.cache/unite")
let g:unite_winheight = 20
let g:unite_prompt = '  ▸  '

"
" Show file marks (mA) in unite-mark
"

let g:unite_source_mark_marks = "abcdefghijklmnopqrstuvwxyz" . "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
let g:unite_source_tag_max_fname_length = 70

"
" Use ag so that file_rec will respect gitignore.
" https://github.com/Shougo/unite.vim/issues/398#issuecomment-27012821
"

if executable('ag')
  let g:unite_source_rec_async_command='ag --nocolor --nogroup --ignore "*.png" -g ""'
endif

"
" ensure that 'on_page' matches 'on_page?' and not 'confirmation_page'.
" sorter_selecta would be better, but it's not as fast as sotrer_rank.
"

call unite#custom#source('tag', 'sorters', ['sorter_rank'])

"
" Strip off absolute paths from file_rec.
" Also, use fuzzy ctrl-p-style matcher.
" Also, neovim doesn't have ruby so... no selecta
"

let s:file_recs = 'file_rec,file_rec/async,tag'
let s:sorter = has("ruby") ? 'sorter_selecta' : 'sorter_rank'
call unite#custom#source(s:file_recs, 'sorters', [s:sorter])
call unite#custom#source(s:file_recs, 'matchers', ['converter_relative_word', 'matcher_fuzzy'])

"
" Prefix key
"

nnoremap [unite] <Nop>
nmap <leader>u [unite]

"
" Keys. for no-splits, exit using C-o
"

" file (manual navigator)
nnoremap <silent> [unite]f :<C-u>Unite -start-insert -hide-source-names file file/new<CR>

" files (git)
nnoremap <silent> [unite]g :<C-u>Unite -resume -buffer-name=files -input= -start-insert -hide-source-names file file_rec/async<CR>

" buffer
nnoremap <silent> [unite]b :<C-u>Unite -start-insert buffer<CR>

" tags
nnoremap <silent> [unite]t :<C-u>Unite -resume -buffer-name=tag -input= -start-insert tag<CR>

" outline
nnoremap <silent> [unite]o :<C-u>Unite -auto-highlight -vertical -winwidth=30 outline<CR>

"
" Use unite-tag instead of ^] for navigating to tags.
" :help unite-tag-customize
"

autocmd BufEnter *
\   if empty(&buftype)
\|      nnoremap <buffer> <C-]> :<C-u>UniteWithCursorWord -immediately tag<CR>
\| endif

"
" aliases
"

map  <C-p>     [unite]g
map  <C-e>     [unite]t
nmap <leader>t [unite]o

"
" Use ag for search
"
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column --ignore vendor --ignore public'
  let g:unite_source_grep_recursive_opt = ''
endif

" `, a` - Apps {{{
"" [N] <leader>as -- Apps: show scope
" Useful for creating color schemes
nmap <Leader>as :echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')<CR>
" }}}

" `, e` - Errors {{{
if globpath(&rtp, "plugin/ale.vim") != ""
  "" [N] <Leader>ef -- Errors: run formatter
  nmap <Leader>ef <Plug>(ale_fix)

  "" [N] <Leader>ev -- Errors: verify ale setup
  "" [N] <Leader>en -- Errors: next
  "" [N] <Leader>ep -- Errors: previous
  "" [N] <Leader>ec -- Errors: clear errors
  nnoremap <Leader>ev :ALEVerify<CR>
  nnoremap <Leader>en :ALENextWrap<CR>
  nnoremap <Leader>ep :ALEPreviousWrap<CR>
  nnoremap <Leader>eN :ALEPreviousWrap<CR>
  nnoremap <Leader>ec :ALEResetBuffer<CR>
endif
" }}}

" `, .` - Easymotion {{{
if globpath(&rtp, "plugin/EasyMotion.vim") != ""
  "" [N] <leader>.k -- Easymotion: jump to a line above
  "" [N] <leader>.j -- Easymotion: jump to a line below
  "" [N] <leader>.f -- Easymotion: jump to a character above
  "" [N] <leader>.F -- Easymotion: jump to a character below
  nnoremap <leader>. <Plug>(easymotion-prefix)
endif
" }}}

" `, f e` - Editor {{{
"" [N] <leader>fed -- Editor: Open config
"" [N] <leader>fek -- Editor: Open key bindings
nnoremap <leader>fed :e ~/.vimrc<CR>
nnoremap <leader>fek :e ~/.vim/plugin/key-bindings.vim<CR>
" }}}

" `, b` - Buffer {{{
"" [N] <leader>bn -- Buffer: next
"" [N] <leader>bp -- Buffer: prev
"" [N] <leader>bd -- Buffer: delete
"" [N] <leader>bD -- Buffer: delete!
"" [N] <leader>bb -- Buffer: buffers (fzf)
"" [N] <leader>bh -- Buffer: history (fzf)

nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bd :bdelete<CR>
nnoremap <leader>bD :bdelete!<CR>
nnoremap <leader>bp :bprev<CR>

if globpath(&rtp, "plugin/fzf.vim") != ""
  nnoremap <leader>bb :Buffers<CR>
  nnoremap <leader>bh :History<CR>
endif
" }}}

" `, p` - Project {{{
"" [N] - -- Open tree
"" [N] <leader>pr -- Project: show related files (tests, etc)
"" [N] <leader>pt -- Project: open tree [nerdtree]
"" [N] <leader>pp -- Project: save session and open project switcher
"" [N] <leader>pP -- Project: discard session and open project switcher
"" [N] <leader>pf -- Project: open file [fzf]
"" [N] <leader>ps -- Project: open tags (symbols) [fzf]
"" [N] <C-p> -- Project: open file [fzf]

if globpath(&rtp, "plugin/NERD_tree.vim") != ""
  nnoremap - :NERDTreeFind<CR>
  nnoremap <leader>pt :NERDTree<CR>
  nnoremap <leader>pp :SSave!<CR>
  nnoremap <leader>pP :SClose<CR>
endif

if globpath(&rtp, "plugin/fzf.vim") != ""
  nnoremap <Leader>pr :exe 'FZF -q ' . join(split(join(split(expand('%:t:r'), '_'), ''), '-'), '')<CR>
  nnoremap <leader>pf :GFiles<cr>
  nnoremap <leader>ps :Tag<CR>
  nnoremap  <C-p> :GFiles<cr>
endif
" }}}

" `, t` - Terminal {{{
if has("nvim")
  "" [N] <leader>tn -- Terminal: open in new split
  "" [N] <leader>ts -- Terminal: open in new split
  "" [N] <leader>tv -- Terminal: open in new vertical split
  "" [N] <leader>tt -- Terminal: open in new tab
  "" [N] <leader>t. -- Terminal: open here
  "" [N] <leader>' -- Terminal: open here
  nnoremap <Leader>' <C-w>n:te<CR>a
  nnoremap <Leader>tn <C-w>n:te<CR>
  nnoremap <Leader>ts <C-w>n:te<CR>
  nnoremap <Leader>tv <C-w>v<C-w>l:te<CR>
  nnoremap <Leader>tt :tabnew<CR>:te<CR>
  nnoremap <Leader>t. :te<CR>

  " :h terminal-emulator-input
  tnoremap <C-]> <C-\><C-n>
  tnoremap <C-[> <C-\><C-n>
endif
" }}}

" `, g` - VCS/Git {{{
"" [N] <leader>gs -- Git: see changed files
"" [N] <leader>gS -- Git: status
"" [N] <leader>gc -- Git: commit

if globpath(&rtp, "plugin/fzf.vim") != ""
  nnoremap <leader>gs :GFiles?<CR>
endif

if globpath(&rtp, "plugin/fugitive.vim") != ""
  nnoremap <leader>gS :Gstatus<CR>
  nnoremap <leader>gc :Gcommit<CR>
endif
" }}}

" `, /` - Find {{{
"" [N] <leader>/ -- Find: find in project
"" [N] <leader>* -- Find: find in project from cursor

if globpath(&rtp, "plugin/fzf.vim") != ""
  nnoremap <leader>/ :Ag<CR>
  nnoremap <leader>* :Ag <C-r><C-w><CR>
endif
" }}}

" Misc {{{
"" [N] <leader>T -- Misc: open a new tab
"" [N] - -- Misc: Open tree
"" [N] <CR> -- Misc: Open fold

nnoremap <leader>T :tabnew<cr>

" Buffer navigation
nnoremap <C-H> :bprev<CR>
nnoremap <C-L> :bnext<CR>
inoremap <C-H> <Esc>:bprev<CR>
inoremap <C-L> <Esc>:bnext<CR>

if globpath(&rtp, "plugin/NERD_tree.vim") != ""
  nnoremap - :NERDTreeFind<CR>
endif

nnoremap <Enter> za
" vim:foldmethod=marker
" }}}

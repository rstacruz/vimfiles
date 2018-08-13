" vim:foldmethod=marker

" `, a` - Apps {{{
"" [N] <leader>as -- Apps: show scope
"" [N] <leader>al -- Apps: show language client
"" [N] <leader>ar -- Apps: ranger [neovim]

  " Useful for creating color schemes!
  nnoremap <Leader>as :echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')<CR>
  nnoremap <leader>al call :LanguageClient_contextMenu()<CR>

if has("nvim")
  nnoremap <Leader>ar <C-w>n:term env EDITOR="nvim -cc split" ranger<CR>
endif
" }}}

" `, e` - Errors {{{
"" [N] <Leader>ef -- Errors: run formatter [ale]
"" [N] <Leader>eF -- Errors: ale fix suggest [ale]
"" [N] <Leader>ev -- Errors: verify ale setup [ale]
"" [N] <Leader>en -- Errors: next [ale]
"" [N] <Leader>ep -- Errors: previous [ale]
"" [N] <Leader>ec -- Errors: clear errors [ale]
"" [N] =oef -- Errors: toggle fix-on-save for current buffer [ale]

  if exists(':ALEFix')
    nmap <Leader>ef <Plug>(ale_fix)
    nnoremap =oef :ALEToggleFixOnSave<CR>
    nnoremap <Leader>eF :ALEFixSuggest<CR>
    nnoremap <Leader>ev :ALEDetail<CR>
    nnoremap <Leader>en :ALENextWrap<CR>
    nnoremap <Leader>ep :ALEPreviousWrap<CR>
    nnoremap <Leader>eN :ALEPreviousWrap<CR>
    nnoremap <Leader>ec :ALEResetBuffer<CR>
  endif
" }}}

" `, .` - Easymotion {{{
"" [N] <leader>.k -- Jump: to a line above [easymotion]
"" [N] <leader>.j -- Jump: to a line below [easymotion]
"" [N] <leader>.w -- Jump: to a word below [easymotion]
"" [N] <leader>.f -- Jump: to a character above [easymotion]
"" [N] <leader>.F -- Jump: to a character below [easymotion]

  if globpath(&rtp, "plugin/EasyMotion.vim") != ""
    nmap <leader>. <Plug>(easymotion-prefix)
    vmap <leader>. <Plug>(easymotion-prefix)
  endif
" }}}

" `, f` - File {{{
  "" [N] <leader>ff -- Files: All files [fzf]

  if exists(':Files')
    nnoremap <leader>ff :Files<CR>
  endif
" }}}

" `, f e` - Editor {{{
"" [N] <leader>fed -- Editor: Open config
"" [N] <leader>fek -- Editor: Open key bindings
"" [N] <leader>fec -- Editor: Open commands
"" [N] <leader>feo -- Editor: Open options
"" [N] <leader>fep -- Editor: Open plugin config

  nnoremap <leader>fed :e ~/.vimrc<CR>
  nnoremap <leader>fek :e ~/.vim/after/plugin/key-bindings.vim<CR>
  nnoremap <leader>fec :e ~/.vim/plugin/commands.vim<CR>
  nnoremap <leader>feo :e ~/.vim/after/plugin/options.vim<CR>
  nnoremap <leader>fep :e ~/.vim/plugin/plugins/<CR>
" }}}

" `, b` - Buffer {{{
"" [N] <leader>bn -- Buffer: next
"" [N] <leader>bp -- Buffer: prev
"" [N] <leader>bd -- Buffer: close (delete)
"" [N] <leader>bD -- Buffer: close all
"" [N] <leader>bb -- Buffer: buffers [fzf]
"" [N] <leader>bh -- Buffer: history [fzf]

nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bd :bdelete<CR>
nnoremap <leader>bD :bdelete!<CR>
nnoremap <leader>bp :bprev<CR>

if exists(':Buffers')
  nnoremap <leader>bb :Buffers<CR>
  nnoremap <leader>bh :History<CR>
endif
" }}}

" `, p` - Project {{{
"" [N] <leader>pr -- Project: show related files (tests, etc)
"" [N] <leader>pt -- Project: open tree [nerdtree]
"" [N] <leader>pp -- Project: save session and open project switcher
"" [N] <leader>pP -- Project: discard session and open project switcher
"" [N] <leader>pf -- Project: open file [fzf]
"" [N] <leader>ps -- Project: open tags (symbols) [fzf]
"" [N] <C-p> -- Project: open file [fzf]

if exists(':NERDTreeFind')
  nnoremap - :NERDTreeFind<CR>
  nnoremap <leader>pt :NERDTree<CR>
  nnoremap <leader>pP :SSave!<CR>
  nnoremap <leader>pp :SClose<CR>
endif

nnoremap <Leader>pr :exe 'FZF -q ' . join(split(join(split(expand('%:t:r'), '_'), ''), '-'), '')<CR>

if exists(':Tag')
  nnoremap <leader>ps :Tag<CR>
  nnoremap <leader>pf :GFiles<cr>
  nnoremap  <C-p> :GFiles<cr>
endif
" }}}

" `, t` - Terminal {{{
"" [N] <leader>tn -- Terminal: open in new split [neovim]
"" [N] <leader>ts -- Terminal: open in new split [neovim]
"" [N] <leader>tv -- Terminal: open in new vertical split [neovim]
"" [N] <leader>tt -- Terminal: open in new tab [neovim]
"" [N] <leader>t. -- Terminal: open here [neovim]
"" [N] <leader>' -- Terminal: open here [neovim]

if has("nvim")
  nnoremap <Leader>' <C-w>n:te<CR>
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
"" [N] <leader>gS -- Git: see changed files [fzf]
"" [N] <leader>gs -- Git: status [fugitive]
"" [N] <leader>gc -- Git: commit [fugitive]
"" [N] <leader>gd -- Git: diff [fugitive]
"" [N] <leader>gb -- Git: blame [fugitive]

if exists(':GFiles')
  nnoremap <leader>gS :GFiles?<CR>
endif

if 1 " exists(':Gstatus')
  nnoremap <leader>gd :Gdiff<cr>
  nnoremap <leader>gb :Gblame<cr>
  nnoremap <leader>gs :Gstatus<CR>
  nnoremap <leader>gc :Gcommit<CR>
endif
" }}}

" `, /` - Find {{{
"" [N] <leader>/ -- Find: find in project [fzf]
"" [N] <leader>* -- Find: find in project from cursor [fzf]

if exists(':Ag')
  nnoremap <leader>/ :Ag<CR>
  nnoremap <leader>* :Ag <C-r><C-w><CR>
  vnoremap <leader>* y:Ag <C-r>"<C-b><CR>
endif
" }}}

" Fugitive {{{
  "" [Fugitive] D -- Fugitive: diff
  "" [Fugitive] dv -- Fugitive: diff vertically
  "" [Fugitive] cc -- Fugitive: commit
  "" [Fugitive] ca -- Fugitive: commit amend
  "" [Fugitive] cA -- Fugitive: commit amend no message
" }}}

" `, m` - Major mode {{{
  "" [N] <leader>mr -- Major: rename this symbol [languageclient]

  if exists(':LanguageClientStart')
    nnoremap <silent> <leader>mr :call LanguageClient#textDocument_rename()<CR>
  endif
" }}}

" `g` - Go to {{{
"" [N] gh -- Go: get hint [languageclient]
"" [N] gd -- Go: go to definition [languageclient]
"" [N] gJ -- Go: join multiline statement (like J) [splitjoin]
"" [N] gS -- Go: split multiline statement [splitjoin]

  if exists(':SplitjoinJoin')
    nmap gJ :SplitjoinJoin<cr>
    nmap gS :SplitjoinSplit<cr>
  endif

  if exists(':LanguageClientStart')
    nnoremap <silent> gh :call LanguageClient#textDocument_hover()<CR>
    nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
  endif
" }}}

" `h` - Help {{{
"" [N] <leader>hk -- Help: key bindings

  nnoremap <silent> <leader>hk :Usage<CR>
" }}}

" `, t` - Theme {{{
"" [N] <leader>Tc -- Theme: change color scheme
"" [N] <leader>Ta -- Theme: change airline theme
"" [N] <leader>Td -- Theme: change to default theme
"" [N] <leader>To -- Theme: run theme overrides
nnoremap <leader>Tc :color<space>
nnoremap <leader>Ta :AirlineTheme<space>
nnoremap <leader>To :ThemeOverrides<CR>
nnoremap <leader>Td :Dark<CR>
" }}}

" `, m j` - Major-Javascript {{{
" [N] <leader>mjw -- Major-JavaScript: Import module for the variable
" [N] <leader>mjf -- Major-JavaScript: Fix the file
" [N] <leader>mjg -- Major-JavaScript: Go to module on cursor

if exists(':ImportJSWord')
  nnoremap <leader>mjw :ImportJSWord<CR>
  nnoremap <leader>mjf :ImportJSFix<CR>
  nnoremap <leader>mjg :ImportJSGoto<CR>
endif
" }}}
"
" `, m m` - Major-Markdown {{{
" [N] <leader>mmf -- Major-Markdown: format table
" [N] <leader>mmt -- Major-Markdown: table of contents

nnoremap <leader>mmf :TableFormat<CR>
nnoremap <leader>mmt :Toc<CR>
" }}}

" Misc: emacs {{{
" [NI] <C-x><C-s> -- Misc-emacs: Save file
inoremap <C-x><C-s> <Esc>:w<CR>a
nnoremap <C-x><C-s> :w<CR>

" [NI] <C-s> -- Misc-emacs: Save file
nnoremap <C-s> :w<CR>

" [N] <CR> -- Misc: Open fold
nnoremap <CR> za
" }}}

" Misc {{{
  "" [N] <leader>T -- Misc: open a new tab
  "" [N] - -- Misc: Open tree
  "" [N] <Enter> -- Misc: Open fold
  "" [N] <S-Enter> -- Misc: Open fold recursively
  "" [N] <C-Enter> -- Misc: Close fold recursively
  "" [N] <leader><TAB> -- Misc: complete commands [fzf]
  "" [I] <C-e> -- Misc: expand abbreviation [emmet]
  "" [V] <C-e> -- Misc: expand abbreviation [emmet]
  
  nnoremap <leader>T :tabnew<cr>

  if globpath(&rtp, "plugin/emmet.vim") != ""
    imap <C-e> <C-y>,
    vmap <C-e> <C-y>,
  endif
  
  if exists(':NERDTreeFind')
    nnoremap - :NERDTreeFind<CR>
  endif
  
  if exists(':GFiles')
    nmap <leader><tab> <plug>(fzf-maps-n)
    xmap <leader><tab> <plug>(fzf-maps-x)
    omap <leader><tab> <plug>(fzf-maps-o)
  endif
  
  nnoremap <Enter> za
  nnoremap <S-Enter> zO
  nnoremap <C-Enter> zC
  " vmap <Enter> <Plug>(EasyAlign)
  " nmap ga <Plug>(EasyAlign)
  " nmap gA <Plug>(EasyAlign)ip
  " [V] E       -- EasyAlign: start easyalign [easyalign]
  " [V] <Enter> -- EasyAlign: start easyalign [easyalign]
  " [N] gA      -- Go: align current paragraph [easyalign]
  " vnoremap E :EasyAlign<space>
  " vnoremap <Enter> :EasyAlign<space>
  " nnoremap gA vip:EasyAlign<space>

"" [I] <c-x><c-f> -- FZF: complete file
"" [I] <c-x><c-j> -- FZF: complete file (via ag)

if exists(':Files')
  imap <c-x><c-k> <plug>(fzf-complete-word)
  imap <c-x><c-f> <plug>(fzf-complete-path)
  imap <c-x><c-j> <plug>(fzf-complete-file-ag)
  imap <c-x><c-l> <plug>(fzf-complete-line)
  inoremap <expr> <c-x><c-n> fzf#vim#complete#path("git ls-files \| xargs realpath")
endif

"" [N] <C-h> -- Misc: move to left pane
"" [N] <C-l> -- Misc: move to right pane
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

"" [N] =oas -- Misc: toggle signify
nnoremap =oas :SignifyToggle<CR>
" }}}

set laststatus=0

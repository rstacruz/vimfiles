" vim:fdm=marker:foldmarker={{{,}}}

" Basic custo {{{
" don't give |ins-completion-menu| messages.
set shortmess+=c
set noruler
set nonumber
set noshowmode " no -- INSERT -- in the status line
set ttimeoutlen=20 " for escape
set timeoutlen=600 " for iabbrev
set laststatus=2 " no statusbar if there's only one window
let &fcs='eob: ' " hide tildes (https://github.com/neovim/neovim/issues/2067#issuecomment-398283872)
set title

augroup titlestring
  " au! BufEnter * let &titlestring = fnamemodify(getcwd(),":t") . " / " . expand("%:t") . " —  " . (has("nvim") ? "Neovim" : "Vim")
  au! BufEnter * let &titlestring = fnamemodify(getcwd(),":t") . " —  " . (has("nvim") ? "Neovim" : "Vim")
augroup END
" }}}

" TermOpen customisations {{{
if has('nvim')
  " no line number in :term
  " https://github.com/neovim/neovim/issues/6832#issuecomment-305507194
  au! TermOpen * setlocal nonumber norelativenumber nocursorline
  au! TermOpen * startinsert
endif
" }}}

" Filetype: git {{{
augroup customisations_git
  au FileType gitcommit,pullrequest,gitrebase startinsert
  au FileType gitcommit,pullrequest,gitrebase setlocal nonumber norelativenumber nowrap
  if $GIT_EXEC_PATH != ''
    au FileType gitcommit,pullrequest,gitrebase inoremap <buffer> <C-s> <Esc>:wq<cr>
    au FileType gitcommit,pullrequest,gitrebase noremap <buffer> <C-s> :wq<cr>
  else
    au FileType gitcommit,pullrequest,gitrebase inoremap <buffer> <C-s> <Esc>:w<cr>:bwipeout!<cr>
    au FileType gitcommit,pullrequest,gitrebase noremap <buffer> <C-s> :w<cr>:bwipeout!<cr>
  end
  au FileType gitcommit setlocal statusline=──\ Git\ commit\ message\ ──
  au FileType pullrequest setlocal statusline=──\ Git\ pull\ request\ ──
augroup END
" }}}

" Filetype: nerdtree/startify {{{
augroup customisations_nerd
  au FileType startify,nerdtree nnoremap <buffer> z :Z<space>
  au FileType startify,nerdtree nnoremap <buffer> Z :ZZ<space>
  au FileType startify,nerdtree nnoremap <buffer> , :Z<space>
  au FileType startify,nerdtree nnoremap <buffer> . :term<cr>
augroup END
" }}}

" Filetype: tree-sitter folding {{{
augroup customisations_treesitter
  " treesitter-based folding where supported
  au FileType typescript,typescriptreact,javascript,javascriptreact,css,json,markdown setlocal foldmethod=expr foldexpr=nvim_treesitter#foldexpr()
augroup END
" }}}

" Filetype: beancount {{{
augroup customisations_beancount
  " Allow auto-completion of beancount accounts (eg, Assets:Bank-Stuff)
  au FileType beancount setlocal iskeyword+=-,58

  au FileType beancount nnoremap <buffer> <leader>= :AlignCommodity<CR>
  au FileType beancount vnoremap <buffer> <leader>= :AlignCommodity<CR>
augroup END
" }}}

" Filetype: taskpaper {{{
augroup customisations_taskpaper
  " Allow spaces in filenames to 'gf' inside taskpaper files
  au FileType taskpaper setlocal isfname+=32,[,],' ts=2 nowrap foldmethod=indent
  au! BufRead,BufNewFile *.ttxt setfiletype taskpaper
augroup END
" }}}

" Filetype: markdown {{{
augroup customisations_markdown
  au FileType markdown setlocal nowrap linebreak nonumber norelativenumber isfname+=32 conceallevel=2
augroup END
" }}}

" Filetype: others {{{
augroup customisations_other
  au FileType yaml setlocal foldmethod=indent
  " isfname: Allow spaces in filenames to 'gf' inside taskpaper files
augroup END
" }}}

" No status when editing Git commit messages
if $GIT_EXEC_PATH != ''
  set laststatus=0
endif

" No line numbers on git status
au FileType fugitive setlocal nonumber norelativenumber

" Close terminal
if has('nvim')
  au TermClose *tig* silent bwipe!
endif

set linebreak  " lbr: break on words
" }}}

" Markdown tools {{{
function! MkdnRemoveAnnotations()
  silent! %s/^###\n\n//
  silent! %s/^<!-- {.*\n\n//
endfunction

" In the rstacruz/til blog
function! MkdnConvertFigures()
  silent! %s#<figure class='cover'>\n\(.*\)\n</figure>#<Figure cover>\r\1\r</Figure>#g
  silent! %s#<figure class='table'>\n\(.*\)\n</figure>#<Figure table>\r\1\r</Figure>#g
endfunction

" Like 'gf' but creates a file if it's not there
function! OpenOrCreateFile(...)
  let fname=expand('%:h') . '/' . expand('<cfile>')
  let cmd=(a:0 == '' ? 'e' : 'split')
  silent! exec cmd . ' ' . fname
endfunction
" }}}

" disable by default
if exists(':GitGutterDisable')
  GitGutterDisable
endif

" iabbrev: Typo corrections {{{
augroup abbreviations_typos
  au FileType javascript,typescript,typescriptreact iabbrev <buffer> conts const
  au FileType javascript,typescript,typescriptreact iabbrev <buffer> classname className
  au FileType javascript,typescript,typescriptreact iabbrev <buffer> classNmae className
  au FileType javascript,typescript,typescriptreact iabbrev <buffer> classnmae className
  au FileType javascript,typescript,typescriptreact iabbrev <buffer> improt import
  au FileType javascript,typescript,typescriptreact iabbrev <buffer> porps props

  au FileType javascript,typescript,typescriptreact iabbrev <buffer> iM  import
  au FileType javascript,typescript,typescriptreact iabbrev <buffer> eX  export
  au FileType javascript,typescript,typescriptreact iabbrev <buffer> eF  export function
  au FileType javascript,typescript,typescriptreact iabbrev <buffer> cN  className
  au FileType javascript,typescript,typescriptreact iabbrev <buffer> rE  return
  au FileType javascript,typescript,typescriptreact iabbrev <buffer> fN  function
  au FileType javascript,typescript,typescriptreact iabbrev <buffer> aF  async function
  au FileType javascript,typescript,typescriptreact iabbrev <buffer> rE  return
  au FileType javascript,typescript,typescriptreact iabbrev <buffer> eX  export
  au FileType javascript,typescript,typescriptreact iabbrev <buffer> sJ  style jsx
  au FileType javascript,typescript,typescriptreact iabbrev <buffer> cL  console.log
  au FileType javascript,typescript,typescriptreact iabbrev <buffer> uI  require('util').inspect
augroup END
" }}}

" iabbrev: symbols ⌘ ⌦ {{{
augroup abbreviations_symbols
  au FileType text,markdown,c iabbrev <buffer> sfT ⇧
  au FileType text,markdown,c iabbrev <buffer> taB ↹
  au FileType text,markdown,c iabbrev <buffer> ftB ⇥
  au FileType text,markdown,c iabbrev <buffer> btB ⇤
  au FileType text,markdown,c iabbrev <buffer> ctL ⌃
  au FileType text,markdown,c iabbrev <buffer> opT ⌥
  au FileType text,markdown,c iabbrev <buffer> cmD ⌘
  au FileType text,markdown,c iabbrev <buffer> spC ␣
  au FileType text,markdown,c iabbrev <buffer> bkS ⌫
  au FileType text,markdown,c iabbrev <buffer> enT ↵
  au FileType text,markdown,c iabbrev <buffer> esC ⎋
  au FileType text,markdown,c iabbrev <buffer> deL ⌦
  " http://xahlee.info/comp/unicode_computing_symbols.html
  " https://hub.espanso.org/packages/mac-symbols/
augroup END
" }}}

" inoremap: Dates and symbols {{{
augroup insert_dates
  au FileType text,markdown,c inoremap ;di <C-r>=strftime("%Y-%m-%d")<CR>
  au FileType text,markdown,c inoremap ;dw <C-r>=strftime("%Y-%m-%d %a")<CR>
  au FileType text,markdown,c inoremap ;dl <C-r>=strftime("%a %e %b")<CR>
  au FileType text,markdown,c inoremap *di _<C-r>=strftime("%Y-%m-%d")<CR>_
  au FileType text,markdown,c inoremap *dw **<C-r>=strftime("%m-%d %a")<CR>**
  au FileType text,markdown,c inoremap ;ok ✓
  au FileType text,markdown,c inoremap ;.m ·
  au FileType text,markdown,c inoremap ;md —
  au FileType text,markdown,c inoremap ;>  ›
  au FileType text,markdown,c inoremap ;<  ‹
  au FileType text,markdown,c inoremap ;:: ∷
" }}}

" Theme overrides {{{
function s:add_theme_overrides()
  " if &background ==# 'dark' | ... | endif
  hi Normal ctermbg=none
  hi NonText ctermbg=none
  hi EndOfBuffer ctermbg=none
  hi! link FloatermBorder NonText

  hi! link mkdBlockQuote Number
  hi! link mkdCode Keyword
  hi! link mkdLink mkdInlineURL
  hi! link htmlBold Special
  hi! link htmlItalic Comment

  " bullets and delimiters
  hi! link mkdHeading NonText
  hi! link mkdBold NonText
  hi! link mkdItalic NonText
  hi! link mkdListItem NonText
  hi! link mkdCodeStart NonText
  hi! link mkdCodeEnd NonText
  hi! link mkdCodeDelimiter NonText

  " headings
  hi! link htmlH1 String
  hi! link htmlH2 String
  hi! link htmlH3 String

  hi! link TodoDate Comment

  " gitsigns
  hi! link GitSignsAdd Constant
  hi! link GitSignsDelete WarningMsg
  hi! link GitSignsChange Comment
  hi! link SignColumn NonText

  " curly
  hi! CocUnderline gui=undercurl

  " no reverse status line
  hi! StatusLine gui=none

  if g:colors_name == 'embark'
    " ...
    hi! Comment gui=italic
  elseif g:colors_name == 'challenger_deep'
    " ...
  elseif g:colors_name == 'tokyonight'
    " ...
  elseif g:colors_name == 'onedark'
    " ...
  elseif g:colors_name == 'zenbones'
    hi! Folded ctermbg=none
  elseif g:colors_name == 'github'
    hi! link VertSplit NonText
    hi! link EndOfBuffer Normal
    hi! Comment gui=italic cterm=italic
    hi! Title cterm=bold gui=bold
  elseif g:colors_name == 'iceberg'
    hi! NonText guifg=#505090  " increase contrast
  elseif g:colors_name == 'zenbones'
    " ...
  elseif g:colors_name == 'paramount'
    if &background ==# 'dark'
      " cold background
      hi! Normal     ctermfg=none guibg=#19192a
      hi! CursorLine              guibg=#1c1c38
      hi! Constant   ctermfg=2    guifg=#40ff80
      hi! Comment    ctermfg=8    guifg=#505080 gui=italic cterm=italic
      hi! Statement  ctermfg=1    guifg=#ccccff gui=bold
    else
      " new accent colour
      hi! Constant  ctermfg=63   guifg=#008844
      hi! Comment   ctermfg=61   guifg=#505080 gui=italic cterm=italic
      hi! Statement ctermfg=none guifg=#323242 gui=bold
      hi! Special                guifg=#434363
      hi! Visual    ctermfg=none ctermbg=254
      " todo: diffRemoved diffAdded
    endif
    " hi! VertSplit guibg=none ctermbg=none
    hi! link PreProc          Comment
    hi! link NonText          Comment
    hi! link Type             Statement
    hi! link Directory        Statement
    hi! link NERDTreeCWD      Constant
    hi! link NERDTreeClosable Constant
    hi! link NERDTreeOpenable Constant
  elseif g:colors_name == 'dracula'
    hi! Normal          guibg=#191920
    hi! CursorLine      guibg=#242432
    hi! DraculaBoundary guifg=#242432 guibg=none
    hi! link EndOfBuffer    Normal
    hi! link FloatermBorder Comment
    hi! link mkdBlockQuote  String
    hi! link mkdCodeEnd     Comment
    hi! link mkdCodeStart   Comment
    hi! link VertSplit      Comment
  endif
endfunction

autocmd ColorScheme * call s:add_theme_overrides()
autocmd VimEnter * call s:add_theme_overrides()
" }}}

" :Z {{{
let g:z_autocmd = 1
if has(':Prosession')
  augroup z_switcher
    au! User ZChangedDirGlobal Prosession .
  augroup END
else
  augroup z_switcher
    au! User ZChangedDirGlobal tabonly
    au! User ZChangedDirGlobal Startify
  augroup END
endif
" }}}

" Gui: neovim-qt {{{
if exists('g:GuiLoaded')
  " set guifont=JuliaMono:h13
  " set guifont=JetBrains\ Mono:h14:w60
  if hostname() == 'penguin'
    GuiFont! Iosevka:h10:w50
    GuiLinespace -1
    GuiTabline 1
    colorscheme github
  elseif has('macunix') == 1
    GuiFont! Iosevka Nerd Font:h16
    GuiLinespace -2
    GuiTabline 0
    colorscheme github
  else
    GuiFont! Iosevka Medium:h13.5:w57
    GuiLinespace -2
    GuiTabline 0
    colorscheme iceberg
  endif
  " also: paper, iceberg, challenger_deep, github
endif
" }}}

" Gui: Neovide {{{
if exists('g:neovide')
  let g:neovide_cursor_animation_length=0.04
  set guifont=Iosevka:h20
  colorscheme dracula
  " set background=dark
end
" }}}

" Gui: goneovim {{{
if exists('g:goneovim')
  set guifont=Iosevka:h14
  colorscheme dracula
  " set background=dark
end
" }}}

" Gui: vimr {{{
" https://github.com/qvacua/vimr/wiki
if has('gui_vimr')
  colorscheme github
  set background=light
  set guifont="Iosevka Nerd Font:h16"
endif
" }}}

" vim-unimpared: use `co` {{{
" https://github.com/tpope/vim-unimpaired/issues/150
nmap co yo
" }}}

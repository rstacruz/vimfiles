"" vim:fdm=marker:foldmarker={{{,}}}

" Basic custo {{{
" don't give |ins-completion-menu| messages.
set shortmess+=c
set noruler
set nonumber
set noshowmode " no -- INSERT -- in the status line
set ttimeoutlen=20 " for escape
set timeoutlen=600 " for iabbrev
set laststatus=2 " no statusbar if there's only one window
let &fcs='eob: ,vert:┃' " vertical split, hide tildes
set title

let g:microtone_variants = []
" }}}

" TermOpen customisations {{{
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

augroup customisations_nvimtree
  au! FileType NvimTree setlocal cursorline
augroup END
" }}}

" Filetype: harpoon {{{
augroup customisations_harpoon
  " easier to press than enter (mmemonic: "next")
  au! FileType harpoon nnoremap <buffer> n :lua require('harpoon.ui').select_menu_item()<CR>
  " au! FileType harpoon setlocal timeoutlen=1
augroup END
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

" Filetype: nerdtree {{{
augroup customisations_nerd
  au FileType nerdtree nnoremap <buffer> z :Z<space>
  au FileType nerdtree nnoremap <buffer> Z :ZZ<space>
  au FileType nerdtree nnoremap <buffer> , :Z<space>
  au FileType nerdtree nnoremap <buffer> . :term<cr>
augroup END
" }}}

" Filetype: startify {{{
augroup customisations_startify
  " au! VimEnter * Startify | vsplit | term
  " au! VimEnter * Startify
  au! User StartifyReset setlocal nocursorline
augroup END
" }}}

" Filetype: tree-sitter folding {{{
augroup customisations_treesitter
  " treesitter-based folding where supported
  au FileType typescript,typescriptreact,javascript,javascriptreact,css,json,markdown,ruby setlocal foldmethod=expr foldexpr=nvim_treesitter#foldexpr()
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
  " bold current word with `ysiw*` or `viwS*`
  " (see :help surround-customizing)
  au FileType markdown let b:surround_42 = "**\r**"
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
  " +dw - Date weekday ("_2021-10-31 Wed_")
  au FileType text,markdown,c inoremap +dw _<C-r>=strftime("%Y-%m-%d %a")<CR>_
  " +ds - Date short ("_2021-10-31_')
  au FileType text,markdown,c inoremap +ds _<C-r>=strftime("%Y-%m-%d")<CR>_
  au FileType text,markdown,c inoremap +` ```
  au FileType text,markdown,c inoremap +gh https://github.com/
  au FileType text,markdown,c inoremap +gr https://github.com/rstacruz
  au FileType text,markdown,c inoremap +gc [#](https://github.com/rstacruz/cheatsheets/pull//files)<Esc>7ha
  au FileType text,markdown,c inoremap +ok ✓
  au FileType text,markdown,c inoremap +.m ·
  au FileType text,markdown,c inoremap +md —
  au FileType text,markdown,c inoremap +>  ›
  au FileType text,markdown,c inoremap +<  ‹
  au FileType text,markdown,c inoremap +:: ∷
" }}}

" Theme overrides {{{
function s:add_theme_overrides()
  let color_name = get(g:, 'colors_name', '')

  " Default theme
  if &background ==# 'dark'
    let lualine_theme = 'ayu_dark'
  else
    let lualine_theme = 'ayu_light'
  end

  if matchstr(color_name, '^microtone') == ''
    hi Normal ctermbg=none
    hi NonText ctermbg=none
    hi EndOfBuffer ctermbg=none
    hi! link FloatermBorder VertSplit
    hi! link TelescopeBorder VertSplit

    hi! link mkdBlockQuote Comment
    hi! link mkdCode       Keyword
    hi! link mkdLink       mkdInlineURL
    hi! link htmlBold      Special
    hi! link htmlItalic    Comment

    " Startify
    hi! link StartifySection Comment
    hi! link StartifyHeader  Comment
    hi! link StartifyFooter  Comment
    hi! link StartifyNumber  Comment
    hi! link StartifyBracket Comment
    hi! link StartifySlash   Comment
    hi! link StartifyFile    Type
    hi! link StartifySpecial Comment

    " bullets and delimiters
    hi! link mkdHeading       Delimiter
    hi! link mkdBold          Delimiter
    hi! link mkdItalic        Delimiter
    hi! link mkdListItem      Delimiter
    hi! link mkdCodeStart     Delimiter
    hi! link mkdCodeEnd       Delimiter
    hi! link mkdCodeDelimiter Delimiter

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
    hi! link CocErrorHighlight SpellBad
    hi! link CocErrorSign Error

    " no reverse status line
    hi! StatusLine gui=none

    " don't like backgrounds in the folds
    hi! link Folded Comment
  endif

  if color_name == 'embark'
    hi! Comment gui=italic
  elseif color_name == 'iceberg' && &background ==# 'light'
    let lualine_theme = 'iceberg'
    hi! Normal guibg=#fcfcfc
    hi! NonText guifg=#505090  " increase contrast
    hi! CursorLine guibg=#eaf0fe
  elseif color_name == 'iceberg' && &background ==# 'dark'
    let lualine_theme = 'iceberg'
    hi! NonText guifg=#505090  " increase contrast
  elseif color_name == 'rosebones' && &background ==# 'light'
    hi! Normal guibg=#ffffff
  elseif color_name == 'tokyobones' && &background ==# 'light'
    hi! Normal guibg=#ffffff
    hi! CursorLine guibg=#eaf0fe
  elseif color_name == 'tokyobones' && &background ==# 'dark'
    hi! Normal guibg=#282838
  elseif color_name == 'zenwritten' && &background ==# 'light'
    hi! Normal guibg=#ffffff
  elseif color_name == 'zenbones'
    hi! Comment guibg=#906060  " increase contrast
  elseif color_name == 'dyntheme'
    let lualine_theme = '16color'
  elseif color_name == 'github'
    hi! link VertSplit NonText
    hi! link EndOfBuffer Normal
    hi! Comment gui=italic cterm=italic
    hi! Title cterm=bold gui=bold
  elseif color_name == 'borland'
    let lualine_theme = 'powerline'
    hi! VertSplit    gui=none guibg=#303050 guifg=#303050
    hi! TabLine      gui=none guibg=#303050 guifg=#303050
    hi! StatusLine   gui=none guibg=#303050 guifg=#9090aa
    hi! StatusLineNC gui=none guibg=#303050 guifg=#9090aa
    let &fcs="eob: ,vert:█"
    let g:terminal_color_0 = '#dcdfe7' | let g:terminal_color_1 = '#cc517a' | let g:terminal_color_2 = '#668e3d' | let g:terminal_color_3 = '#c57339' | let g:terminal_color_4 = '#2d539e' | let g:terminal_color_5 = '#0000ff' | let g:terminal_color_6 = '#3f83a6' | let g:terminal_color_7 = '#33374c' | let g:terminal_color_8 = '#8389a3' | let g:terminal_color_9 = '#cc3768' | let g:terminal_color_10 = '#598030' | let g:terminal_color_11 = '#b6662d' | let g:terminal_color_12 = '#22478e' | let g:terminal_color_13 = '#6845ad' | let g:terminal_color_14 = '#327698' | let g:terminal_color_15 = '#262a3f'
    let g:terminal_ansi_colors = ['#dcdfe7', '#cc517a', '#668e3d', '#c57339', '#2d539e', '#0000ff', '#3f83a6', '#33374c', '#8389a3', '#cc3768', '#598030', '#b6662d', '#22478e', '#6845ad', '#327698', '#262a3f']
  elseif color_name == 'rosebones' && &background ==# 'light'
    hi! Normal guibg=#ffffff
  elseif color_name == 'tokyobones' && &background ==# 'light'
    hi! Normal guibg=#ffffff
    hi! CursorLine guibg=#f2f2fa
  elseif color_name == 'tokyobones' && &background ==# 'dark'
    hi! Normal guibg=#282838
  elseif color_name == 'zenwritten' && &background ==# 'light'
    hi! Normal guibg=#ffffff
  elseif color_name == 'paramount'
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
  elseif color_name == 'dracula'
    let lualine_theme = 'dracula'
    hi! Normal          guibg=#191920
    hi! CursorLine      guibg=#242432
    hi! DraculaBoundary guifg=#242432 guibg=none
    hi! link EndOfBuffer    Normal
    hi! link FloatermBorder Comment
    hi! link mkdBlockQuote  String
    hi! link mkdCodeEnd     Comment
    hi! link mkdCodeStart   Comment
    hi! link VertSplit      Comment
  else
  endif

  if has('nvim') && globpath(&rtp, 'lua/lualine.lua') != ''
    exec "lua require('lualine').setup { options = { theme = '" . lualine_theme . "' } }"
  endif
endfunction

autocmd ColorScheme * call s:add_theme_overrides()
autocmd VimEnter * call s:add_theme_overrides()
" }}}

" :Z {{{
let g:z_autocmd = 1
augroup z_switcher
  au! User ZChangedDirGlobal tabonly
  au! User ZChangedDirGlobal wincmd o
  au! User ZChangedDirGlobal term
augroup END
" }}}

" Gui and themes: neovim-qt {{{
function! GetInferredBackground()
  let cachedir = $HOME . '/.cache'

  " infer it from pywal colors
  if !filereadable(cachedir . '/wal/colors') | return 'dark' | endif
  let bgcolor = system("cat ".$HOME."/.cache/wal/colors | head -n 1")
  if matchstr(bgcolor, '#[efEF]') != "" | return 'light' | endif
  return 'dark'
endfunction

function! SetDefaultTheme()
  " Get preferred values
  let theme_cli = get(g:, 'theme_cli', ['microtone', 'microtone'])
  let theme_cli_background = get(g:, 'theme_cli_background', GetInferredBackground())
  let theme_gui = get(g:, 'theme_gui', ['tokyobones', 'tokyobones'])
  let theme_gui_background = get(g:, 'theme_gui_background', 'light')

  " Placeholder for actual values (GUI by default)
  let background = theme_gui_background
  let themes = theme_gui

  if exists('g:GuiLoaded') " neovim-qt
    " set guifont=JuliaMono:h13
    " set guifont=JetBrains\ Mono:h14:w60
    if hostname() == 'penguin' " chromeos
      GuiFont! Iosevka:h10:w50
      GuiLinespace -1
      GuiTabline 1
    elseif has('macunix') == 1 " macos
      GuiFont! Iosevka Nerd Font:h16
      GuiLinespace -2
      GuiTabline 0
    else " linux
      GuiFont! Iosevka Fixed SemiBold:h13.5:w57
      GuiLinespace -2
      GuiTabline 0
    endif
  elseif exists('g:neovide') " neovide
    let g:neovide_cursor_animation_length=0.04
    set guifont=Iosevka:h20
  elseif exists('g:goneovim') " goneovim
    set guifont=Iosevka:h14
  elseif has('gui_vimr') " https://github.com/qvacua/vimr/wiki
    " font settings in the preferences
    set guifont=Iosevka\ Nerd\ Font\ Complete:h18
  else " cli
    let background = theme_cli_background
    let themes = theme_cli
  endif

  " Finally set the theme
  if background ==# 'light'
    exec 'colorscheme ' . themes[1]
    let &background = 'light'
  else
    exec 'colorscheme ' . themes[0]
    let &background = 'dark'
  endif
endfunction

call SetDefaultTheme()
" }}}

" vim-unimpared: use `co` {{{
" https://github.com/tpope/vim-unimpaired/issues/150
nmap co yo
" }}}

function! Vaporwave()
  if hostname() == "misamino"
    set guifont=Ac437\ ACM\ VGA\ 8x16:h18
  else
    set guifont=Mx437\ ToshibaSat\ 8x16:h16
  endif
  colorschemea borland
endfunction

command Vaporwave call Vaporwave()

" https://stackoverflow.com/a/37558470
" augroup remember_folds
"   autocmd!
"   autocmd BufWinLeave * silent! mkview
"   autocmd BufWinEnter * silent! loadview
" augroup END

function GetVimHome()
  let vimhome = $HOME . '/.config/nvim'
  return vimhome
endfunction

" Update vim config {{{
function! UpdateVimConfig()
  let vimhome = GetVimHome()
  let cmd = 'cd ' . vimhome . '; echo Updating vim config...; git pull --rebase --autostash'
  exec 'FloatermNew --width=80 --height=24 --autoclose=0 ' . cmd
endfunction


" Reload all files
if !exists('*ReloadVimConfig')
  function! ReloadVimConfig()
    echohl Comment
    echomsg 'Reloading files...'
    let files = globpath(&rtp, 'plugin/*.vim', 0, 1)
      \ + globpath(&rtp, 'init.vim', 0, 1)
      \ + globpath(&rtp, 'after/plugin/*.vim', 0, 1)
    for file in files
      exec 'source ' . file
    endfor
    echomsg 'Done ✓'
    echohl None
  endfunction
endif


" Update vim plugins
function! UpdateVimPlugins()
  let vimrc = globpath(&rtp, 'init.vim')
  exec 'source ' . vimrc
  if exists(':PlugInstall')
    PlugInstall
    PlugUpdate
    PlugDiff
  endif
endfunction

command! UpdateVimConfig call UpdateVimConfig()
command! ReloadVimConfig call ReloadVimConfig()
command! UpdateVimPlugins call UpdateVimPlugins()
" }}}

" Automatic loadview {{{
" use :mkview to save the view
augroup automatic_loadview
  autocmd BufWinEnter * silent! loadview
"  autocmd BufWinEnter *.md silent! loadview
"  autocmd BufWinLeave *.md silent mkview
augroup END
" }}}
"

function! GitFastsyncI()
  Gcd
  w
  split
  term git-fastsync -i
endfunction

function! GitFastsync()
  Gcd
  w
  FloatermNew --height=7 --width=80 --autoclose=1 pwd; git-fastsync
endfunction

command! S call GitFastsync()
command! SS call GitFastsyncI()

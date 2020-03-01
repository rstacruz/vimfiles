" set background=light
" hi clear
" if exists("syntax_on")
"   syntax reset
" endif

" let colors_name = "peachpuff"

" hi Normal guibg=PeachPuff guifg=Black
" hi IncSearch term=reverse cterm=reverse gui=reverse
" hi Search term=reverse ctermbg=3 guibg=Gold2
" hi ModeMsg term=bold cterm=bold gui=bold
" hi StatusLine term=bold,reverse cterm=bold,reverse gui=bold guifg=White guibg=Black
" hi StatusLineNC term=reverse cterm=reverse gui=bold guifg=PeachPuff guibg=Gray45
" hi VertSplit term=reverse cterm=reverse gui=bold guifg=White guibg=Gray45
" hi Title term=bold ctermfg=5 gui=bold guifg=DeepPink3
" hi Visual term=reverse cterm=reverse gui=reverse guifg=Grey80 guibg=fg
" hi WarningMsg term=standout ctermfg=1 gui=bold guifg=Red
" hi WildMenu term=standout ctermfg=0 ctermbg=3 guifg=Black guibg=Yellow
" hi Folded term=standout ctermfg=4 ctermbg=7 guifg=Black guibg=#e3c1a5
" hi FoldColumn term=standout ctermfg=4 ctermbg=7 guifg=DarkBlue guibg=Gray80
" hi DiffAdd term=bold ctermbg=4 guibg=White
" hi DiffChange term=bold ctermbg=5 guibg=#edb5cd
" hi DiffDelete term=bold cterm=bold ctermfg=4 ctermbg=6 gui=bold guifg=LightBlue guibg=#f6e8d0
" hi DiffText term=reverse cterm=bold ctermbg=1 gui=bold guibg=#ff8060
" hi Cursor guifg=bg guibg=fg
" hi lCursor guifg=bg guibg=fg

function! dyntheme#base#set_custom_theme(colors)
  " Colors for syntax highlighting
  let c = a:colors

  exe 'hi Comment    term=bold ctermfg='.c.4.' guifg=#406090'
  exe 'hi Constant   term=underline ctermfg='.c.1.' guifg=#c00058'
  exe 'hi Special    term=bold ctermfg='.c.5.' guifg=SlateBlue'
  exe 'hi Identifier term=underline ctermfg='.c.6.' guifg=DarkCyan'
  exe 'hi Statement  term=bold ctermfg='.c.3.' gui=bold guifg=Brown'
  exe 'hi PreProc    term=underline ctermfg='.c.5.' guifg=Magenta3'
  exe 'hi Type       term=underline ctermfg='.c.2.' gui=bold guifg=SeaGreen'
  exe 'hi Ignore     cterm=bold ctermfg='.c.7.' guifg=bg'
  exe 'hi Error      term=reverse cterm=bold ctermfg='.c.7.' ctermbg='.c.1.' gui=bold guifg=White guibg=Red'
  exe 'hi Todo       term=standout ctermfg=0 ctermbg='.c.3 .' guifg=Blue guibg=Yellow'

  exe 'hi SpecialKey term=bold ctermfg='.c.4.' guifg=Blue'
  exe 'hi NonText    term=bold cterm=bold ctermfg='.c.4.' gui=bold guifg=Blue'
  exe 'hi Directory  term=bold ctermfg='.c.4.' guifg=Blue'
  exe 'hi ErrorMsg   term=standout cterm=bold ctermfg='.c.7. ' ctermbg=1 gui=bold guifg=White guibg=Red'
  exe 'hi MoreMsg    term=bold ctermfg='.c.2.' gui=bold guifg=SeaGreen'
  exe 'hi LineNr     term=underline ctermfg='.c.3.' guifg=Red3'
  exe 'hi Question   term=standout ctermfg='.c.2.' gui=bold guifg=SeaGreen'
endfunction

function! dyntheme#base#set_theme_1()
  let c = {
    \ '1': '1',
    \ '2': '2',
    \ '3': '3',
    \ '4': '4',
    \ '5': '5',
    \ '6': '6',
    \ '7': '7',
    \ }
  call dyntheme#base#set_custom_theme(c)
endfunction

function! dyntheme#base#set_theme_2()
  let c = {
    \ '1': '1',
    \ '2': '3',
    \ '3': '4',
    \ '4': '5',
    \ '5': '6',
    \ '6': '7',
    \ '7': '2',
    \ }
  call dyntheme#base#set_custom_theme(c)
endfunction

set background=dark "or light
highlight clear
if exists("syntax_on")
	syntax reset
endif
let g:colors_name = "vivify"
set t_Co=256

highlight Boolean             guifg=#dca3a3 ctermfg=181                           gui=bold cterm=bold
highlight Character           guifg=#dca3a3 ctermfg=181                           gui=bold cterm=bold
highlight Comment             guifg=#7f7f7f ctermfg=8                             gui=none cterm=none
highlight Condtional          guifg=#8fffff ctermfg=123                           gui=none cterm=none
highlight Constant            guifg=#dca3a3 ctermfg=181                           gui=bold cterm=bold
highlight Cursor              guifg=#000000 ctermfg=0   guibg=#aeaeae ctermbg=145 gui=none cterm=none
highlight Debug               guifg=#dca3a3 ctermfg=181                           gui=bold cterm=bold
highlight Define              guifg=#ffcfaf ctermfg=223                           gui=bold cterm=bold
highlight Delimiter           guifg=#8f8f8f ctermfg=245                           gui=none cterm=none
highlight DiffAdd             guifg=#eeeeee ctermfg=255 guibg=#613c46 ctermbg=168 gui=none cterm=none
highlight DiffChange          guifg=#eeeeee ctermfg=255 guibg=#333333 ctermbg=236 gui=none cterm=none
highlight DiffDelete          guifg=#333333 ctermfg=236 guibg=#464646 ctermbg=238 gui=none cterm=none
highlight DiffText            guifg=#ffffff ctermfg=15  guibg=#1f1f1f ctermbg=234 gui=bold cterm=bold
highlight Directory           guifg=#ffffff ctermfg=15                            gui=bold cterm=bold
highlight Error               guifg=#000000 ctermfg=0   guibg=#00ffff ctermbg=14  gui=none cterm=none
highlight ErrorMsg            guifg=#000000 ctermfg=0   guibg=#00c0cf ctermbg=44  gui=none cterm=none
highlight Exception           guifg=#8fffff ctermfg=123                           gui=underline cterm=underline
highlight Float               guifg=#9c93b3 ctermfg=103                           gui=none cterm=none
highlight FoldColumn          guifg=#dca3a3 ctermfg=181 guibg=#464646 ctermbg=238 gui=none cterm=none
highlight Folded              guifg=#dca3a3 ctermfg=181 guibg=#333333 ctermbg=236 gui=none cterm=none
highlight Function            guifg=#ffff8f ctermfg=228                           gui=none cterm=none
highlight Identifier          guifg=#ffffff ctermfg=15                            gui=none cterm=none
highlight Include             guifg=#ffcfaf ctermfg=223                           gui=bold cterm=bold
highlight IncSearch           guifg=#000000 ctermfg=0   guibg=#c15c66 ctermbg=168 gui=none cterm=none
highlight Keyword             guifg=#ffffff ctermfg=15                            gui=bold cterm=bold
highlight Label               guifg=#8fffff ctermfg=123                           gui=underline cterm=underline
highlight LineNr              guifg=#7f7f7f ctermfg=8   guibg=#473e47 ctermbg=238 gui=none cterm=none
highlight Macro               guifg=#ffcfaf ctermfg=223                           gui=bold cterm=bold
highlight ModeMsg             guifg=#dca3a3 ctermfg=181                           gui=bold cterm=bold
highlight MoreMsg             guifg=#ffffff ctermfg=15                            gui=bold cterm=bold
highlight NonText             guifg=#1f1f1f ctermfg=234                           gui=none cterm=none
highlight Normal              guifg=#cccccc ctermfg=252 guibg=#3f3f3f ctermbg=237 gui=none cterm=none
highlight Number              guifg=#aca0a3 ctermfg=168                           gui=none cterm=none
highlight Operator            guifg=#ffffff ctermfg=15                            gui=none cterm=none
highlight PreCondit           guifg=#dfaf8f ctermfg=180                           gui=bold cterm=bold
highlight PreProc             guifg=#ffcfaf ctermfg=223                           gui=bold cterm=bold
highlight Question            guifg=#ffffff ctermfg=15                            gui=bold cterm=bold
highlight Repeat              guifg=#8fffff ctermfg=123                           gui=underline cterm=underline
highlight Search              guifg=#000000 ctermfg=0   guibg=#c15c66 ctermbg=168 gui=none cterm=none
highlight SpecialChar         guifg=#dca3a3 ctermfg=181                           gui=bold cterm=bold
highlight SpecialComment      guifg=#dca3a3 ctermfg=181                           gui=bold cterm=bold
highlight Special             guifg=#7f7f7f ctermfg=8                             gui=none cterm=none
highlight SpecialKey          guifg=#7e7e7e ctermfg=8                             gui=none cterm=none
highlight Statement           guifg=#8fffff ctermfg=123                           gui=none cterm=none
highlight StatusLine          guifg=#333333 ctermfg=236 guibg=#f18c96 ctermbg=211 gui=none cterm=none
highlight StatusLineNC        guifg=#333333 ctermfg=236 guibg=#cccccc ctermbg=252 gui=none cterm=none
highlight StorageClass        guifg=#ffffff ctermfg=15                            gui=bold cterm=bold
highlight String              guifg=#cc9393 ctermfg=174                           gui=none cterm=none
highlight Structure           guifg=#ffffff ctermfg=15                            gui=bold,underline cterm=bold,underline
highlight Tag                 guifg=#dca3a3 ctermfg=181                           gui=bold cterm=bold
highlight Title               guifg=#ffffff ctermfg=15  guibg=#333333 ctermbg=236 gui=bold cterm=bold
highlight Todo                guifg=#ffffff ctermfg=15  guibg=#000000 ctermbg=0   gui=bold cterm=bold
highlight Typedef             guifg=#ffffff ctermfg=15                            gui=bold,underline cterm=bold,underline
highlight Type                guifg=#ffffff ctermfg=15                            gui=bold cterm=bold
highlight VertSplit           guifg=#333333 ctermfg=236 guibg=#cccccc ctermbg=252 gui=none cterm=none
highlight Visual              guifg=#333333 ctermfg=236 guibg=#f18c96 ctermbg=211 gui=none cterm=none
highlight VisualNOS           guifg=#333333 ctermfg=236 guibg=#f18c96 ctermbg=211 gui=bold,underline cterm=bold,underline
highlight WarningMsg          guifg=#ffffff ctermfg=15  guibg=#333333 ctermbg=236 gui=bold cterm=bold
highlight WildMenu            guifg=#000000 ctermfg=0   guibg=#dca3a3 ctermbg=181 gui=none cterm=none
highlight pythonBuiltin       guifg=#cccccc ctermfg=252                           gui=none cterm=none

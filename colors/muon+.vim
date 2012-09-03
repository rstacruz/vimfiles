"Maintainer:    Greg Sexton <gregsexton@gmail.com>
"Last Change:   2012-08-04
"Version:       1.0
"URL:           http://www.gregsexton.org/vim-color-schemes/muon/

set background=dark
if version > 580
    "no guarantees for version 5.8 and below, but this makes it stop complaining
    hi clear
    if exists("syntax_on")
	syntax reset
    endif
endif
let g:colors_name="muon+"

hi Normal       ctermfg=250 ctermbg=16
hi LineNr       ctermfg=239 ctermbg=16
hi NonText      ctermfg=16 ctermbg=16

hi VertSplit    ctermfg=237 ctermbg=235 cterm=none
hi StatusLine   ctermfg=249 ctermbg=235 cterm=none
hi StatusLineNC ctermfg=243 ctermbg=235 cterm=none

hi DiffDelete   ctermfg=16 ctermbg=233
hi DiffAdd      ctermbg=236
hi DiffChange   ctermbg=235
hi DiffText     ctermfg=161 ctermbg=16 cterm=underline

hi Cursor       ctermfg=16 ctermbg=250

hi Visual       ctermfg=16 ctermbg=122

hi Folded       ctermfg=244 ctermbg=235
hi FoldColumn   ctermfg=244 ctermbg=16

hi IncSearch    ctermfg=16 ctermbg=214 cterm=underline
hi Search       ctermfg=16 ctermbg=214 cterm=none

hi ModeMsg      ctermfg=117 ctermbg=16 cterm=bold
hi MoreMsg      ctermfg=122 ctermbg=16 cterm=none
hi Question     ctermfg=122 ctermbg=16 cterm=bold
hi WarningMsg   ctermfg=122 ctermbg=16 cterm=none
hi ErrorMsg     ctermfg=255 ctermbg=160 cterm=none
hi Error        ctermfg=196 ctermbg=16 cterm=none

hi SpecialKey   ctermfg=214 ctermbg=16
hi Title        ctermfg=075 ctermbg=16 cterm=bold
hi Directory    ctermfg=117 ctermbg=16 cterm=bold

hi SignColumn   ctermfg=214 ctermbg=235

hi WildMenu     ctermfg=075 ctermbg=235 cterm=bold

if version >= 700 " Vim 7.x specific colors
    hi CursorLine   ctermbg=235 cterm=none
    hi CursorColumn ctermbg=235 cterm=none

    hi MatchParen   ctermfg=196 ctermbg=16 cterm=bold,reverse

    hi Tabline      ctermfg=245 ctermbg=235 cterm=underline
    hi TablineSel   ctermfg=250 ctermbg=16 cterm=bold
    hi TablineFill  ctermfg=250 ctermbg=237 cterm=underline

    hi Pmenu        ctermfg=250 ctermbg=235 cterm=none
    hi PmenuSel     ctermfg=117 ctermbg=16 cterm=underline
    hi PmenuSbar    ctermfg=116 ctermbg=16 cterm=none
    hi PmenuThumb   ctermfg=116 ctermbg=116 cterm=none

    hi SpellBad     ctermfg=198 ctermbg=16 cterm=underline
    hi SpellCap     ctermfg=198 ctermbg=16 cterm=none
    hi SpellRare    ctermfg=198 ctermbg=16 cterm=none
    hi SpellLocal   ctermfg=198 ctermbg=16 cterm=none
endif

if version >= 703 " Vim 7.3 specific colors
    hi ColorColumn ctermbg=235
endif

" syntax highlighting groups
hi Comment    ctermfg=240 ctermbg=16
hi Constant   ctermfg=086 ctermbg=16
hi Identifier ctermfg=080 ctermbg=16 cterm=bold
hi String     ctermfg=074 ctermbg=16
hi Statement  ctermfg=159 ctermbg=16 cterm=none
hi PreProc    ctermfg=122 ctermbg=16
hi Function   ctermfg=121 ctermbg=16 cterm=bold
hi Type       ctermfg=117 ctermbg=16 cterm=bold
hi Special    ctermfg=050 ctermbg=16
hi Delimiter  ctermfg=153 ctermbg=16
hi Number     ctermfg=086 ctermbg=16
hi Ignore     ctermfg=214 ctermbg=16
hi Todo       ctermfg=196 ctermbg=16
hi Exception  ctermfg=080 ctermbg=16 cterm=bold

"vim: sw=4

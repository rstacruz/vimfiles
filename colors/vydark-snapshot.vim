" This scheme was created by CSApproxSnapshot
" on Mon, 29 Aug 2011

hi clear
if exists("syntax_on")
    syntax reset
endif

if v:version < 700
    let g:colors_name = expand("<sfile>:t:r")
    command! -nargs=+ CSAHi exe "hi" substitute(substitute(<q-args>, "undercurl", "underline", "g"), "guisp\\S\\+", "", "g")
else
    let g:colors_name = expand("<sfile>:t:r")
    command! -nargs=+ CSAHi exe "hi" <q-args>
endif

function! s:old_kde()
  " Konsole only used its own palette up til KDE 4.2.0
  if executable('kde4-config') && system('kde4-config --kde-version') =~ '^4.[10].'
    return 1
  elseif executable('kde-config') && system('kde-config --version') =~# 'KDE: 3.'
    return 1
  else
    return 0
  endif
endfunction

if 0
elseif has("gui_running") || (&t_Co == 256 && (&term ==# "xterm" || &term =~# "^screen") && exists("g:CSApprox_konsole") && g:CSApprox_konsole) || (&term =~? "^konsole" && s:old_kde())
    CSAHi Normal term=NONE cterm=NONE ctermbg=16 ctermfg=250 gui=NONE guibg=#151618 guifg=#bbbbbb
    CSAHi shTest term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shDblParen term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shDerefEscape term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi bashSpecialVariables term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi bashStatement term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shCase term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi Todo term=NONE cterm=NONE ctermbg=236 ctermfg=103 gui=italic guibg=#303030 guifg=#8888aa
    CSAHi Operator term=NONE cterm=NONE ctermbg=bg ctermfg=250 gui=NONE guibg=bg guifg=#bbbbbb
    CSAHi Identifier term=underline cterm=NONE ctermbg=bg ctermfg=250 gui=NONE guibg=bg guifg=#bbbbbb
    CSAHi Statement term=bold cterm=NONE ctermbg=bg ctermfg=250 gui=NONE guibg=bg guifg=#bbbbbb
    CSAHi Type term=underline cterm=NONE ctermbg=bg ctermfg=110 gui=NONE guibg=bg guifg=#99bbcc
    CSAHi Constant term=underline cterm=NONE ctermbg=bg ctermfg=114 gui=NONE guibg=bg guifg=#88cc99
    CSAHi Conditional term=NONE cterm=NONE ctermbg=bg ctermfg=110 gui=NONE guibg=bg guifg=#99bbcc
    CSAHi Delimiter term=NONE cterm=NONE ctermbg=bg ctermfg=110 gui=NONE guibg=bg guifg=#99bbdd
    CSAHi PreProc term=underline cterm=NONE ctermbg=bg ctermfg=116 gui=NONE guibg=bg guifg=#88ddcc
    CSAHi SpecialKey term=bold cterm=NONE ctermbg=bg ctermfg=51 gui=NONE guibg=bg guifg=Cyan
    CSAHi NonText term=bold cterm=bold ctermbg=16 ctermfg=16 gui=bold guibg=#151618 guifg=#151618
    CSAHi Directory term=bold cterm=NONE ctermbg=bg ctermfg=51 gui=NONE guibg=bg guifg=Cyan
    CSAHi ErrorMsg term=NONE cterm=NONE ctermbg=210 ctermfg=235 gui=NONE guibg=#ff8888 guifg=#222222
    CSAHi IncSearch term=reverse cterm=bold ctermbg=59 ctermfg=229 gui=bold guibg=#666633 guifg=#eeeeaa
    CSAHi Search term=reverse cterm=NONE ctermbg=59 ctermfg=186 gui=NONE guibg=#444433 guifg=#dddd99
    CSAHi MoreMsg term=bold cterm=bold ctermbg=bg ctermfg=29 gui=bold guibg=bg guifg=SeaGreen
    CSAHi ModeMsg term=bold cterm=NONE ctermbg=59 ctermfg=114 gui=NONE guibg=#394439 guifg=#99dd99
    CSAHi LineNr term=underline cterm=NONE ctermbg=16 ctermfg=59 gui=NONE guibg=#151618 guifg=#444455
    CSAHi shCaseEsacSync term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shDoSync term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shForSync term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shIfSync term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shUntilSync term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shWhileSync term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shDerefVarArray term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shDblBrace term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shDerefPPSleft term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi Underlined term=underline cterm=underline ctermbg=bg ctermfg=111 gui=underline guibg=bg guifg=#80a0ff
    CSAHi Ignore term=NONE cterm=NONE ctermbg=bg ctermfg=16 gui=NONE guibg=bg guifg=bg
    CSAHi SpellLocal term=underline cterm=undercurl ctermbg=bg ctermfg=95 gui=undercurl guibg=bg guifg=fg guisp=#774444
    CSAHi Pmenu term=NONE cterm=NONE ctermbg=238 ctermfg=250 gui=NONE guibg=#444444 guifg=#bbbbbb
    CSAHi PmenuSel term=NONE cterm=NONE ctermbg=110 ctermfg=235 gui=NONE guibg=#99bbdd guifg=#222222
    CSAHi PmenuSbar term=NONE cterm=bold ctermbg=238 ctermfg=238 gui=bold guibg=#494949 guifg=#494949
    CSAHi PmenuThumb term=NONE cterm=bold ctermbg=241 ctermfg=241 gui=bold guibg=#666666 guifg=#666666
    CSAHi TabLine term=underline cterm=underline ctermbg=248 ctermfg=fg gui=underline guibg=DarkGrey guifg=fg
    CSAHi TabLineSel term=bold cterm=bold ctermbg=bg ctermfg=fg gui=bold guibg=bg guifg=fg
    CSAHi TabLineFill term=reverse cterm=reverse ctermbg=bg ctermfg=fg gui=reverse guibg=bg guifg=fg
    CSAHi CursorColumn term=reverse cterm=NONE ctermbg=241 ctermfg=fg gui=NONE guibg=Grey40 guifg=fg
    CSAHi CursorLine term=underline cterm=NONE ctermbg=236 ctermfg=fg gui=NONE guibg=#353535 guifg=fg
    CSAHi shCurlyIn term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi bashAdminStatement term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi kshSpecialVariables term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi kshStatement term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shCaseExSingleQuote term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shCaseRange term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shDo term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi helpNormal term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi Special term=bold cterm=bold ctermbg=bg ctermfg=114 gui=bold guibg=bg guifg=#99dd99
    CSAHi Keyword term=NONE cterm=NONE ctermbg=bg ctermfg=250 gui=NONE guibg=bg guifg=#bbbbbb
    CSAHi Question term=NONE cterm=bold ctermbg=bg ctermfg=46 gui=bold guibg=bg guifg=Green
    CSAHi StatusLine term=bold,reverse cterm=NONE ctermbg=236 ctermfg=250 gui=NONE guibg=#353535 guifg=#bbbbbb
    CSAHi StatusLineNC term=reverse cterm=NONE ctermbg=236 ctermfg=243 gui=NONE guibg=#353535 guifg=#777777
    CSAHi VertSplit term=reverse cterm=NONE ctermbg=236 ctermfg=236 gui=NONE guibg=#353535 guifg=#353535
    CSAHi Title term=bold cterm=bold ctermbg=bg ctermfg=231 gui=bold guibg=bg guifg=white
    CSAHi Visual term=reverse cterm=NONE ctermbg=240 ctermfg=fg gui=NONE guibg=#555555 guifg=fg
    CSAHi VisualNOS term=bold,underline cterm=bold,underline ctermbg=bg ctermfg=fg gui=bold,underline guibg=bg guifg=fg
    CSAHi WarningMsg term=NONE cterm=NONE ctermbg=bg ctermfg=196 gui=NONE guibg=bg guifg=Red
    CSAHi WildMenu term=NONE cterm=NONE ctermbg=226 ctermfg=16 gui=NONE guibg=Yellow guifg=Black
    CSAHi Folded term=NONE cterm=NONE ctermbg=235 ctermfg=60 gui=NONE guibg=#242424 guifg=#666677
    CSAHi helpLeadBlank term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shSpecialVar term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shOK term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shCaseEsac term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi ColorColumn term=reverse cterm=NONE ctermbg=235 ctermfg=fg gui=NONE guibg=#252525 guifg=fg
    CSAHi Cursor term=NONE cterm=NONE ctermbg=231 ctermfg=16 gui=NONE guibg=#ffffff guifg=bg
    CSAHi lCursor term=NONE cterm=NONE ctermbg=250 ctermfg=16 gui=NONE guibg=fg guifg=bg
    CSAHi MatchParen term=reverse cterm=NONE ctermbg=59 ctermfg=fg gui=NONE guibg=#364836 guifg=fg
    CSAHi Error term=reverse cterm=NONE ctermbg=236 ctermfg=217 gui=NONE guibg=#333333 guifg=#ffaaaa
    CSAHi Comment term=bold cterm=NONE ctermbg=bg ctermfg=60 gui=NONE guibg=bg guifg=#666677
    CSAHi EasyMotionTargetDefault term=NONE cterm=bold ctermbg=bg ctermfg=196 gui=bold guibg=bg guifg=#ff0000
    CSAHi EasyMotionShadeDefault term=NONE cterm=NONE ctermbg=bg ctermfg=240 gui=NONE guibg=bg guifg=#585858
    CSAHi shSetIdentifier term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shFunctionTwo term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shFunctionStart term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shFunctionOne term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shDerefPattern term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shExpr term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shFor term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shIf term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shSubSh term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shComma term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shDerefPPSright term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi FoldColumn term=NONE cterm=NONE ctermbg=250 ctermfg=51 gui=NONE guibg=Grey guifg=Cyan
    CSAHi DiffAdd term=bold cterm=NONE ctermbg=18 ctermfg=fg gui=NONE guibg=DarkBlue guifg=fg
    CSAHi DiffChange term=bold cterm=NONE ctermbg=90 ctermfg=fg gui=NONE guibg=DarkMagenta guifg=fg
    CSAHi DiffDelete term=bold cterm=bold ctermbg=30 ctermfg=21 gui=bold guibg=DarkCyan guifg=Blue
    CSAHi DiffText term=reverse cterm=bold ctermbg=196 ctermfg=fg gui=bold guibg=Red guifg=fg
    CSAHi SignColumn term=NONE cterm=NONE ctermbg=250 ctermfg=51 gui=NONE guibg=Grey guifg=Cyan
    CSAHi Conceal term=NONE cterm=NONE ctermbg=248 ctermfg=252 gui=NONE guibg=DarkGrey guifg=LightGrey
    CSAHi SpellBad term=reverse cterm=undercurl ctermbg=bg ctermfg=95 gui=undercurl guibg=bg guifg=fg guisp=#774444
    CSAHi SpellCap term=reverse cterm=undercurl ctermbg=bg ctermfg=95 gui=undercurl guibg=bg guifg=fg guisp=#774444
    CSAHi SpellRare term=reverse cterm=undercurl ctermbg=bg ctermfg=95 gui=undercurl guibg=bg guifg=fg guisp=#774444
elseif has("gui_running") || (&t_Co == 256 && (&term ==# "xterm" || &term =~# "^screen") && exists("g:CSApprox_eterm") && g:CSApprox_eterm) || &term =~? "^eterm"
    CSAHi Normal term=NONE cterm=NONE ctermbg=16 ctermfg=250 gui=NONE guibg=#151618 guifg=#bbbbbb
    CSAHi shTest term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shDblParen term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shDerefEscape term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi bashSpecialVariables term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi bashStatement term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shCase term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi Todo term=NONE cterm=NONE ctermbg=236 ctermfg=103 gui=italic guibg=#303030 guifg=#8888aa
    CSAHi Operator term=NONE cterm=NONE ctermbg=bg ctermfg=250 gui=NONE guibg=bg guifg=#bbbbbb
    CSAHi Identifier term=underline cterm=NONE ctermbg=bg ctermfg=250 gui=NONE guibg=bg guifg=#bbbbbb
    CSAHi Statement term=bold cterm=NONE ctermbg=bg ctermfg=250 gui=NONE guibg=bg guifg=#bbbbbb
    CSAHi Type term=underline cterm=NONE ctermbg=bg ctermfg=110 gui=NONE guibg=bg guifg=#99bbcc
    CSAHi Constant term=underline cterm=NONE ctermbg=bg ctermfg=114 gui=NONE guibg=bg guifg=#88cc99
    CSAHi Conditional term=NONE cterm=NONE ctermbg=bg ctermfg=110 gui=NONE guibg=bg guifg=#99bbcc
    CSAHi Delimiter term=NONE cterm=NONE ctermbg=bg ctermfg=110 gui=NONE guibg=bg guifg=#99bbdd
    CSAHi PreProc term=underline cterm=NONE ctermbg=bg ctermfg=116 gui=NONE guibg=bg guifg=#88ddcc
    CSAHi SpecialKey term=bold cterm=NONE ctermbg=bg ctermfg=51 gui=NONE guibg=bg guifg=Cyan
    CSAHi NonText term=bold cterm=bold ctermbg=16 ctermfg=16 gui=bold guibg=#151618 guifg=#151618
    CSAHi Directory term=bold cterm=NONE ctermbg=bg ctermfg=51 gui=NONE guibg=bg guifg=Cyan
    CSAHi ErrorMsg term=NONE cterm=NONE ctermbg=210 ctermfg=235 gui=NONE guibg=#ff8888 guifg=#222222
    CSAHi IncSearch term=reverse cterm=bold ctermbg=59 ctermfg=229 gui=bold guibg=#666633 guifg=#eeeeaa
    CSAHi Search term=reverse cterm=NONE ctermbg=59 ctermfg=186 gui=NONE guibg=#444433 guifg=#dddd99
    CSAHi MoreMsg term=bold cterm=bold ctermbg=bg ctermfg=29 gui=bold guibg=bg guifg=SeaGreen
    CSAHi ModeMsg term=bold cterm=NONE ctermbg=59 ctermfg=114 gui=NONE guibg=#394439 guifg=#99dd99
    CSAHi LineNr term=underline cterm=NONE ctermbg=16 ctermfg=59 gui=NONE guibg=#151618 guifg=#444455
    CSAHi shCaseEsacSync term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shDoSync term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shForSync term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shIfSync term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shUntilSync term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shWhileSync term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shDerefVarArray term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shDblBrace term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shDerefPPSleft term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi Underlined term=underline cterm=underline ctermbg=bg ctermfg=111 gui=underline guibg=bg guifg=#80a0ff
    CSAHi Ignore term=NONE cterm=NONE ctermbg=bg ctermfg=16 gui=NONE guibg=bg guifg=bg
    CSAHi SpellLocal term=underline cterm=undercurl ctermbg=bg ctermfg=95 gui=undercurl guibg=bg guifg=fg guisp=#774444
    CSAHi Pmenu term=NONE cterm=NONE ctermbg=238 ctermfg=250 gui=NONE guibg=#444444 guifg=#bbbbbb
    CSAHi PmenuSel term=NONE cterm=NONE ctermbg=110 ctermfg=235 gui=NONE guibg=#99bbdd guifg=#222222
    CSAHi PmenuSbar term=NONE cterm=bold ctermbg=238 ctermfg=238 gui=bold guibg=#494949 guifg=#494949
    CSAHi PmenuThumb term=NONE cterm=bold ctermbg=241 ctermfg=241 gui=bold guibg=#666666 guifg=#666666
    CSAHi TabLine term=underline cterm=underline ctermbg=248 ctermfg=fg gui=underline guibg=DarkGrey guifg=fg
    CSAHi TabLineSel term=bold cterm=bold ctermbg=bg ctermfg=fg gui=bold guibg=bg guifg=fg
    CSAHi TabLineFill term=reverse cterm=reverse ctermbg=bg ctermfg=fg gui=reverse guibg=bg guifg=fg
    CSAHi CursorColumn term=reverse cterm=NONE ctermbg=241 ctermfg=fg gui=NONE guibg=Grey40 guifg=fg
    CSAHi CursorLine term=underline cterm=NONE ctermbg=236 ctermfg=fg gui=NONE guibg=#353535 guifg=fg
    CSAHi shCurlyIn term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi bashAdminStatement term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi kshSpecialVariables term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi kshStatement term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shCaseExSingleQuote term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shCaseRange term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shDo term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi helpNormal term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi Special term=bold cterm=bold ctermbg=bg ctermfg=114 gui=bold guibg=bg guifg=#99dd99
    CSAHi Keyword term=NONE cterm=NONE ctermbg=bg ctermfg=250 gui=NONE guibg=bg guifg=#bbbbbb
    CSAHi Question term=NONE cterm=bold ctermbg=bg ctermfg=46 gui=bold guibg=bg guifg=Green
    CSAHi StatusLine term=bold,reverse cterm=NONE ctermbg=236 ctermfg=250 gui=NONE guibg=#353535 guifg=#bbbbbb
    CSAHi StatusLineNC term=reverse cterm=NONE ctermbg=236 ctermfg=243 gui=NONE guibg=#353535 guifg=#777777
    CSAHi VertSplit term=reverse cterm=NONE ctermbg=236 ctermfg=236 gui=NONE guibg=#353535 guifg=#353535
    CSAHi Title term=bold cterm=bold ctermbg=bg ctermfg=231 gui=bold guibg=bg guifg=white
    CSAHi Visual term=reverse cterm=NONE ctermbg=240 ctermfg=fg gui=NONE guibg=#555555 guifg=fg
    CSAHi VisualNOS term=bold,underline cterm=bold,underline ctermbg=bg ctermfg=fg gui=bold,underline guibg=bg guifg=fg
    CSAHi WarningMsg term=NONE cterm=NONE ctermbg=bg ctermfg=196 gui=NONE guibg=bg guifg=Red
    CSAHi WildMenu term=NONE cterm=NONE ctermbg=226 ctermfg=16 gui=NONE guibg=Yellow guifg=Black
    CSAHi Folded term=NONE cterm=NONE ctermbg=235 ctermfg=60 gui=NONE guibg=#242424 guifg=#666677
    CSAHi helpLeadBlank term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shSpecialVar term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shOK term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shCaseEsac term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi ColorColumn term=reverse cterm=NONE ctermbg=235 ctermfg=fg gui=NONE guibg=#252525 guifg=fg
    CSAHi Cursor term=NONE cterm=NONE ctermbg=231 ctermfg=16 gui=NONE guibg=#ffffff guifg=bg
    CSAHi lCursor term=NONE cterm=NONE ctermbg=250 ctermfg=16 gui=NONE guibg=fg guifg=bg
    CSAHi MatchParen term=reverse cterm=NONE ctermbg=59 ctermfg=fg gui=NONE guibg=#364836 guifg=fg
    CSAHi Error term=reverse cterm=NONE ctermbg=236 ctermfg=217 gui=NONE guibg=#333333 guifg=#ffaaaa
    CSAHi Comment term=bold cterm=NONE ctermbg=bg ctermfg=60 gui=NONE guibg=bg guifg=#666677
    CSAHi EasyMotionTargetDefault term=NONE cterm=bold ctermbg=bg ctermfg=196 gui=bold guibg=bg guifg=#ff0000
    CSAHi EasyMotionShadeDefault term=NONE cterm=NONE ctermbg=bg ctermfg=240 gui=NONE guibg=bg guifg=#585858
    CSAHi shSetIdentifier term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shFunctionTwo term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shFunctionStart term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shFunctionOne term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shDerefPattern term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shExpr term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shFor term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shIf term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shSubSh term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shComma term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shDerefPPSright term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi FoldColumn term=NONE cterm=NONE ctermbg=250 ctermfg=51 gui=NONE guibg=Grey guifg=Cyan
    CSAHi DiffAdd term=bold cterm=NONE ctermbg=18 ctermfg=fg gui=NONE guibg=DarkBlue guifg=fg
    CSAHi DiffChange term=bold cterm=NONE ctermbg=90 ctermfg=fg gui=NONE guibg=DarkMagenta guifg=fg
    CSAHi DiffDelete term=bold cterm=bold ctermbg=30 ctermfg=21 gui=bold guibg=DarkCyan guifg=Blue
    CSAHi DiffText term=reverse cterm=bold ctermbg=196 ctermfg=fg gui=bold guibg=Red guifg=fg
    CSAHi SignColumn term=NONE cterm=NONE ctermbg=250 ctermfg=51 gui=NONE guibg=Grey guifg=Cyan
    CSAHi Conceal term=NONE cterm=NONE ctermbg=248 ctermfg=252 gui=NONE guibg=DarkGrey guifg=LightGrey
    CSAHi SpellBad term=reverse cterm=undercurl ctermbg=bg ctermfg=95 gui=undercurl guibg=bg guifg=fg guisp=#774444
    CSAHi SpellCap term=reverse cterm=undercurl ctermbg=bg ctermfg=95 gui=undercurl guibg=bg guifg=fg guisp=#774444
    CSAHi SpellRare term=reverse cterm=undercurl ctermbg=bg ctermfg=95 gui=undercurl guibg=bg guifg=fg guisp=#774444
elseif has("gui_running") || &t_Co == 256
    CSAHi Normal term=NONE cterm=NONE ctermbg=16 ctermfg=250 gui=NONE guibg=#151618 guifg=#bbbbbb
    CSAHi shTest term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shDblParen term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shDerefEscape term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi bashSpecialVariables term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi bashStatement term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shCase term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi Todo term=NONE cterm=NONE ctermbg=236 ctermfg=103 gui=italic guibg=#303030 guifg=#8888aa
    CSAHi Operator term=NONE cterm=NONE ctermbg=bg ctermfg=250 gui=NONE guibg=bg guifg=#bbbbbb
    CSAHi Identifier term=underline cterm=NONE ctermbg=bg ctermfg=250 gui=NONE guibg=bg guifg=#bbbbbb
    CSAHi Statement term=bold cterm=NONE ctermbg=bg ctermfg=250 gui=NONE guibg=bg guifg=#bbbbbb
    CSAHi Type term=underline cterm=NONE ctermbg=bg ctermfg=110 gui=NONE guibg=bg guifg=#99bbcc
    CSAHi Constant term=underline cterm=NONE ctermbg=bg ctermfg=114 gui=NONE guibg=bg guifg=#88cc99
    CSAHi Conditional term=NONE cterm=NONE ctermbg=bg ctermfg=110 gui=NONE guibg=bg guifg=#99bbcc
    CSAHi Delimiter term=NONE cterm=NONE ctermbg=bg ctermfg=110 gui=NONE guibg=bg guifg=#99bbdd
    CSAHi PreProc term=underline cterm=NONE ctermbg=bg ctermfg=116 gui=NONE guibg=bg guifg=#88ddcc
    CSAHi SpecialKey term=bold cterm=NONE ctermbg=bg ctermfg=51 gui=NONE guibg=bg guifg=Cyan
    CSAHi NonText term=bold cterm=bold ctermbg=16 ctermfg=16 gui=bold guibg=#151618 guifg=#151618
    CSAHi Directory term=bold cterm=NONE ctermbg=bg ctermfg=51 gui=NONE guibg=bg guifg=Cyan
    CSAHi ErrorMsg term=NONE cterm=NONE ctermbg=210 ctermfg=235 gui=NONE guibg=#ff8888 guifg=#222222
    CSAHi IncSearch term=reverse cterm=bold ctermbg=59 ctermfg=229 gui=bold guibg=#666633 guifg=#eeeeaa
    CSAHi Search term=reverse cterm=NONE ctermbg=59 ctermfg=186 gui=NONE guibg=#444433 guifg=#dddd99
    CSAHi MoreMsg term=bold cterm=bold ctermbg=bg ctermfg=29 gui=bold guibg=bg guifg=SeaGreen
    CSAHi ModeMsg term=bold cterm=NONE ctermbg=59 ctermfg=114 gui=NONE guibg=#394439 guifg=#99dd99
    CSAHi LineNr term=underline cterm=NONE ctermbg=16 ctermfg=59 gui=NONE guibg=#151618 guifg=#444455
    CSAHi shCaseEsacSync term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shDoSync term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shForSync term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shIfSync term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shUntilSync term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shWhileSync term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shDerefVarArray term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shDblBrace term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shDerefPPSleft term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi Underlined term=underline cterm=underline ctermbg=bg ctermfg=111 gui=underline guibg=bg guifg=#80a0ff
    CSAHi Ignore term=NONE cterm=NONE ctermbg=bg ctermfg=16 gui=NONE guibg=bg guifg=bg
    CSAHi SpellLocal term=underline cterm=undercurl ctermbg=bg ctermfg=95 gui=undercurl guibg=bg guifg=fg guisp=#774444
    CSAHi Pmenu term=NONE cterm=NONE ctermbg=238 ctermfg=250 gui=NONE guibg=#444444 guifg=#bbbbbb
    CSAHi PmenuSel term=NONE cterm=NONE ctermbg=110 ctermfg=235 gui=NONE guibg=#99bbdd guifg=#222222
    CSAHi PmenuSbar term=NONE cterm=bold ctermbg=238 ctermfg=238 gui=bold guibg=#494949 guifg=#494949
    CSAHi PmenuThumb term=NONE cterm=bold ctermbg=241 ctermfg=241 gui=bold guibg=#666666 guifg=#666666
    CSAHi TabLine term=underline cterm=underline ctermbg=248 ctermfg=fg gui=underline guibg=DarkGrey guifg=fg
    CSAHi TabLineSel term=bold cterm=bold ctermbg=bg ctermfg=fg gui=bold guibg=bg guifg=fg
    CSAHi TabLineFill term=reverse cterm=reverse ctermbg=bg ctermfg=fg gui=reverse guibg=bg guifg=fg
    CSAHi CursorColumn term=reverse cterm=NONE ctermbg=241 ctermfg=fg gui=NONE guibg=Grey40 guifg=fg
    CSAHi CursorLine term=underline cterm=NONE ctermbg=236 ctermfg=fg gui=NONE guibg=#353535 guifg=fg
    CSAHi shCurlyIn term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi bashAdminStatement term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi kshSpecialVariables term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi kshStatement term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shCaseExSingleQuote term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shCaseRange term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shDo term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi helpNormal term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi Special term=bold cterm=bold ctermbg=bg ctermfg=114 gui=bold guibg=bg guifg=#99dd99
    CSAHi Keyword term=NONE cterm=NONE ctermbg=bg ctermfg=250 gui=NONE guibg=bg guifg=#bbbbbb
    CSAHi Question term=NONE cterm=bold ctermbg=bg ctermfg=46 gui=bold guibg=bg guifg=Green
    CSAHi StatusLine term=bold,reverse cterm=NONE ctermbg=236 ctermfg=250 gui=NONE guibg=#353535 guifg=#bbbbbb
    CSAHi StatusLineNC term=reverse cterm=NONE ctermbg=236 ctermfg=243 gui=NONE guibg=#353535 guifg=#777777
    CSAHi VertSplit term=reverse cterm=NONE ctermbg=236 ctermfg=236 gui=NONE guibg=#353535 guifg=#353535
    CSAHi Title term=bold cterm=bold ctermbg=bg ctermfg=231 gui=bold guibg=bg guifg=white
    CSAHi Visual term=reverse cterm=NONE ctermbg=240 ctermfg=fg gui=NONE guibg=#555555 guifg=fg
    CSAHi VisualNOS term=bold,underline cterm=bold,underline ctermbg=bg ctermfg=fg gui=bold,underline guibg=bg guifg=fg
    CSAHi WarningMsg term=NONE cterm=NONE ctermbg=bg ctermfg=196 gui=NONE guibg=bg guifg=Red
    CSAHi WildMenu term=NONE cterm=NONE ctermbg=226 ctermfg=16 gui=NONE guibg=Yellow guifg=Black
    CSAHi Folded term=NONE cterm=NONE ctermbg=235 ctermfg=60 gui=NONE guibg=#242424 guifg=#666677
    CSAHi helpLeadBlank term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shSpecialVar term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shOK term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shCaseEsac term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi ColorColumn term=reverse cterm=NONE ctermbg=235 ctermfg=fg gui=NONE guibg=#252525 guifg=fg
    CSAHi Cursor term=NONE cterm=NONE ctermbg=231 ctermfg=16 gui=NONE guibg=#ffffff guifg=bg
    CSAHi lCursor term=NONE cterm=NONE ctermbg=250 ctermfg=16 gui=NONE guibg=fg guifg=bg
    CSAHi MatchParen term=reverse cterm=NONE ctermbg=59 ctermfg=fg gui=NONE guibg=#364836 guifg=fg
    CSAHi Error term=reverse cterm=NONE ctermbg=236 ctermfg=217 gui=NONE guibg=#333333 guifg=#ffaaaa
    CSAHi Comment term=bold cterm=NONE ctermbg=bg ctermfg=60 gui=NONE guibg=bg guifg=#666677
    CSAHi EasyMotionTargetDefault term=NONE cterm=bold ctermbg=bg ctermfg=196 gui=bold guibg=bg guifg=#ff0000
    CSAHi EasyMotionShadeDefault term=NONE cterm=NONE ctermbg=bg ctermfg=240 gui=NONE guibg=bg guifg=#585858
    CSAHi shSetIdentifier term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shFunctionTwo term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shFunctionStart term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shFunctionOne term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shDerefPattern term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shExpr term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shFor term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shIf term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shSubSh term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shComma term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shDerefPPSright term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi FoldColumn term=NONE cterm=NONE ctermbg=250 ctermfg=51 gui=NONE guibg=Grey guifg=Cyan
    CSAHi DiffAdd term=bold cterm=NONE ctermbg=18 ctermfg=fg gui=NONE guibg=DarkBlue guifg=fg
    CSAHi DiffChange term=bold cterm=NONE ctermbg=90 ctermfg=fg gui=NONE guibg=DarkMagenta guifg=fg
    CSAHi DiffDelete term=bold cterm=bold ctermbg=30 ctermfg=21 gui=bold guibg=DarkCyan guifg=Blue
    CSAHi DiffText term=reverse cterm=bold ctermbg=196 ctermfg=fg gui=bold guibg=Red guifg=fg
    CSAHi SignColumn term=NONE cterm=NONE ctermbg=250 ctermfg=51 gui=NONE guibg=Grey guifg=Cyan
    CSAHi Conceal term=NONE cterm=NONE ctermbg=248 ctermfg=252 gui=NONE guibg=DarkGrey guifg=LightGrey
    CSAHi SpellBad term=reverse cterm=undercurl ctermbg=bg ctermfg=95 gui=undercurl guibg=bg guifg=fg guisp=#774444
    CSAHi SpellCap term=reverse cterm=undercurl ctermbg=bg ctermfg=95 gui=undercurl guibg=bg guifg=fg guisp=#774444
    CSAHi SpellRare term=reverse cterm=undercurl ctermbg=bg ctermfg=95 gui=undercurl guibg=bg guifg=fg guisp=#774444
elseif has("gui_running") || &t_Co == 88
    CSAHi Normal term=NONE cterm=NONE ctermbg=16 ctermfg=85 gui=NONE guibg=#151618 guifg=#bbbbbb
    CSAHi shTest term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shDblParen term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shDerefEscape term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi bashSpecialVariables term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi bashStatement term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shCase term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi Todo term=NONE cterm=NONE ctermbg=80 ctermfg=37 gui=italic guibg=#303030 guifg=#8888aa
    CSAHi Operator term=NONE cterm=NONE ctermbg=bg ctermfg=85 gui=NONE guibg=bg guifg=#bbbbbb
    CSAHi Identifier term=underline cterm=NONE ctermbg=bg ctermfg=85 gui=NONE guibg=bg guifg=#bbbbbb
    CSAHi Statement term=bold cterm=NONE ctermbg=bg ctermfg=85 gui=NONE guibg=bg guifg=#bbbbbb
    CSAHi Type term=underline cterm=NONE ctermbg=bg ctermfg=42 gui=NONE guibg=bg guifg=#99bbcc
    CSAHi Constant term=underline cterm=NONE ctermbg=bg ctermfg=41 gui=NONE guibg=bg guifg=#88cc99
    CSAHi Conditional term=NONE cterm=NONE ctermbg=bg ctermfg=42 gui=NONE guibg=bg guifg=#99bbcc
    CSAHi Delimiter term=NONE cterm=NONE ctermbg=bg ctermfg=42 gui=NONE guibg=bg guifg=#99bbdd
    CSAHi PreProc term=underline cterm=NONE ctermbg=bg ctermfg=42 gui=NONE guibg=bg guifg=#88ddcc
    CSAHi SpecialKey term=bold cterm=NONE ctermbg=bg ctermfg=31 gui=NONE guibg=bg guifg=Cyan
    CSAHi NonText term=bold cterm=bold ctermbg=16 ctermfg=16 gui=bold guibg=#151618 guifg=#151618
    CSAHi Directory term=bold cterm=NONE ctermbg=bg ctermfg=31 gui=NONE guibg=bg guifg=Cyan
    CSAHi ErrorMsg term=NONE cterm=NONE ctermbg=69 ctermfg=80 gui=NONE guibg=#ff8888 guifg=#222222
    CSAHi IncSearch term=reverse cterm=bold ctermbg=36 ctermfg=77 gui=bold guibg=#666633 guifg=#eeeeaa
    CSAHi Search term=reverse cterm=NONE ctermbg=80 ctermfg=57 gui=NONE guibg=#444433 guifg=#dddd99
    CSAHi MoreMsg term=bold cterm=bold ctermbg=bg ctermfg=21 gui=bold guibg=bg guifg=SeaGreen
    CSAHi ModeMsg term=bold cterm=NONE ctermbg=80 ctermfg=41 gui=NONE guibg=#394439 guifg=#99dd99
    CSAHi LineNr term=underline cterm=NONE ctermbg=16 ctermfg=17 gui=NONE guibg=#151618 guifg=#444455
    CSAHi shCaseEsacSync term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shDoSync term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shForSync term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shIfSync term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shUntilSync term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shWhileSync term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shDerefVarArray term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shDblBrace term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shDerefPPSleft term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi Underlined term=underline cterm=underline ctermbg=bg ctermfg=39 gui=underline guibg=bg guifg=#80a0ff
    CSAHi Ignore term=NONE cterm=NONE ctermbg=bg ctermfg=16 gui=NONE guibg=bg guifg=bg
    CSAHi SpellLocal term=underline cterm=undercurl ctermbg=bg ctermfg=32 gui=undercurl guibg=bg guifg=fg guisp=#774444
    CSAHi Pmenu term=NONE cterm=NONE ctermbg=80 ctermfg=85 gui=NONE guibg=#444444 guifg=#bbbbbb
    CSAHi PmenuSel term=NONE cterm=NONE ctermbg=42 ctermfg=80 gui=NONE guibg=#99bbdd guifg=#222222
    CSAHi PmenuSbar term=NONE cterm=bold ctermbg=81 ctermfg=81 gui=bold guibg=#494949 guifg=#494949
    CSAHi PmenuThumb term=NONE cterm=bold ctermbg=81 ctermfg=81 gui=bold guibg=#666666 guifg=#666666
    CSAHi TabLine term=underline cterm=underline ctermbg=84 ctermfg=fg gui=underline guibg=DarkGrey guifg=fg
    CSAHi TabLineSel term=bold cterm=bold ctermbg=bg ctermfg=fg gui=bold guibg=bg guifg=fg
    CSAHi TabLineFill term=reverse cterm=reverse ctermbg=bg ctermfg=fg gui=reverse guibg=bg guifg=fg
    CSAHi CursorColumn term=reverse cterm=NONE ctermbg=81 ctermfg=fg gui=NONE guibg=Grey40 guifg=fg
    CSAHi CursorLine term=underline cterm=NONE ctermbg=80 ctermfg=fg gui=NONE guibg=#353535 guifg=fg
    CSAHi shCurlyIn term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi bashAdminStatement term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi kshSpecialVariables term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi kshStatement term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shCaseExSingleQuote term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shCaseRange term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shDo term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi helpNormal term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi Special term=bold cterm=bold ctermbg=bg ctermfg=41 gui=bold guibg=bg guifg=#99dd99
    CSAHi Keyword term=NONE cterm=NONE ctermbg=bg ctermfg=85 gui=NONE guibg=bg guifg=#bbbbbb
    CSAHi Question term=NONE cterm=bold ctermbg=bg ctermfg=28 gui=bold guibg=bg guifg=Green
    CSAHi StatusLine term=bold,reverse cterm=NONE ctermbg=80 ctermfg=85 gui=NONE guibg=#353535 guifg=#bbbbbb
    CSAHi StatusLineNC term=reverse cterm=NONE ctermbg=80 ctermfg=82 gui=NONE guibg=#353535 guifg=#777777
    CSAHi VertSplit term=reverse cterm=NONE ctermbg=80 ctermfg=80 gui=NONE guibg=#353535 guifg=#353535
    CSAHi Title term=bold cterm=bold ctermbg=bg ctermfg=79 gui=bold guibg=bg guifg=white
    CSAHi Visual term=reverse cterm=NONE ctermbg=81 ctermfg=fg gui=NONE guibg=#555555 guifg=fg
    CSAHi VisualNOS term=bold,underline cterm=bold,underline ctermbg=bg ctermfg=fg gui=bold,underline guibg=bg guifg=fg
    CSAHi WarningMsg term=NONE cterm=NONE ctermbg=bg ctermfg=64 gui=NONE guibg=bg guifg=Red
    CSAHi WildMenu term=NONE cterm=NONE ctermbg=76 ctermfg=16 gui=NONE guibg=Yellow guifg=Black
    CSAHi Folded term=NONE cterm=NONE ctermbg=80 ctermfg=37 gui=NONE guibg=#242424 guifg=#666677
    CSAHi helpLeadBlank term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shSpecialVar term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shOK term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shCaseEsac term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi ColorColumn term=reverse cterm=NONE ctermbg=80 ctermfg=fg gui=NONE guibg=#252525 guifg=fg
    CSAHi Cursor term=NONE cterm=NONE ctermbg=79 ctermfg=16 gui=NONE guibg=#ffffff guifg=bg
    CSAHi lCursor term=NONE cterm=NONE ctermbg=85 ctermfg=16 gui=NONE guibg=fg guifg=bg
    CSAHi MatchParen term=reverse cterm=NONE ctermbg=20 ctermfg=fg gui=NONE guibg=#364836 guifg=fg
    CSAHi Error term=reverse cterm=NONE ctermbg=80 ctermfg=69 gui=NONE guibg=#333333 guifg=#ffaaaa
    CSAHi Comment term=bold cterm=NONE ctermbg=bg ctermfg=37 gui=NONE guibg=bg guifg=#666677
    CSAHi EasyMotionTargetDefault term=NONE cterm=bold ctermbg=bg ctermfg=64 gui=bold guibg=bg guifg=#ff0000
    CSAHi EasyMotionShadeDefault term=NONE cterm=NONE ctermbg=bg ctermfg=81 gui=NONE guibg=bg guifg=#585858
    CSAHi shSetIdentifier term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shFunctionTwo term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shFunctionStart term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shFunctionOne term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shDerefPattern term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shExpr term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shFor term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shIf term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shSubSh term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shComma term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi shDerefPPSright term=NONE cterm=NONE ctermbg=bg ctermfg=fg gui=NONE guibg=bg guifg=fg
    CSAHi FoldColumn term=NONE cterm=NONE ctermbg=85 ctermfg=31 gui=NONE guibg=Grey guifg=Cyan
    CSAHi DiffAdd term=bold cterm=NONE ctermbg=17 ctermfg=fg gui=NONE guibg=DarkBlue guifg=fg
    CSAHi DiffChange term=bold cterm=NONE ctermbg=33 ctermfg=fg gui=NONE guibg=DarkMagenta guifg=fg
    CSAHi DiffDelete term=bold cterm=bold ctermbg=21 ctermfg=19 gui=bold guibg=DarkCyan guifg=Blue
    CSAHi DiffText term=reverse cterm=bold ctermbg=64 ctermfg=fg gui=bold guibg=Red guifg=fg
    CSAHi SignColumn term=NONE cterm=NONE ctermbg=85 ctermfg=31 gui=NONE guibg=Grey guifg=Cyan
    CSAHi Conceal term=NONE cterm=NONE ctermbg=84 ctermfg=86 gui=NONE guibg=DarkGrey guifg=LightGrey
    CSAHi SpellBad term=reverse cterm=undercurl ctermbg=bg ctermfg=32 gui=undercurl guibg=bg guifg=fg guisp=#774444
    CSAHi SpellCap term=reverse cterm=undercurl ctermbg=bg ctermfg=32 gui=undercurl guibg=bg guifg=fg guisp=#774444
    CSAHi SpellRare term=reverse cterm=undercurl ctermbg=bg ctermfg=32 gui=undercurl guibg=bg guifg=fg guisp=#774444
endif

if 1
    delcommand CSAHi
endif

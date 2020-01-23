command! Dark :call <SID>darktheme()
command! Guitheme :call <SID>darktheme()
command! Light :call <SID>lighttheme()

function! s:darktheme()
  set background=dark
  color peachpuff
  call s:overrides()

  hi! Invis      cterm=none      ctermbg=none ctermfg=232
  hi! NonText    cterm=none      ctermbg=none ctermfg=232
  hi! Visual     cterm=none      ctermbg=238
  hi! Error      ctermbg=52      ctermfg=199
  hi! muted      ctermbg=none    ctermfg=239
  hi! selected   cterm=underline ctermbg=238
  hi! CursorLine ctermbg=237

  " --- a/xyz.txt <--- diffFile
  " +++ b/xyz.txt
  " @@ -12,6 +12,9 @@ function! s:darktheme()
  " ^---------------^ ^---------------------^
  " diffLine          diffSubname

  " Diff in :Gdiff
  hi! DiffAdd     ctermfg=40  ctermbg=22
  hi! DiffChange  ctermfg=104 ctermbg=17
  hi! DiffText    ctermfg=123 ctermbg=19
  hi! DiffDelete  ctermfg=236 ctermbg=234

  " Diff in git commits
  hi! diffRemoved ctermfg=196 ctermbg=52

  hi! Pmenu ctermbg=237 ctermfg=7

  hi! StatusLine   cterm=none ctermbg=234 ctermfg=1
  hi! StatusLineNC cterm=none ctermbg=234 ctermfg=236
endfunction

function! s:lighttheme()
  set background=light
  color peachpuff
  call s:overrides()

  hi! Invis      cterm=none      ctermbg=none ctermfg=254
  hi! NonText    cterm=none      ctermbg=none ctermfg=254
  hi! Visual     cterm=none      ctermbg=253
  hi! Error      ctermbg=213     ctermfg=52
  hi! muted      ctermbg=none    ctermfg=251
  hi! selected   cterm=underline ctermbg=253
  hi! CursorLine ctermbg=253

  hi! DiffAdd     ctermfg=22 ctermbg=40
  hi! DiffChange  ctermfg=17 ctermbg=39
  hi! DiffDelete  ctermfg=52 ctermbg=196

  hi! link StatusLine   Gray
  hi! link StatusLineNC Invis
endfunction

function! s:overrides()
  " Common styles
  hi! Normal       ctermbg=none ctermfg=none
  hi! Underline    ctermbg=none ctermfg=none cterm=underline
  hi! Gray         cterm=none   ctermfg=8
  hi! ItalicGray   cterm=none   ctermfg=8
  hi! CocUnderline cterm=underline

  " Overrides to things I don't like
  hi! CursorLine cterm=none
  hi! Pmenu ctermbg=1

  " Also: Statement Comment(8) Identifier Constant(1) Type PreProc

  " Link to common styles
  hi! link LineNr       Gray
  hi! link VertSplit    Muted
  hi! link SignColumn   Gray
  hi! link FoldColumn   Gray
  hi! link Noise        Gray
  hi! link Folded       Gray
  hi! link Comment      ItalicGray
  hi! link ErrorMsg     Error

  hi! link MatchParen Underline
  hi! link Search     selected
  hi! link IncSearch  selected
  hi! link VisualNC   Visual

  hi! link gitcommitFirstLine     Normal
  hi! link gitcommitSummary       Normal
  hi! link gitcommitBranch        Constant
  hi! link gitcommitHeader        Comment
  hi! link gitcommitSelectedType  Statement
  hi! link gitcommitSelectedFile  Constant
  hi! link gitcommitDiscardedType Statement
  hi! link gitcommitDiscardedFile Comment
  hi! link gitcommitDiff          Comment

  hi! link diffFile Statement

  hi! link NerdTreeOpenable Gray
  hi! link NerdTreeDir      Constant
  hi! link NerdTreeDirSlash Gray
  hi! link NerdTreeCWD      Gray

  hi! link diffLine    Constant
  hi! link diffSubname Gray
  hi! link diffFile    Constant

  hi! link CocHintSign    Statement
  hi! link CocInfoSign    Statement
  hi! link CocWarningSign Type
  hi! link CocErrorSign   Error
  hi! link CocCodeLens    Muted

  hi! link diffAdded   DiffAdd
  hi! link fugitiveHunk   Muted

  hi! link TabLineFill StatusLineNC
  hi! link TabLine     StatusLineNC
  hi! link TabLineSel  StatusLine

  hi! link StartifySlash   Muted
  hi! link StartifyBracket Muted
  hi! link StartifyPath    Comment
  hi! link StartifySpecial Constant
  hi! link StartifyFooter  Muted

  " The '-- INSERT --' mode line
  hi! link ModeMsg Invis
endfunction

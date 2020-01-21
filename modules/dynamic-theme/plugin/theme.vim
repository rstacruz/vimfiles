command! Dark :call <SID>darktheme()
command! Guitheme :call <SID>darktheme()
command! Light :call <SID>lighttheme()

function! s:darktheme()
  set background=dark
  color peachpuff

  hi! Invis    cterm=none      ctermbg=none ctermfg=232
  hi! NonText  cterm=none      ctermbg=none ctermfg=232
  hi! Selected cterm=underline ctermbg=238
  hi! Visual   cterm=none      ctermbg=238
  hi! Error    ctermbg=52      ctermfg=199

  call s:overrides()
endfunction

function! s:lighttheme()
  set background=light
  color peachpuff

  hi! Invis    cterm=none      ctermbg=none ctermfg=254
  hi! NonText  cterm=none      ctermbg=none ctermfg=254
  hi! Selected cterm=underline ctermbg=253
  hi! Visual   cterm=none      ctermbg=253
  hi! Error    ctermbg=213     ctermfg=52

  call s:overrides()
endfunction

function! s:overrides()
  " Common styles
  hi! Normal     ctermbg=none ctermfg=none
  hi! Underline  ctermbg=none ctermfg=none cterm=underline
  hi! Gray       cterm=none   ctermfg=8
  hi! ItalicGray cterm=none   ctermfg=8

  " Overrides to things I don't like
  hi! CursorLine cterm=none

  " Also: Statement Number Comment Identifier Constant Type PreProc

  " Link to common styles
  hi! link LineNr       Gray
  hi! link VertSplit    Gray
  hi! link StatusLine   Gray
  hi! link StatusLineNC Invis
  hi! link SignColumn   Gray
  hi! link FoldColumn   Gray
  hi! link Noise        Gray
  hi! link Folded       Gray
  hi! link Comment      ItalicGray

  hi! link MatchParen Underline
  hi! link Search     Selected
  hi! link IncSearch  Selected
  hi! link VisualNC   Visual
  hi! link Pmenu      Visual

  hi! link gitcommitFirstLine     Normal
  hi! link gitcommitSummary       Normal
  hi! link gitcommitBranch        Number
  hi! link gitcommitHeader        Comment
  hi! link gitcommitSelectedType  Statement
  hi! link gitcommitSelectedFile  Number
  hi! link gitcommitDiscardedType Statement
  hi! link gitcommitDiscardedFile Comment
  hi! link gitcommitDiff          Comment

  hi! link diffFile Statement

  hi! link NerdTreeOpenable Gray
  hi! link NerdTreeDir      Number
  hi! link NerdTreeDirSlash Gray
  hi! link NerdTreeCWD      Gray

endfunction

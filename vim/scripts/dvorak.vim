" This file:  "qwerty2dvorak":
" Last update: Thu Dec 04 18:00:00 CET 1997
"
" Purpose:
" Map keys for a qwerty keyboard to the dvorak keyboard layout.
" Note:  This change has only been done for insert and ex mode!
"
" Installation:
"	Save this file to some "filename".
" Usage from within Vim:
" 	:source filename
"
" For more info see this page:
" 	http://www.vim.org/dvor.html
" This file is available as:
" 	http://www.vim.org/src/keyboard.qwerty2dvorak
" The other file is available as:
" 	http://www.vim.org/src/keyboard.dvorak2qwerty

" SUN keyboard
" qwerty - unshifted
" 1  2  3  4  5  6  7  8  9  0  -  =  \  `
"  q  w  e  r  t  y  u  i  o  p  [  ]
"   a  s  d  f  g  h  j  k  l  ;  '
"    z  x  c  v  b  n  m  ,  .  /

" dvorak - unshifted
" 1  2  3  4  5  6  7  8  9  0  -  =  \  `
"  '  ,  .  p  y  f  g  c  r  l  /  =
"   a  o  e  u  i  d  h  t  n  s  -
"    ;  q  j  k  x  b  m  w  v  z

" qwerty -   shifted
" !  @  #  $  %  ^  &  *  (  )  _  +  |  ~
"  Q  W  E  R  T  Y U   I  O  P  {  }
"   A  S  D  F  G  H  J  K  L  :  "
"    Z  X  C  V  B  N  M  <  >  ?

" dvorak -   shifted
" 1  2  3  4  5  6  7  8  9  0  -  =  \  `
"  "  <  >  P  Y  F  G  C  R  L  {  }
"   A  O  E  U  I  D  H  T  N  S  _
"    :  Q  J  K  X  B  M  W  V  ?

inoremap a a
inoremap b x
inoremap c j
inoremap d e
inoremap e .
inoremap f u
inoremap g i
inoremap h d
inoremap i c
inoremap j h
inoremap k t
inoremap l n
inoremap m m
inoremap n b
inoremap o r
inoremap p l
inoremap q '
inoremap r p
inoremap s o
inoremap t y
inoremap u g
inoremap v k
inoremap w ,
inoremap x q
inoremap y f
inoremap z ;
inoremap ; s
inoremap ' -
inoremap " _
inoremap , w
inoremap . v
inoremap / z
inoremap A A
inoremap B X
inoremap C J
inoremap D E
inoremap E >
inoremap F U
inoremap G I
inoremap H D
inoremap I C
inoremap J H
inoremap K T
inoremap L N
inoremap M M
inoremap N B
inoremap O R
inoremap P L
inoremap Q "
inoremap R P
inoremap S O
inoremap T Y
inoremap U G
inoremap V K
inoremap W <
inoremap X Q
inoremap Y F
inoremap Z :
inoremap < W
inoremap > V
inoremap ? Z
inoremap : S
inoremap [ /
inoremap ] =
inoremap { ?
inoremap } +
inoremap - [
inoremap _ {
inoremap = ]
inoremap + }
" END


"=============================================================================
"    Copyright: Copyright (C) 2009 Jeff Buttars 
"               Permission is hereby granted to use and distribute this code,
"               with or without modifications, provided that this copyright
"               notice is copied with it. Like anything else that's free,
"               doubleTap.vim is provided *as is* and comes with no
"               warranty of any kind, either expressed or implied. In no
"               event will the copyright holder be liable for any damages
"               resulting from the use of this software.
" Name Of File: doubleTap.vim
"  Description: DoubleTap Vim Plugin
"               This plugin provides a more manual, but easy, way to insert
"               matching pair characters, ie: [],(),'', and not so matchy
"               characters like + and . , common concatenation characters.
"               Also provides a quick and easy way to terminate a line no
"               matter where on the line the cursor is.
"               For instance a double semicolon, ;;, will trim all of the
"               space at the end of the line and insert a semicolon at the end
"               of the current line. DoubleTap provides some simple abstraction
"               functions to the do the more intricate work and then provides default 
"               mappings to wire those functions to characters,pairs and
"               events. You can easily use the core functions provided by doubleTap to 
"               create your own mappings and behaviours.
"
"                   Another great plugin that provides a more automatic 'as you
"               type' matching pair insertion/completion is 
"               DelimitMate,http://www.vim.org/scripts/script.php?script_id=2754
"               Check it out if haven't already. It provided inspiration for
"               me to finally write this plugin.
"
"     Examples: 
"
"     			For true matching pairs like {}:
"     			typing a double left curly brace, {{, will insert a matching
"     			pair of curly braces, {}, with the cursor in the middle.
"     			typing a double right curly brace, }}, will place the cursor
"     			after the next instance of a right curly brace in the buffer.
"     			This behavior is used with {},[],() pairs by default.
"     				For string containers, quote marks, the behavior is similar
"     			to matching pairs. When a single quote is typed in twice 
"     			quickly, '', if the cursor is inside a string, as determined by 
"     			the syntax highlighting, then the curso will be set to the
"     			right of the next occurrence of '. Otherwise two quotes are
"     			inserted into the buffer with the cursor between them. This
"     			is the behavior of ' and " by default
"     				There is also a pseudo matching pair functionality used
"     			for characters that aren't paired or used as a container. This
"     			is used for concatenation characters at the time of this
"     			release.It's used for the . and + characters. It is very
"     			simple. If .. is typed and there is a. to the right of the
"     			cursor the cursor position is set to the right of the next . on the
"     			current line. Otherwise two periods are inserted with the cursor 
"     			in between them. By default this is the behaviour of the . and
"     			+ characters, depending on filetype.
"     				The second part of this plugin is finish line. By double
"     			tapping a character the current line is 'finished' for
"     			you. The basic behaviour is to trim all white space from the
"     			end of the current line and insert a character, like a ;, at
"     			the end of the clean line. Some additional functionality, like
"     			saving the file, can be easily added in the mapping.
 "
"   Maintainer: Jeff Buttars (jeffbuttars at gmail dot com)
" Last Changed: Thursday, 9 Dec 2009
"      Version: See g:double_tap_version for version number.
"        Usage: This file should reside in the plugin directory and be
"               automatically sourced.
"     			    All functionality of this plugin is triggered by a key mapping.
"     			Double Tap comes with it's own set of default mappings
"     			enabled. You can easily disable any of the default mappings
"     			from you .vimrc by setting the appropriate setting variable to
"     			0. For example to disable left bracket insertion put the
"     			following in you .vimrc:
"                   let b:DoubleTap_map_left_bracket = 0
"               Look in the 'Default settings' section bellow to see all of the
"               settings variables. Look at the 'Set up key mappings' section
"               to see how the mappings are set.
"
"=============================================================================

" Allow doubleTap to 
" Exit quickly if already running or when 'compatible' is set. 
" {{{1
if exists("g:loaded_doubleTap") || &cp
  finish
endif
"1}}}

" Version number
" {{{1
let g:loaded_doubleTap = '1.0'
"1}}}

" Check for Vim version 700 or greater 
" {{{1
if v:version < 700
  echo "Sorry, doubleTap ".g:double_tap_version."\nONLY runs with Vim 7.0 and greater."
  finish
endif
"1}}}

" Default settings 
" {{{1
"[[
" Enable default left bracket mapping
if !exists( "b:DoubleTap_map_left_bracket" )
  let b:DoubleTap_map_left_bracket = 0
endif
" Enable default right bracket mapping
"]]
if !exists( "b:DoubleTap_map_right_bracket" )
  let b:DoubleTap_map_right_bracket = 0
endif

" Enable default left curly brace mapping
" {{
if !exists( "b:DoubleTap_map_left_brace" )
  let b:DoubleTap_map_left_brace = 0
endif
" Enable default rightt curly brace mapping
" }}
if !exists( "b:DoubleTap_map_right_brace" )
  let b:DoubleTap_map_right_brace = 0
endif

" Enable default left paren mapping
" ((
if !exists( "b:DoubleTap_map_left_paren" )
  let b:DoubleTap_map_left_paren = 0
endif
" Enable default right paren mapping
" ))
if !exists( "b:DoubleTap_map_right_paren" )
  let b:DoubleTap_map_right_paren = 0
endif

" Enable default left angle mapping
" << 
if !exists( "b:DoubleTap_map_left_angle" )
	let b:DoubleTap_map_left_angle = 0
endif
" Enable default right angle mapping
" >> 
if !exists( "b:DoubleTap_map_right_angle" )
	let b:DoubleTap_map_right_angle = 0
endif

" Enable default single quote insert/jump mapping
" ''
if !exists( "b:DoubleTap_map_single_quote_insert_jump" )
  let b:DoubleTap_map_single_quote_insert_jump = 0
endif

" Enable default double quote insert/jump mapping
if !exists( "b:DoubleTap_map_double_quote_insert_jump" )
  let b:DoubleTap_map_double_quote_insert_jump = 0
endif

" Enable default double plus insert/jump mapping
" ++
if !exists( "b:DoubleTap_map_plus_insert_jump" )
  let b:DoubleTap_map_plus_insert_jump = 0
endif

" Enable default double period insert/jump mapping
" ..
if !exists( "b:DoubleTap_map_period_insert_jump" )
  let b:DoubleTap_map_period_insert_jump = 0
endif

" Enable default double semicolon finish line mapping 
" ;;
if !exists( "b:DoubleTap_map_semicolon_finish_line" )
  let b:DoubleTap_map_semicolon_finish_line = 0
endif

" Enable default double colon finish line mapping 
" ::
if !exists( "b:DoubleTap_map_colon_finish_line" )
  let b:DoubleTap_map_colon_finish_line = 0
endif

" Enable default double comma finish line mapping 
" ,,
if !exists( "b:DoubleTap_map_comma_finish_line" )
  let b:DoubleTap_map_comma_finish_line = 0
endif
"
"
function! s:enableAllDefaults()
	let b:DoubleTap_map_left_bracket = 1
	let b:DoubleTap_map_right_bracket = 1
	let b:DoubleTap_map_left_brace = 1
	let b:DoubleTap_map_right_brace = 1
	let b:DoubleTap_map_left_paren = 1
	let b:DoubleTap_map_right_paren = 1
	let b:DoubleTap_map_left_angle = 1
	let b:DoubleTap_map_right_angle = 1
	let b:DoubleTap_map_single_quote_insert_jump = 1
	let b:DoubleTap_map_double_quote_insert_jump = 1
	let b:DoubleTap_map_plus_insert_jump = 1
	let b:DoubleTap_map_period_insert_jump = 1
	let b:DoubleTap_map_semicolon_finish_line = 1
	let b:DoubleTap_map_colon_finish_line = 1
	let b:DoubleTap_map_comma_finish_line = 1
endfunction


"" We can enable/disable all doubleTap defaults
" with one var.
" By default, all defaults are enabled, of course.
if !exists( "b:DoubleTap_enable_defaults" )
	let b:DoubleTap_enable_defaults = 1
endif

if 1 == b:DoubleTap_enable_defaults 
	call s:enableAllDefaults()
endif
"1}}}


" Private Helper:
" getSynName:
" get the syntax type under the cursor
"{{{1
function! s:getSynName()
	return synIDattr(synID(line("."), col("."), 0), "name" )
endfunction	
"1}}}

" Private Helper:
" getSynStack:
" get the syntax stack under the cursor
"{{{1
function! s:getSynStack()
	return synstack( line("."), col(".") )
endfunction	
"1}}}

" Private Helper:
" inString
" Param: thechar the quote character that's been double tapped.
" See if the cursor is inside a string according the current syntax definition
"{{{1
function! s:inString( thechar )

	" This will often contain whether we are in a single or double quote
	" string. How that is represented seems syntax specific, not standard.
	" We still leverage that knowledge if we can.
	let l:synstr = s:getSynName()

	if l:synstr  !~? 'String'
	  " If we're not 'in' the string, we may be sitting
	  " on the quote, if so return true/1
	  
	  if strpart( getline("."), col('.')-1, 1) == a:thechar
		echo "We're in"
		return 1
	  endif

	  return 0
	endif

	let l:inSingle = 0
	let l:theSingle = 0

	"" See if the string we're in is the same kind we're tapping.
	" So, if we're in a '      ' but double tap a ", we should end up
	" with '    ""   ' and not jump to the next ".
	"
	" Is there more at the end of the string? a 'S' or 'Single'?
	" If so, see if we can detect the quote type and then match it
	" to the chare being tapped.
	if l:synstr  !~? 'String$'
	  if l:synstr  =~? 'StringS'
		let l:inSingle = 1
	  endif

	  if a:thechar == "'"
		let l:theSingle = 1
	  endif
	endif

	return l:inSingle == l:theSingle
endfunction
"1}}}

" Public Interface:
" DoubleTapFinishLine: Remove trailing whitespace, put the given character at the end of the line  
" Param: thechar the character to place at the end of the cleaned line.
" {{{1
function! DoubleTapFinishLine( thechar )

	if &paste
	  return a:thechar.a:thechar
	endif

	" If thechar already exists already, don't do anything.
	let l:regex = a:thechar . '$'
	if getline(".") =~ l:regex 
		return
	endif

	let l:cline = substitute( getline("."), '\s*$', '', 'g' )
	echo l:cline . a:thechar 
	call setline( ".", l:cline . a:thechar )
endfunction
"1}}}

" Public Interface:
" DoubleTapJumpOut: Find the next instance of thechar in the current
" buffer and jump to it.
" Param: thechar the character to jump too.
" {{{1
function! DoubleTapJumpOut( thechar )

	if &paste
	  return a:thechar.a:thechar
	endif

	" First see if it's on the cursor. 
	" If it is go right one and return.
	" Otherwise find the next instance in the buffer and 
	" go there.

	let l:cline = getline(".")
	let l:cpos = getpos(".")

	"if the cursor is to left of thechar, jump out.
	let l:rchar = strpart( l:cline, col('.')-1, 1)

	if l:rchar == a:thechar 
		let l:cpos[2] = l:cpos[2]+2
		call setpos( '.', l:cpos )
		return ""
	endif

	"find next position of this character in the buffer.
	let l:npos = searchpos( a:thechar, 'nW' )
	if l:npos[0] > 0 && l:npos[1] > 0 && l:npos[0] >= l:cpos[1]

	  let l:cpos[1] = l:npos[0]
	  let l:cpos[2] = l:npos[1]+1
	  call setpos( '.', l:cpos )

	  return ""
	endif

	return a:thechar.a:thechar
endfunction
"1}}}

" Public Interface:
" DoubleTapInsertJumpString: This is a lot like DoubleTapJumpOut() but is explicity
" for the string enclosing ''' and '"'
" Param: thechar the quote character used to define the new string or jukmp
" too.
"{{{1
function! DoubleTapInsertJumpString( thechar )

	if &paste
		return a:thechar.a:thechar
	endif

	" If we're in a string, jump out
	" Otherwise, lay down a pair
	if s:inString( a:thechar )
		" jump out

		let l:cpos = getpos(".")
		" Make sure we're not sitting on the quote. 
		" If we are, move the cursor to the left by one.
		if strpart( getline("."), col('.')-1, 1) == a:thechar
			let l:cpos[2] = l:cpos[2] - 1 
			call setpos( '.', l:cpos )
		endif

		let l:npos = searchpos( a:thechar, 'nW' )
 		if l:npos[0] >= l:cpos[1]
			let l:cpos[1] = l:npos[0]
			let l:cpos[2] = l:npos[1]+1
			call setpos( '.', l:cpos )
			return ""
		endif
	endif

	return a:thechar.a:thechar."\<left>"
endfunction
"1}}}

" Public Interface:
" DoubleTapInsertJumpSimple: This is a lot like DoubleTapJumpOut() but it is used
" for characters that aren't usually considered a matching
" pair. This can be a convenience for concatenation operators
" like . and +
" If the char is present to the right of the cursor
" jump to it. Otherwise insert a pair and put the cursor
" in the middle of them.
" For now only works with single line matches 
" Param: thechar the character to insert or jump too.
"{{{1
function! DoubleTapInsertJumpSimple( thechar )

	if &paste
	  return a:thechar.a:thechar
	endif

	" See if it's there.
	let l:cline = getline(".")
	let l:cpos = getpos(".")
	let l:ccol = l:cpos[2]-1

	let l:nchar = stridx( l:cline, a:thechar, l:ccol )
	if l:nchar < l:ccol
		  "if the cursor is on or to left of thechar, jump out.
		  let l:tchar = strpart( getline('.'), col('.')-2, 1)
		  let l:rchar = strpart( getline('.'), col('.')-1, 1)
		  if l:tchar == a:thechar || l:rchar == a:thechar
			  let l:cpos[2] = l:nchar+2
			  call setpos( '.', l:cpos )
			  return ""
		  else
			  return a:thechar.a:thechar."\<left>"
		  endif

		return a:thechar.a:thechar
	endif

	let l:cpos[2] = l:nchar+2
	call setpos( '.', l:cpos )

	return ""
endfunction
"1}}}
 
"Set up key mappings 
"{{{1
" Enable default left bracket mapping
if 1 == b:DoubleTap_map_left_bracket
  imap [[ []<Left>
endif
" Enable default right bracket mapping
if 1 == b:DoubleTap_map_right_bracket
  imap ]] <C-R>=DoubleTapJumpOut("]")<CR>
endif

" Enable default left curly brace mapping
if 1 == b:DoubleTap_map_left_brace
  imap {{ {}<Left>
endif
" Enable default right curly brace mapping
if 1 == b:DoubleTap_map_right_brace
  imap }} <C-R>=DoubleTapJumpOut("}")<CR>
endif

" Enable default left paren mapping
if 1 == b:DoubleTap_map_left_paren
  imap (( ()<Left>
endif
" Enable default right paren mapping
if 1 == b:DoubleTap_map_right_paren
  imap )) <C-R>=DoubleTapJumpOut(")")<CR>
endif

" Enable default left angle mapping
if 1 == b:DoubleTap_map_left_angle
	au Filetype html,xml,xhtml,htmlcheetah,javascript,php imap << <><Left>
endif
" Enable default right angle mapping
if 1 == b:DoubleTap_map_right_angle
	au FileType html,xml,xhtml,htmlcheetah,javascript,php imap >> <C-R>=DoubleTapJumpOut(">")<CR>
endif

" Enable default single quote insert mapping
if 1 == b:DoubleTap_map_single_quote_insert_jump
  imap '' <C-R>=DoubleTapInsertJumpString("'")<CR>
endif

" Enable default double quote insert mapping
if 1 == b:DoubleTap_map_double_quote_insert_jump
  imap "" <C-R>=DoubleTapInsertJumpString('"')<CR>
endif

" Enable default double plus insert mapping
if 1 == b:DoubleTap_map_plus_insert_jump
  au FileType javascript,python imap ++ <C-R>=DoubleTapInsertJumpSimple('+')<CR>
endif

" Enable default double period insert mapping
if 1 == b:DoubleTap_map_period_insert_jump
  au FileType php,perl,vim imap .. <C-R>=DoubleTapInsertJumpSimple('.')<CR>
endif

" Enable default double tap semicolon finish line
if 1 == b:DoubleTap_map_semicolon_finish_line
  " we use a different mapping in Python.
  if &ft == 'python'
	" NOTICE: This will insert a ':', not a semicolon.
	imap ;; <ESC>:call DoubleTapFinishLine(':')<CR>:w<CR>o<ESC>
	nmap ;; <ESC>:call DoubleTapFinishLine(':')<CR>:w<CR>o<ESC>
  else
	imap ;; <ESC>:call DoubleTapFinishLine(';')<CR>:w<CR><ESC>
	nmap ;; <ESC>:call DoubleTapFinishLine(';')<CR>:w<CR><ESC>
  endif

endif

" Enable default double tap colon finish line
" Only for Python by default
if 1 == b:DoubleTap_map_colon_finish_line
  au FileType python nmap :: <ESC>:call DoubleTapFinishLine(':')<CR>:w<CR>o<ESC>
  au FileType python imap :: <ESC>:call DoubleTapFinishLine(':')<CR>:w<CR>o<ESC>
endif

" Enable default double tap comma finish line
" Only for javascript and php by default
if 1 == b:DoubleTap_map_comma_finish_line
  au FileType php,javascript nmap ,, <ESC>:call DoubleTapFinishLine(',')<CR>:w<CR>
  au FileType php,javascript imap ,, <ESC>:call DoubleTapFinishLine(',')<CR>:w<CR>
endif

"1}}}

" vim:ft=vim foldmethod=marker sw=4

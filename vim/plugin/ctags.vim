" ctags.vim: Display function name in the title bar and/or status line.
" Author:	Alexey Marinichev <lyosha-vim@lyosha.no-ip.org>
" Maintainer:	Gary Johnson <garyjohn@spk.agilent.com>
" Contributor:	Keith Reynolds
" Last Change:	2003-11-26 00:23:22
" Version:	2.1
" URL(1.0):    	http://vim.sourceforge.net/scripts/script.php?script_id=12
" URL(>=2.0):	http://vim.sourceforge.net/scripts/script.php?script_id=610

" DETAILED DESCRIPTION:
" This script uses exuberant ctags to build the list of tags for the current
" file.  CursorHold event is then used to update titlestring and/or statusline.
" 
" Upon sourcing an autocommand is created with event type CursorHold.  It
" updates the title string or a buffer-local variable using the function
" GetTagName.  Another autocommand of type BufEnter is created to generate
" tags for *.c, *.cpp, *.h, *.py and *.vim files.
" 
" Function GenerateTags builds an array of tag names.
" 
" Function GetTagName takes line number argument and returns the tag name.
"
" Function SetTagDisplay sets the values of 'statusline' and
" 'titlestring'.
"
" Function TagName returns the cached tag name.
"
" INSTALL DETAILS:
" This script requires exuberant ctags to be installed on your system.  If
" it is not already installed, you can obtain the source from
" http://ctags.sourceforge.net/.
"
" Before sourcing the script do:
"    let g:ctags_path='/path/to/ctags'
"    let g:ctags_args='-I __declspec+'
"        (or whatever other additional arguments you want to pass to ctags)
"    let g:ctags_title=1	" To show tag name in title bar.
"    let g:ctags_statusline=1	" To show tag name in status line.
"    let generate_tags=1	" To start automatically when a supported
"				" file is opened.
"
" The configuration variables (g:ctags_*) may also be changed after the
" plugin is loaded.  Setting g:ctags_title or g:ctags_statusline to 0
" after the plugin is loaded will stop the updating of 'titlestring' or
" 'statusline' but will not clear those options as doing so could
" interfere with a user's setting of those options, for example in a
" filetype plugin.  To restore the default appearance of either of those
" options, simply execute ":set titlestring=" or ":set statusline=" as
" desired.
" 
" :CTAGS command starts the script.

" Exit quickly when already loaded.
"
if exists("loaded_ctags")
    finish
endif
let loaded_ctags = 1

" Allow the use of line-continuation, even if user has 'compatible' set.
"
let s:save_cpo = &cpo
set cpo&vim

" s:ruler contains a copy of the 'ruler' setting so that 'statusline' can
" be updated when the user changes 'ruler'.  It is set to an invalid value
" initially so that 'statusline' will be set the first time 'ruler' is
" checked.
"
let s:ruler = ''

" The last tag name displayed in the 'titlestring'.
"
let s:title_tag_name = ''

" Set default values for all configuration variables not already
" specified by the user.

if !exists("ctags_path")
    " Version 1.0 and 2.0 default:
    "let g:ctags_path=$VIM.'/ctags/ctags'

    " Version 2.1 default:
    let g:ctags_path='ctags'		" Use first 'ctags' in PATH.
endif

if !exists("ctags_args")
    " Version 1.0 and 2.0 default:
    "let g:ctags_args='-I __declspec+'

    " Version 2.1 default:
    let g:ctags_args='--c-types=cfgsu --vim-types=f --if0=yes'
endif

if !exists("generate_tags")
    let generate_tags = 0
endif

" By default, the ctags list is regenerated whenever the buffer is
" written.  Allow the user to disable this behavior by setting
" g:ctags_regenerate = 0 if, for example, this becomes a performance
" problem.
"
if !exists("g:ctags_regenerate")
    let g:ctags_regenerate = 1
endif

" If the user doesn't specify either g:ctags_title or g:ctags_statusline,
" revert to the original behavior, which was equivalent to g:ctags_title =
" 1, g:ctags_statusline = 0.
"
if !exists("g:ctags_title") && !exists("g:ctags_statusline")
    let g:ctags_title = 1
    let g:ctags_statusline = 0
endif

if !exists("g:ctags_title")
    let g:ctags_title = 0
endif

if !exists("g:ctags_statusline")
    let g:ctags_statusline = 0
endif

command! CTAGS let generate_tags=1|call GenerateTags()

autocmd BufEnter *.c,*.cpp,*.h,*.py,*.vim
\   if g:ctags_statusline != 0
\ |     let s:save_laststatus = &laststatus
\ |     set laststatus=2
\ | endif
\ | if generate_tags != 0
\      && !exists('b:lines')
\      && filereadable(expand("<afile>"))
\ | call GenerateTags()
\ | endif

autocmd BufLeave *.c,*.cpp,*.h,*.py,*.vim
\   if exists("s:save_laststatus")
\ |     let &laststatus = s:save_laststatus
\ |     unlet s:save_laststatus
\ | endif

" Update the tags list whenever the buffer is written.
"
autocmd BufWritePost *.c,*.cpp,*.h,*.py,*.vim
\   if (generate_tags != 0) && (g:ctags_regenerate != 0)
\ |     call GenerateTags()
\ | endif

set updatetime=500

autocmd CursorHold *
\   if generate_tags != 0
\ |     call s:SetTagDisplay()
\ | endif

"set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)%=%(tag:\ %-{GetTagName(line("."))}%)



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" No changes should be required below (unless there are bugs).
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if version < 600
    function! Stridx(haysack, needle)
	return match(a:haysack, a:needle)
    endfunction
else
    function! Stridx(haysack, needle)
	return stridx(a:haysack, a:needle)
    endfunction
endif

let g:ctags_obligatory_args = '-n --sort=no -o -'
let g:ctags_pattern="^\\(.\\{-}\\)\t.\\{-}\t\\(\\d*\\).*"

" This function builds an array of tag indices.  b:tags contains all
" the tag names in the file, separated by newlines.  b:lines contains
" the source file line numbers of lines that contain a tag, followed
" by the index into b:tags of the name of the tag.  The b:lines array
" is sorted, so a binary search can be used to find the appropriate
" tagged line for a given source file line number.  b:length contains
" the length of a number (line number or index) in b:lines.
"
" There are two versions of this function: if vim has been compiled
" with perl support, a fast perl version is used; otherwise a native
" version that is somewhat slower is used.
"
if has('perl')
    function! GenerateTags()
	perl << PERL_EOF
	$max_num = "9999999";
	$length = length($max_num);
	$lines = "";
	$tags = "";
	$index = 0;

	$command = VIM::Eval("g:ctags_path");
	$command .= " " . VIM::Eval("g:ctags_args");
	$command .= " " . VIM::Eval("g:ctags_obligatory_args");
	$command .= " " . VIM::Eval("expand('%')");

	open (CTAGS, $command . "|") or die $!;

	while (<CTAGS>)
	{
	    s/^(.+?)\t.*?\t(\d*);.*$/\1\t\2/;
	    my ($tag_name, $tag_line_num) = split /\t/;
	    $tags .= $tag_name . "\n";
	    $lines .= sprintf("%-*d", $length, $tag_line_num);
	    $lines .= sprintf("%-*d", $length, $index);
	    $index += length($tag_name) + 1;
	}

	close (CTAGS);

	$lines .= $max_num;
	$lines .= $max_num;

	VIM::DoCommand("let b:tags = '$tags'");
	VIM::DoCommand("let b:length = $length");
	VIM::DoCommand("let b:lines = '$lines'");
PERL_EOF
    endfunction
else
    function! GenerateTags()
	let ctags = system(g:ctags_path.' '.g:ctags_args.' '.g:ctags_obligatory_args.' "'.expand('%').'"')

	let max_num = "9999999"
	let b:length = strlen(max_num)
	let b:lines = ''
	let b:tags = ''

	" strlen(spaces) must be at least b:length.
	let spaces = '               '
	let len = strlen(ctags)
	let index = 0
	let offset = 0

	while offset < len
	    let one_tag = matchstr(ctags, "[^\n]*", offset)
	    let tag_name = substitute(one_tag, g:ctags_pattern, '\1', '')
	    let tag_line_num = substitute(one_tag, g:ctags_pattern, '\2', '')
	    let b:lines = b:lines . strpart(tag_line_num.spaces, 0, b:length)
	    let b:lines = b:lines . strpart(index.spaces, 0, b:length)
	    let b:tags = b:tags . tag_name . "\n"
	    let index = index + strlen(tag_name) + 1
	    let offset = offset + strlen(one_tag) + 1
	endwhile

	let b:lines = b:lines . max_num
	let b:lines = b:lines . max_num
    endfunction
endif

" This function returns the tag name for given index.
function! GetLine(i)
    return strpart(b:lines, a:i*b:length*2, b:length)+0
endfunction

function! GetIndex(i)
    return strpart(b:lines, a:i*(b:length*2)+b:length, b:length)+0
endfunction

" This function does binary search in the array of tag names and returns
" corresponding tag.
function! GetTagName(curline)
    if !exists("b:lines")
	return ""
    endif

    let left = 0
    let right = strlen(b:lines)/(b:length*2)

    if a:curline < GetLine(left)
	return ""
    endif

    while left<right
	let middle = (right+left+1)/2
	let middleline = GetLine(middle)

	if middleline == a:curline
	    let left = middle
	    break
	endif

	if middleline > a:curline
	    let right = middle-1
	else
	    let left = middle
	endif
    endwhile

    let index = GetIndex(left)

    if index < strlen(b:tags)
	let ret = matchstr(b:tags, "[^\n]*", index)
    endif

    return ret
endfunction

" This function sets the values of 'statusline' and 'titlestring'.
"
" Avoid setting 'statusline' (or any other option) unless the tag name has
" changed since doing so will force a screen redraw and will cause the
" desired cursor column to be reset.  Losing the desired cursor column is
" really annoying when editing a file type for which ctags aren't even
" supported.  (This may be done differently when we make the autocommands
" smarter about the current file type.)
"
function! s:SetTagDisplay()
    let l:tag_name = GetTagName(line("."))
    if !exists('w:tag_name')
	let w:tag_name = ''
    endif
    if (g:ctags_statusline != 0) && ((l:tag_name != w:tag_name) || (&ruler != s:ruler))
	let w:tag_name = l:tag_name
	let s:ruler = &ruler
	if &ruler
	    let &statusline='%<%f %(%h%m%r %)%=%{TagName()} %-15.15(%l,%c%V%)%P'
					" Equivalent to default status
					" line with 'ruler' set:
					"
					" '%<%f %h%m%r%=%-15.15(%l,%c%V%)%P'
	else
	    let &statusline='%<%f %(%h%m%r %)%=%{TagName()}'
	endif
					" The %(%) pair around the "%h%m%r "
					" is there to suppress the extra
					" space between the file name and
					" the function name when those
					" elements are null.
    endif
    if (g:ctags_title != 0) && (l:tag_name != s:title_tag_name)
	let s:title_tag_name = l:tag_name
	let &titlestring='%t%( %M%)%( (%{expand("%:~:.:h")})%)%( %a%)%='.s:title_tag_name
    endif
endfunction

" This function returns the value of w:tag_name if it exists, otherwise
" ''.
function! TagName()
    if exists('w:tag_name')
	return w:tag_name
    else
	return ''
    endif
endfunction

" Restore cpo.
let &cpo= s:save_cpo
unlet s:save_cpo

" vim:set ts=8 sts=4 sw=4:

" GrepHere.vim: List occurrences in the current buffer in the quickfix window.
"
" DEPENDENCIES:
"   - GrepCommands.vim autoload script
"   - ingo/msg.vim autoload script
"   - ingo/regexp.vim autoload script
"   - ingo/window/quickfix.vim autoload script
"   - ingo/window/switches.vim autoload script
"
" Copyright: (C) 2003-2014 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.

" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"   1.11.007	01-Feb-2014	ENH: Allow [range] for :GrepHere.
"   1.11.006	14-Jun-2013	Use ingo/msg.vim.
"   1.11.005	24-May-2013	Move ingosearch.vim to ingo-library.
"   1.11.004	08-Apr-2013	Move ingowindow.vim functions into ingo-library.
"   1.10.003	24-Aug-2012	Make default flags for an empty :GrepHere
"				command configurable via
"				g:GrepHere_EmptyCommandGrepFlags.
"				Factor out s:GrepHere().
"   1.00.002	24-Aug-2012	Add mappings for the [whole] <cword> via
"				GrepHere#SetCword(), analog to the
"				SearchPosition plugin's implementation.
"				Factor out the mapping logic to GrepHere#List().
"				Extract g:GrepHere_MappingGrepFlags.
"	001	21-Mar-2012	file creation from plugin script

function! s:GrepHere( count, grepCommand, pattern, patternFlags, patternPrefix )
    let l:currentFile = expand('%')

    if empty(l:currentFile) && ingo#window#quickfix#IsQuickfixList()
	" Use the file from the current line in the quickfix window.
	let l:currentFile = ingo#window#quickfix#ParseFileFromQuickfixList()
	if empty(l:currentFile) && ingo#window#switches#GotoPreviousWindow()
	    " If the cursor is on no file name line in the quickfix window, use
	    " the previous window instead.
	    let l:currentFile = expand('%:p')
	    noautocmd wincmd p
	endif
    endif

    if empty(l:currentFile)
	call ingo#msg#ErrorMsg('E32: No file name')
	return 0
    endif

    return GrepCommands#Grep(a:count, a:grepCommand, [l:currentFile], a:pattern, a:patternFlags, a:patternPrefix)
endfunction

function! GrepHere#Grep( startLnum, endLnum, count, grepCommand, pattern )
    let l:patternPrefix = ''
    if a:startLnum > 1
	let l:patternPrefix .= '\%>' . (a:startLnum - 1) . 'l'
    endif
    if a:endLnum < line('$')
	let l:patternPrefix .= '\%<' . (a:endLnum + 1) . 'l'
    endif

    return s:GrepHere(a:count, a:grepCommand, a:pattern, (empty(a:pattern) ? g:GrepHere_EmptyCommandGrepFlags : ''), l:patternPrefix)
endfunction

let s:pattern = ''
function! GrepHere#SetCword( isWholeWord )
    let l:cword = expand('<cword>')
    if ! empty(l:cword)
	let s:pattern = ingo#regexp#FromLiteralText(l:cword, a:isWholeWord, '')
    endif
    return s:pattern
endfunction

function! GrepHere#List( pattern )
    if s:GrepHere(0, 'vimgrep', a:pattern, g:GrepHere_MappingGrepFlags, '')
	copen
	call ingo#window#switches#GotoPreviousWindow()
    endif
endfunction

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :

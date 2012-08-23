" GrepHere.vim: List occurrences in the current buffer in the quickfix window.
"
" DEPENDENCIES:
"   - GrepCommands.vim autoload script
"   - ingowindow.vim autoload script
"
" Copyright: (C) 2003-2012 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.

" Maintainer:	Ingo Karkat <ingo@karkat.de>
" REVISION	DATE		REMARKS
"	001	21-Mar-2012	file creation from plugin script

function! GrepHere#Grep( count, grepCommand, pattern, ... )
    let l:currentFile = expand('%')

    if empty(l:currentFile) && ingowindow#IsQuickfixList()
	" Use the file from the current line in the quickfix window.
	let l:currentFile = ingowindow#ParseFileFromQuickfixList()
	if empty(l:currentFile) && ingowindow#GotoPreviousWindow()
	    " If the cursor is on no file name line in the quickfix window, use
	    " the previous window instead.
	    let l:currentFile = expand('%:p')
	    noautocmd wincmd p
	endif
    endif

    if empty(l:currentFile)
	echohl ErrorMsg
	echomsg 'E32: No file name'
	echohl None
	return 0
    endif

    return call('GrepCommands#Grep', [a:count, a:grepCommand, [l:currentFile], a:pattern] + a:000)
endfunction

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :

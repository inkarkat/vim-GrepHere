" GrepHere.vim: List occurrences in the current buffer in the quickfix window.
"
" DEPENDENCIES:
"   - ingo-library.vim plugin
"
" Copyright: (C) 2003-2019 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.

" Maintainer:	Ingo Karkat <ingo@karkat.de>

" Avoid installing twice or when in unsupported Vim version.
if exists('g:loaded_GrepHere') || v:version < 700
    finish
endif
let g:loaded_GrepHere = 1

"- configuration ---------------------------------------------------------------

if ! exists('g:GrepHere_EmptyCommandGrepFlags')
    let g:GrepHere_EmptyCommandGrepFlags = 'g'
endif
if ! exists('g:GrepHere_MappingGrepFlags')
    let g:GrepHere_MappingGrepFlags = 'gj'
endif


"- commands --------------------------------------------------------------------

command! -count -range=% -nargs=? GrepHere    call GrepHere#Grep(<line1>, <line2>, <count>, 'vimgrep', <q-args>)
command! -count -range=% -nargs=? GrepHereAdd call GrepHere#Grep(<line1>, <line2>, <count>, 'vimgrepadd', <q-args>)


"- mappings --------------------------------------------------------------------

nnoremap <silent> <Plug>(GrepHereCurrent)    :<C-u>call GrepHere#List('')<CR>
nnoremap <silent> <Plug>(GrepHereWholeCword) :<C-u>call GrepHere#List(GrepHere#SetCword(1))<CR>
nnoremap <silent> <Plug>(GrepHereCword)      :<C-u>call GrepHere#List(GrepHere#SetCword(0))<CR>
nnoremap <silent> <Plug>(GrepHereWholeCWORD) :<C-u>call GrepHere#List(GrepHere#SetCWORD(1))<CR>
nnoremap <silent> <Plug>(GrepHereCWORD)      :<C-u>call GrepHere#List(GrepHere#SetCWORD(0))<CR>
vnoremap <silent> <Plug>(GrepHereCword)      :<C-u>call GrepHere#List(substitute(ingo#selection#Get(), "\n", '\\n', 'g'))<CR>
if ! hasmapto('<Plug>(GrepHereCurrent)', 'n')
    nmap <A-N> <Plug>(GrepHereCurrent)
endif
if ! hasmapto('<Plug>(GrepHereWholeCword)', 'n')
    nmap <A-M> <Plug>(GrepHereWholeCword)
endif
if ! hasmapto('<Plug>(GrepHereCword)', 'n')
    nmap g<A-M> <Plug>(GrepHereCword)
endif
if ! hasmapto('<Plug>(GrepHereWholeCWORD)', 'n')
    nmap ,<A-M> <Plug>(GrepHereWholeCWORD)
endif
if ! hasmapto('<Plug>(GrepHereCWORD)', 'n')
    nmap g,<A-M> <Plug>(GrepHereCWORD)
endif
if ! hasmapto('<Plug>(GrepHereCword)', 'v')
    vmap <A-M> <Plug>(GrepHereCword)
endif

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
